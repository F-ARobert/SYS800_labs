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

[model, results] = RandomForest(method);
%%
% LBP method
method = 'LBP';

[model, results] = RandomForest(method);

%%
