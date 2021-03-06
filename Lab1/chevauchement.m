function output = chevauchement(database,labels)
% output = overlap_v2(database,labels)
%    data => [nb_features,nb_samples]
%    labels => [1,nb_samples];
database = database';
labels = labels';
[nb_features,nb_samples] = size(database);
% %% FOR TESTING
% nb_samples = nb_samples/100;
% labels = labels(1:nb_samples);
% %%

decision = zeros(1,nb_samples);

for i=1:nb_samples
    index_prototypes = [(1:i-1) (i+1:nb_samples)];
    prototypes = database(:,index_prototypes); % dataset without the test_sample
    test_sample = database(:,i);
    distances = sqrt(sum((prototypes - test_sample*ones(1,nb_samples-1)).^2));
    [distance_nn,index_nn] = min(distances);
    decisions(i) = labels(index_prototypes(index_nn));
end
output = sum(labels ~= decisions)/nb_samples;
end
