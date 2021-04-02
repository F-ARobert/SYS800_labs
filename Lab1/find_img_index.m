function [index] = find_img_index(real, predicted, labels, predictions)
index = [];
j = 1;
for i = 1:length(labels)
    if labels(i) == real 
        if predictions(i) == predicted
            index(j) = i;
            j = j+1;
        end
    end
end