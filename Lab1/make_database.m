function [database, labels] = make_database(dataset, method, parameters)
% feature extraction using the ZONE projection method and the LBP technique
%
%
ind = 0; 
database = [];
labels = [];

% Zone projection parameters
shape_image = [60 50];
shape_zones = [5 5];




display(length(dataset))

for i = 1:1:length(dataset)  
    tmp = dataset(i, :); % Extract img vector
    display(i)
    img = make_img_matrix(tmp);
    % Uncomment below to visualize img
    %colormap( gray );
    %imagesc( img );
    
    if strcmpi(method, 'ZoneProject')
        % TO DO
	%
        database = extractProjZone(img, shape_image,shape_zones );
	%
     elseif strcmpi(method, 'LBP')
        % TO DO
	%
        database = extractLBP(img, parameters);
	%
    end
end