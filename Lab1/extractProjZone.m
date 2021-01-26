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
% Get Zone array dimensions
img_zone = get_zone_array(shape_image, shape_zones);
%assert(size(img_zone) == [


end