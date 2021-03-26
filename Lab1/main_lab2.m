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
ZP_fit = uint8(str2num(cell2mat(ZP_fit)));


zp_results = [ZP_fit test_label];
zp_errors = [0 0 0];
j = 1;
for i = 1:length(zp_results)
    if zp_results(i,1) == zp_results(i,2)
        zp_results(i,3) = 1;
    else
        zp_results(i,3) = 0;
        zp_errors(j,:) = zp_results(i,:);
        j = j+1;
    end
end
%%
y1 = hist(zp_errors(:,1), unique(zp_errors(:,1)));
y2 = hist(zp_errors(:,2), unique(zp_errors(:,2)));
x = 0:9;
plot(x,y1,'o',x,y2,'x');
legend('True labels', 'Predicted labels');
xlabel('Label'), ylabel('Nombre'), title('Erreurs de classifications');
axis([-1 10 0 70]);
%%
c_zp = confusionmat(zp_results(:,1),zp_results(:,2));
%%
load reduced_test_database_LBP.mat

LBP_fit = RF_model_LBP.predict(test_database_reduced);
LBP_fit = uint8(str2num(cell2mat(LBP_fit)));


lbp_results = [LBP_fit test_label];
lbp_errors = [0 0 0];
j = 1;
for i = 1:length(lbp_results)
    if lbp_results(i,1) == lbp_results(i,2)
        lbp_results(i,3) = 1;
    else
        lbp_results(i,3) = 0;
        lbp_errors(j,:) = lbp_results(i,:);
        j = j+1;
    end
end

y1 = hist(lbp_errors(:,1), unique(lbp_errors(:,1)));
y2 = hist(lbp_errors(:,2), unique(lbp_errors(:,2)));
x = 0:9;
plot(x,y1,'o',x,y2,'x');
legend('True labels', 'Predicted labels');
xlabel('Label'), ylabel('Nombre'), title('Erreurs de classifications');
axis([-1 10 0 70]);

c_lbp = confusionmat(lbp_results(:,1),lbp_results(:,2));
