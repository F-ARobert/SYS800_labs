% Main file for Lab 2
%
%
%
clear all; 
close all;
clc;

%%
% Random Forest hyperparameter testing
% Zone Project method
method = 'ZoneProject';

[~, results] = RandomForest(method);

%% Suite aux tests, on retient ces paramètres pour la projection de zone
load reduced_train_database_zone_project.mat
NumTrees = 500;
MinLeafSize = 2;
NumPredictorsToSample = 5;
RF_model_ZP = TreeBagger(NumTrees,reduced_train_database, train_label, ...
                'MinLeafSize', MinLeafSize, ...
                'NumPredictorsToSample', NumPredictorsToSample, ...
                'OOBPrediction', 'on', ...
                'Options', statset('UseParallel',true));
%%
% LBP method
method = 'LBP';

[~, results] = RandomForest(method);

%% Suite aux tests, on retient ces paramètres pour la projection de zone
load reduced_train_database_LBP.mat
NumTrees = 1000;
MinLeafSize = 2;
NumPredictorsToSample = 5;
RF_model_LBP = TreeBagger(NumTrees,reduced_train_database, train_label, ...
                'MinLeafSize', MinLeafSize, ...
                'NumPredictorsToSample', NumPredictorsToSample, ...
                'OOBPrediction', 'on', ...
                'Options', statset('UseParallel',true));
%% Test both models
load reduced_test_database_zone_project.mat

ZP_fit = RF_model_ZP.predict(test_database_reduced);
ZP_fit = str2num(cell2mat(ZP_fit));

c_zp = confusionmat(test_label,ZP_fit);
%%
load reduced_test_database_LBP.mat

LBP_fit = RF_model_LBP.predict(test_database_reduced);
LBP_fit = str2num(cell2mat(LBP_fit));

c_lbp = confusionmat(test_label,LBP_fit);

