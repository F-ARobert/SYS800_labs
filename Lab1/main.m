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
% TO DO .....
% method = 'ZoneProject';
% % parameters: 
% parameters = 1;
% % I) Feature extraction using ZONE
% [database] = make_database(train_data, method ,parameters);
% % Save the features in .mat file
% save(['zone_' num2str(img_m) 'x' num2str(img_m) '_learning'], 'database', 'train_label');

%% Comment this section if the zone projection method is used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               LBP method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TO DO ...... 
method = 'LBP';
% parameters
% Taille de fenetre
r = [3 5];

% Taille de zones
b = [4 7 14];

% II) Feature extraction using LBP
[database] = make_database(train_data, method , parameters);
% Sauvegarder l'information dans un fichier .mat
save(['lbp_' num2str(nb_p) '_learning'], 'database', 'train_label');


%% II) feature reduction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Dimensionality reduction using PCA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the principal components
[V, G] = acp(database, energy)

% TO DO 
% Project the database into the principal components 


