function emtpy_zone_array = get_zone_array(shape_image, shape_zones)
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
z_dim = uint16(shape_image)./uint16(shape_zones);
% Tests for right shape
assert(isa(z_dim(1),'uint16'), 'z_dim(1) is not an unsigned integer');

if shape_image(1) == 60
    if shape_zones(1) == 5
        assert((z_dim(1) == 12),'z_dim(1) not equal 12');
    elseif shape_zones(1) == 10
        assert((z_dim(1) == 6),'z_dim(1) not equal 6');
    end
elseif shape_image(1) == 100
    if shape_zones(1) == 5
        assert((z_dim(1) == 20),'z_dim(1) not equal 20');
    elseif shape_zones(1) == 10
        assert((z_dim(1) == 10),'z_dim(1) not equal 10');
    end
else
    assert(1==0,'Other error occured in z_dim(1)');
end

% Tests for right shape
assert(isa(z_dim(2),'uint16'), 'z_dim(2) is not an unsigned integer');
if shape_image(2) == 50
    if shape_zones(2) == 5
        assert((z_dim(2) == 10), 'z_dim(2) not equal 10');
    elseif shape_zones(2) == 10
        assert((z_dim(2) == 5),'z_dim(2) not equal 5');
    end
elseif shape_image(2) == 80
    if shape_zones(2) == 5
        assert((z_dim(2) == 16),'z_dim(2) not equal 16');
    elseif shape_zones(2) == 10
        assert((z_dim(2) == 8),'z_dim(2) not equal 8');
    end
else
    assert(1==0,'Other error occured in z_dim(2)');
end

emtpy_zone_array = zeros(z_dim,'uint16');
assert(size(emtpy_zone_array, 1) == z_dim(1));
assert(size(emtpy_zone_array, 2) == z_dim(2));
end
