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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% bayse test

clear all; 
close all;
clc;

fileID = fopen('result.csv','w');
fprintf(fileID,'%s, %s, %s, %s, %s\n', 'method', 'k', 'tx_erreur', 'temps_entrainement', 'temps_test')

%%% Calculation of the errors
method = 'ZoneProject'
for k=[1000, 5000, 10000, 60000]
    [tx_erreur, temps_entrainement, temps_test, test_pred, mini] = bayse_func(k, method)
    fprintf(fileID,'%s, %d, %f, %f, %f, %f\n', method, k, tx_erreur, temps_entrainement, temps_test, mini)
end


method = 'LBP'
for k=[1000, 5000,10000, 60000]
    [tx_erreur, temps_entrainement, temps_test, test_pred, mini] = bayse_func(k, method)
    fprintf(fileID,'%s, %d, %f, %f, %f, %f\n', method, k, tx_erreur, temps_entrainement, temps_test, mini)
end


fclose(fileID)




%%% Calculation of the confusion matrix
k=60000
method = 'ZoneProject'
[tx_erreur, temps_entrainement, temps_test, test_pred, mini] = bayse_func(k, method)

method = 'LBP'
[tx_erreur2, temps_entrainement2, temps_test2, test_pred2, mini2] = bayse_func(k, method)

load('reduced_test_database_zone_project')
C = confusionmat(test_label, test_pred)

load('reduced_test_database_LBP')
C2 = confusionmat(test_label, test_pred2)

writematrix(C,'C.xlsx')
writematrix(C2,'C1.xlsx')

%%%%%%%%%%%%%% Print exemple of not nicelly classified images
% j=1
% for i=1:1:10000
%     if (test_pred(i) ~= test_label(i))
%         indice(j, 1) = i
%         indice(j, 2) = test_pred(i)
%         indice(j, 3) = test_label(i)
%         j = j+1
%     end
% end
% 
% 
% mnisttest = csvread('mnist_test.csv');
% test_data = mnisttest(:, 2:785);
% 
% nb = max(size(indice))
% i = 1
% j = 1
% while i <=4
%     if (indice(j, 3) == 8)   % Vrai label
%         if (indice(j, 2) == 3)  % Prediction
%             to_plot(i) = indice(j, 1)
%             i = i + 1
%         end
%     end
%     j = j+1
% end
% 
% img1 = reshape(test_data(to_plot(1), :), 28, 28).'
% img2 = reshape(test_data(to_plot(2), :), 28, 28).'
% img3 = reshape(test_data(to_plot(3), :), 28, 28).'
% img4 = reshape(test_data(to_plot(4), :), 28, 28).'
% a = subplot(2,2,1); imshow(img1)
% b = subplot(2,2,2); imshow(img2)
% c = subplot(2,2,3); imshow(img3)
% d = subplot(2,2,4); imshow(img4)
%     
% set(a, 'Position', [0 0 0.5 0.5]);
% set(b, 'Position', [0 0.5 0.5 0.5]);
% set(c,'Position', [0.3 0 0.5 0.5]);
% set(d,'Position', [0.3 0.5 0.5 0.5]);
