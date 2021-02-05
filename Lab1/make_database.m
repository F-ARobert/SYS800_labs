function [database, labels] = make_database(dataset, method, parameters1, parameters2)
% feature extraction using the ZONE projection method and the LBP technique
%
%
labels = [];
%display(length(dataset));

for i = 1:1:length(dataset)  
    tmp = dataset(i, :); % Extract img vector
    %display(i)
    img = make_img_matrix(tmp);
    % Uncomment below to visualize img
    %colormap( gray );
    %imagesc( img );
    
    if strcmpi(method, 'ZoneProject')
        nb_columns = prod(parameters1./parameters2)+sum(parameters1./parameters2);
        database = zeros(size(dataset,1),nb_columns);
        %display(size(database))
        database(i,:) = extractProjZone(img, parameters1, parameters2);
	%
     elseif strcmpi(method, 'LBP')
        % TO DO

        % ADD: method to calculate number of colums in dataset. This will
        % speed up execution
        database = [];
        database(i) = extractLBP(img, parameters1, parameters2);
	%
    end
end
