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
img = imresize(img, shape_image, 'bilinear');
% Uncomment below to visualize img
% colormap( gray );
% imagesc( img );
%%
% Get empty Zone array (to hole compressed image)
img_compressed = get_zone_array(shape_image, shape_zones);

%%
% Process each zone in the image



end