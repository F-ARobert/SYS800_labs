% Classification with the baysian method
%

clear all; 
close all;
clc;

fileID=fopen('result.csv','w');

for k=[1000 5000 10000 60000]
    
    %%% Load training dataset 
%     load('reduced_train_database_zone_project');
    load('reduced_train_database_LBP')    
   
    % Slice to the good size and take the good number of features
    reduced_train_database = reduced_train_database(1:k,:)
    train_label = train_label(1:k)
    
    %normalize
    norm = max( reduced_train_database )-min( reduced_train_database )
    data_min = min( reduced_train_database )
    reduced_train_database = (reduced_train_database - data_min) ./ norm
    
    
    [n, m] = size(reduced_train_database)
    
    tic
    %%% Train the model
    mu = zeros(10, m)
    covariance = zeros(10, m, m)
    feature_ind = zeros(10, m)
    % Calculation of the right number of features to keep
    mini = m
    for i= 0:1:9
        train1 = reduced_train_database(train_label(:,1)==i, :)
        
        % Verification of the condition number
        cc = cov(train1)
        [V, D] = eig(cc)
        lambda = diag(D)
        [lambda, ind] = sort(lambda, 'descend')
        ind = ind(lambda>= 10e-5)
        train1 = train1(:,ind)
        
        % Get the minimum in memory to ajustate at the end
        cur = max( size(ind) )
        if cur < mini
            mini = cur
        end
    
        % Calculation of the means
        mu(i+1, 1:cur) = mean(train1, 1)
        % Calculation of the variance
        covariance(i+1,1:cur,1:cur) = cov(train1)
    end
    t_apprentissage = toc
    a = squeeze(covariance(1,:,:))

    %%% Process the covariance matrices individulaly
%     for i= 1:1:10
    i=1
    cc = squeeze(covariance(i,:,:))

    % 3) Calcule des vecteurs propres et des valeurs propres
    [V, D] = eig(cc);

    lambda = diag(D);
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Load testing dataset 
%     load('reduced_test_database_zone_project');
    load('reduced_test_database_LBP');
    %normalize
    test_database_reduced = (test_database_reduced - data_min) ./ norm


    %%% Test the model
    tic
    n = max(size(test_pred))
    for i =1:1:10
        x = test_database_reduced(i,:);
        max_val = 0
        indice = 0
        for j= 1:1:10
            covar = squeeze(covariance(j,:,:))
            d = -log(det(covar)) -(x-mu(j,:))*inv(covar)*(x-mu(j,:)).'
            if d>max_val
                max_val=d
                indice = j
            end
        end
        test_pred(i,1) = indice-1
    end
    t_tes = toc;

    output = sum(test_label(1:n) ~= test_pred)/n;
    
    fprintf(fileID,'%d, %f, %f, %f\n',k, output, t_tes, t_apprentissage);
end

fclose(fileID)