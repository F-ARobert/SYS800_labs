function display_images(index, database, number_to_show)

images = database(:, 2:785);
m = 2;
n = ceil(number_to_show/2);

for i = 1:number_to_show
    j = images(index(i),:);
    img = make_img_matrix(j);
    
    subplot(n,m,i), imshow(img);
    
end
end