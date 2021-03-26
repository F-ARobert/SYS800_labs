% Main file for Lab 2
%
%

clear all; 
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% bayse test

fileID = fopen('result.csv','w');
fprintf(fileID,'%s, %s, %s, %s, %s\n', 'method', 'k', 'tx_erreur', 'temps_entrainement', 'temps_test')


% k=1000
method = 'ZoneProject'
for k=[1000, 5000,10000, 60000]
    [tx_erreur, temps_entrainement, temps_test, test_pred, mini] = bayse_func(k, method)
    fprintf(fileID,'%s, %d, %f, %f, %f, %f\n', method, k, tx_erreur, temps_entrainement, temps_test, mini)
end


method = 'LBP'
for k=[1000, 5000,10000, 60000]
    [tx_erreur, temps_entrainement, temps_test, test_pred, mini] = bayse_func(k, method)
    fprintf(fileID,'%s, %d, %f, %f, %f, %f\n', method, k, tx_erreur, temps_entrainement, temps_test, mini)
end


fclose(fileID)

%%
