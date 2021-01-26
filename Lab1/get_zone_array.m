function [emtpy_zone_array] = get_zone_array(shape_image, shape_zones)
% Function returns empty array representing the image diced into zones of
% specified shape
%
% Inputs:
%       shape_image: Shape of original image
%       shape_zones : Shape of eahc individual zones
%
% Output:
%       empty_zone_array: Array representing the original image diced into
%       zones of specified size

% Get dimensions
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
    assert(1==0,'Other error occured in z_cols');
end

emtpy_zone_array = zeros(z_rows,z_cols,'uint16');
assert(size(emtpy_zone_array, 1) == z_rows);
assert(size(emtpy_zone_array, 2) == z_cols);
end
