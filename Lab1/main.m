%% main file.
%  
%
%
%%

clear all; 
close all;
clc;

energy = 95; % cumulative energy rate
%%
% Load training dataset 
mnisttrain = csvread('mnist_train.csv');
train_data = mnisttrain(:, 2:785);
train_label = mnisttrain(:, 1);



%% 

% Comment this part to use the LBP method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Zone projection method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
method = 'ZoneProject';

% all_img_sizes = [60 50; 100 80];
% all_zone_sizes = [5 5; 10 10];
all_img_sizes = [100 80];
all_zone_sizes = [5 5];

for i = 1:size(all_img_sizes, 1)
    for j = 1:size(all_zone_sizes, 1)
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
%%
number_items_in_vector = zeros(1, size(all_img_sizes,1) ... 
    *size(all_zone_sizes,1));
overlaps = zeros(1, size(all_img_sizes,1) ... 
    *size(all_zone_sizes,1));
length_index = 1;

for i = 1:size(all_img_sizes(1))+1
    for j = 1:size(all_zone_sizes(1))+1
        % Zone projection parameters
        shape_image = all_img_sizes(i,:);
        shape_zones = all_zone_sizes(j,:);
        
        % Load dataset
        load(['size_' num2str(shape_image(1)) 'x' num2str(shape_image(2)) ...
            '_zone_' num2str(shape_zones(1)) 'x' num2str(shape_zones(2)) ...
            '_learning.mat'])
        
        % Get length of vector F
        number_items_in_vector(length_index) = size(database,2);
        
        % Calculate overlap
        %chevauchement(database, train_label)
        overlaps(length_index) = chevauchement(database, train_label);
        length_index = length_index +1;
    end
end

save('Number_features_and_overlap_zone_projection.mat', ...
    'number_items_in_vector', 'overlaps');

%% Comment this section if the zone projection method is used
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               LBP method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
method = 'LBP';
% parameters
% Taille de fenetre
r = [3 5];

% Taille de zones
b = [4 7 14];

for i = 1:numel(r)
    for j = 1:numel(b)
        % II) Feature extraction using LBP
        [database] = make_database(train_data, method , r(i), b(j));
        
        % Save the features in .mat file
        save(['window_' num2str(r(i)) 'x' num2str(r(i)) ...
            '_bloc_' num2str(b(j)) 'x' num2str(b(j)) ...
            '_learning'], 'database', 'train_label');
    end
end
number_items_in_vector = zeros(1,6);
overlaps = zeros(1,6);
length_index = 1;
for i = 1:numel(r)
    for j = 1:numel(b)
        
        % Load dataset
        load(['window_' num2str(r(i)) 'x' num2str(r(i)) ...
            '_bloc_' num2str(b(j)) 'x' num2str(b(j)) ...
            '_learning.mat'])
        
        % Get length of vector F
        number_items_in_vector(length_index) = size(database,2);
        
        % Calculate overlap
        %chevauchement(database, train_label)
        overlaps(length_index) = chevauchement(database, train_label);
        length_index = length_index +1;
    end
end

save('Number_features_and_overlap_LBP.mat', ...
    'number_items_in_vector', 'overlaps');

%% II) feature reduction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Dimensionality reduction using PCA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the principal components
%%
% Zone projection PCA
% Load appropriate database
load('size_100x80_zone_5x5_learning.mat')
[V, G] = acp(database, energy);

reduced_train_database = projection_acp(database,V);
save('reduced_train_database_zone_project', ...
    'reduced_train_database', 'train_label');
%%
% Project the database into the principal components 
% Load test dataset 
mnisttest = csvread('mnist_test.csv');
test_data = mnisttest(:, 2:785);
test_label = mnisttest(:, 1);

% Make full test database
img_sizes = [100 80];
zone_sizes = [5 5];
method = 'ZoneProject';
[test_database] = make_database(test_data, method, img_sizes, zone_sizes);
save(['size_' num2str(img_sizes(1)) 'x' num2str(img_sizes(2)) ...
            '_zone_' num2str(zone_sizes(1)) 'x' num2str(zone_sizes(2)) ...
            '_test'], 'test_database', 'test_label');
%%        
% Reduce test database
test_database_reduced = projection_acp(test_database,V);
save('reduced_test_database_zone_project', ...
    'test_database_reduced', 'test_label');

%%
% LBP PCA
% Load appropriate database
load('window_5x5_bloc_4x4_learning.mat')
[V, G] = acp(database, energy);

reduced_train_database = projection_acp(database,V);
save('reduced_train_database_LBP', ...
    'reduced_train_database', 'train_label');
%
%Project the database into the principal components 
%Load test dataset 
mnisttest = csvread('mnist_test.csv');
test_data = mnisttest(:, 2:785);
test_label = mnisttest(:, 1);

% Make full test database
r=5
b=4
method = 'LBP';
[test_database] = make_database(test_data, method, r, b);
save(['window_' num2str(r) 'x' num2str(r) ...
            '_bloc_' num2str(b) 'x' num2str(b) ...
            '_test'], 'test_database', 'test_label');
%%        
% Reduce test database
test_database_reduced = projection_acp(test_database,V);
save('reduced_test_database_LBP', ...
    'test_database_reduced', 'test_label');

