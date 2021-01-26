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
z_rows = uint16(round(shape_image(1)/shape_zones(1), 0));
% Tests for right shape
assert(isa(z_rows,'uint16'), 'z_rows is not an unsigned integer');

if shape_image(1) == 60
    if shape_zones(1) == 5
        assert((z_rows == 12),'z_rows not equal 12');
    elseif shape_zones(1) == 10
        assert((z_rows == 6),'z_rows not equal 6');
    end
elseif shape_image(1) == 100
    if shape_zones(1) == 5
        assert((z_rows == 20),'z_rows not equal 20');
    elseif shape_zones(1) == 10
        assert((z_rows == 10),'z_rows not equal 10');
    end
else
    assert(1==0,'Other error occured in z_rows');
end

z_cols = uint16(round(shape_image(2)/shape_zones(2),0));
% Tests for right shape
assert(isa(z_cols,'uint16'), 'z_cols is not an unsigned integer');
if shape_image(2) == 50
    if shape_zones(2) == 5
        assert((z_cols == 10), 'z_cols not equal 10');
    elseif shape_zones(2) == 10
        assert((z_cols == 5),'z_cols not equal 5');
    end
elseif shape_image(2) == 80
    if shape_zones(2) == 5
        assert((z_cols == 16),'z_cols not equal 16');
    elseif shape_zones(2) == 10
        assert((z_cols == 8),'z_cols not equal 8');
    end
else
    assert(1==0,'Other error occured in z_cols')
end

end