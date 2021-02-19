function [database, labels] = make_database(dataset, method, parameters1, parameters2)
% feature extraction using the ZONE projection method and the LBP technique
%
%
    labels = [];
    %display(length(dataset));
    if strcmpi(method, 'ZoneProject')
        nb_columns = prod(parameters1./parameters2)+sum(parameters1./parameters2);
        database = zeros(size(dataset,1),nb_columns);
    elseif strcmpi(method, 'LBP')
        % Calculate number of colums in dataset. This will
        % speed up execution
        nb_columns = ((28/parameters2)^2) * 128; 
        database = zeros(size(dataset,1),nb_columns);
    end
    
    for i = 1:1:length(dataset)  
        tmp = dataset(i, :); % Extract img vector
        %display(i)
        img = make_img_matrix(tmp);
        % Uncomment below to visualize img
        %colormap( gray );
        %imagesc( img );

        if strcmpi(method, 'ZoneProject')
            database(i,:) = extractProjZone(img, parameters1, parameters2);
        elseif strcmpi(method, 'LBP')
            database(i,:) = extractLBP(img, parameters1, parameters2);
        end
    end
end
