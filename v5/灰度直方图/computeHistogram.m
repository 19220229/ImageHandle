% 计算灰度直方图
function [histogram, gray_levels] = computeHistogram(img)
    [rows, cols] = size(img);
    histogram = zeros(1,256);
    gray_levels = 0:255;
    
    for i = 1:rows
        for j = 1:cols
            histogram(img(i, j) + 1) = histogram(img(i, j) + 1) + 1;
        end
    end

end