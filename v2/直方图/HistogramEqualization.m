function res = HistogramEqualization(img)
    % 实现直方图均衡化
    [histogram, ~] = computeHistogram(img);
    cdf = cumsum(histogram); % 累积分布函数
    
    % 映射原灰度值
    mapping = round(cdf * 255);
    [rows, cols] = size(img);
    res = zeros(rows, cols, 'uint8');
    
    for i = 1:rows
        for j = 1:cols
            res(i, j) = mapping(img(i, j) + 1);
        end
    end
end
