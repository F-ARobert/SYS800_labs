function [tx_erreur, temps_entrainement, temps_test, test_pred, mini] = bayse_func(k, method)
% Classify the test dataset with a model trained on the reduced train data
% Detailed explanation goes here

    if strcmpi(method, 'ZoneProject')
        load('reduced_train_database_zone_project')
        load('reduced_test_database_zone_project')

        % Slice to the good size and take the good number of features
        reduced_train_database = reduced_train_database(1:k,:)
        train_label = train_label(1:k)

        
    elseif strcmpi(method, 'LBP')
        load('reduced_train_database_LBP')
        load('reduced_test_database_LBP')
        
        % Slice to the good size and take the good number of features
        reduced_train_database = reduced_train_database(1:k,:)
        train_label = train_label(1:k)

    end
    
    [n, m] = size(reduced_train_database)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Verification of the condition number >10e-3 fot each class group
    mini = m
    for i= 0:1:9
        train1 = reduced_train_database(train_label(:,1)==i, :)
        
        cc = cov(train1)
        [V, D] = eig(cc)
        lambda = diag(D)
%         [lambda, ind] = sort(lambda, 'descend')
        ind = (lambda/lambda(end) >= 10e-3)
        
        cur = sum(ind)
        if cur < mini
            mini = cur
        end
    end
    

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Model training
    tic
    mu = zeros(10, mini)
    covariance = zeros(10, mini, mini)
    feature_ind = zeros(10, mini);
    
    for i= 0:1:9
        train1 = reduced_train_database(train_label(:,1)==i, 1:mini)
        
        % Calculation of the means
        mu(i+1, :) = mean(train1, 1)
        % Calculation of the variance
        covariance(i+1,:,:) = cov(train1)
    end
    t_apprentissage = toc
 

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Test the model
    tic
    n = max(size(test_label))
%     n=100
    for i =1:1:n
        x = test_database_reduced(i,1:mini);
        max_val = -Inf
        indice = 1
        for j= 1:1:10
            cc = squeeze(covariance(j,:,:));
            d = -log(det(cc)) -(x-mu(j,:))*inv(cc)*(x-mu(j,:)).'
            if d>max_val
                max_val = d
                indice = j
            end
        end
        test_pred(i,1) = indice-1
    end
    t_test = toc

    output = sum(test_label(1:n) ~= test_pred)/n
    
    
    tx_erreur = output
    temps_entrainement = t_apprentissage
    temps_test = t_test
    
end

