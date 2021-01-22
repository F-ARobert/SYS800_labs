function img = make_img_matrix(image_vector)
% Function to reshape image vecotr into 28x28 pixel matrix.
% Function aslo flips the image left to right so as to form a readable
% character image.
% Inputs:
%       image: Image vector containing 784 grayscale values (28x28)
%
% Outputs:
%       img: Image in 28x28 format

img = reshape( image_vector, [28,28] );
img = rot90( img, 3 );
img = fliplr(img);

end