function [database] = extractProjZone(img,shape_image,shape_zones )
% Feature extraction using ZONE projection method
% Inputs are:
%       img         : Image 
%       shape_image : Shape of images as vector
%       shape_zones : Shape of zones as vector
%
% Ouputs:
%       database: Image caracteristics vector

%%
% First: Need to reshape image to specified dimensions
img = round(imresize(img, shape_image, 'bilinear'));
% Uncomment below to visualize img
% colormap( gray );
% imagesc( img );
%%
% Get empty Zone array (to hole compressed image)
img_zoned = get_zone_array(shape_image, shape_zones);

%%
% Process each zone in the image

% Split image into sub arrays
img_split = mat2cell(img, repelem(shape_zones(1), size(img_zoned,1)), ...
        repelem(shape_zones(2), size(img_zoned,2)));

for i = 1:size(img_split,1)
    for j = 1:size(img_split,2)
        h = sum(img_split{i,j});
        h = int16(h);
        img_zoned(i,j) = mean(h);
    end
end

% Uncomment below to visualize img_zoned
colormap( gray );
imagesc( img_zoned );
%%
% Vectorize

end