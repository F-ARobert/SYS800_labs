function [database, labels] = make_database(dataset, method, parameters)
% feature extraction using the ZONE projection method and the LBP technique
%
%
ind = 0; 
database = [];
labels = [];

display(length(dataset))
for i = 1:1:length(dataset)  
    tmp = dataset(i, :); % Extract 
    display(i)
    %figure; image(i1');colormap(gray)
    if strcmpi(method, 'ZoneProject')
        % TO DO
	%
        
        database = extractProjZone(img, parameters);
	%
     elseif strcmpi(method, 'LBP')
        % TO DO
	%
        database = extractLBP(img, parameters);
	%
    end
end