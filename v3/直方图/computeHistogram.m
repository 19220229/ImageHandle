function [histogram, gray_levels] = computeHistogram(img)
    % 计算灰度直方图
    [rows, cols] = size(img);
    histogram = zeros(1, 256);
    gray_levels = 0:255;
    
    for i = 1:rows
        for j = 1:cols
            pixel_value = img(i, j);
            histogram(pixel_value + 1) = histogram(pixel_value + 1) + 1;
        end
    end
    
    histogram = histogram / (rows * cols); % 归一化
end