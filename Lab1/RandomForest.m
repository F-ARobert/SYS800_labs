function [model, results] = RandomForest(method)
% Classification using Random Forest algorithm using TreeBagger
%
% Parameters :
%               Method: string declaring which database to use. Either
%               'LBP' or 'ZoneProject'.


NumTrees = [10 100 500 2000];
MinLeafSize = [2 5 10];

if strcmpi(method, 'ZoneProject')
   load reduced_train_database_zone_project.mat
   NumPredictorsToSample = [5:5:size(reduced_train_database,2)-1];
elseif strcmpi(method, 'LBP')
   load reduced_train_database_LBP.mat
   NumPredictorsToSample = [5:50:size(reduced_train_database,2)-1];
else
    error('Invalid method name');
end

data = zeros(   length(NumTrees)*...
                length(NumPredictorsToSample)*...
                length(MinLeafSize), ...
                5);
row = 1;

for x = 1:length(NumTrees)
    for i = 1:1:length(MinLeafSize)
        for j = 1:length(NumPredictorsToSample)
            tic
            model = TreeBagger(NumTrees(x),reduced_train_database, train_label, ...
                'MinLeafSize', MinLeafSize(i), ...
                'NumPredictorsToSample', NumPredictorsToSample(j), ...
                'OOBPrediction', 'on');
            time = toc;
            
            % Which error do we keep? All of them or only last?
            error = oobError(model);
            
            data(row,:) = [NumTrees(x) NumPredictorsToSample(j) ...
                MinLeafSize(i) time error(end)];
            display(NumTrees(x), NumPredictorsToSample(j), ...
                MinLeafSize(i), time, error(end))
            row = row + 1;
        end
    end
end

headers = {'NumTrees', 'NumPredictors', 'MinLeafSize', 'Time', 'ErrorRate'};
results = [headers;num2cell(data)];

end