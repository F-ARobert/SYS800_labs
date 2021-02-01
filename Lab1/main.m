%% main file.
%  
%
%
%%

clear all; 
close all;
clc;

energy = 95; % cumulative energy rate

% Load training dataset 
mnisttrain = csvread('mnist_train.csv');
train_data = mnisttrain(:, 2:785);
train_label = mnisttrain(:, 1);

% Load test dataset 
% mnisttest = csvread('mnist_test.csv');
% test_data = mnisttest(:, 2:785);
% test_label = mnisttest(:, 1);

%% 
% Comment this part to use the LBP method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Zone projection method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
method = 'ZoneProject';
% parameters:
all_img_sizes = [60 50; 100 80];
all_zone_sizes = [5 5; 10 10];

for i = 1:size(all_img_sizes(1))+1
    for j = 1:size(all_zone_sizes(1))+1
        % Zone projection parameters
        shape_image = all_img_sizes(i,:);
        shape_zones = all_zone_sizes(j,:);
        % I) Feature extraction using ZONE
        [database] = make_database(train_data, method, shape_image, shape_zones);
        % Save the features in .mat file
        save(['size_' num2str(shape_image(1)) 'x' num2str(shape_image(2)) ...
            '_zone_' num2str(shape_zones(1)) 'x' num2str(shape_zones(2)) ...
            '_learning'], 'database', 'train_label');
    end
end

%% Comment this section if the zone projection method is used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               LBP method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TO DO ...... 
% method = 'LBP';
% parameters
% 
% II) Feature extraction using LBP
% [database] = make_database(train_data, method , parameters);
% % Sauvegarder l'information dans un fichier .mat
% save(['lbp_' num2str(nb_p) '_learning'], 'database', 'train_label');


%% II) feature reduction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Dimensionality reduction using PCA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the principal components
[V, G] = acp(database, energy);

% TO DO 
% Project the database into the principal components 


