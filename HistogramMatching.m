function matched_img =HistogramMatching(source_img, template_img)
    % 计算源图像和模板图像的直方图
    [source_hist, ~] = computeHistogram(source_img);
    [template_hist, ~] = computeHistogram(template_img);

    % 计算源图像和模板图像的累积分布函数
    source_cdf = cumsum(source_hist);
    template_cdf = cumsum(template_hist);

    % 构建灰度映射关系
    mapping = zeros(1, 256, 'uint8');
    for gray_level = 0:255
        [~, closest_idx] = min(abs(source_cdf(gray_level + 1) - template_cdf));
        mapping(gray_level + 1) = closest_idx - 1;
    end

    % 应用映射关系
    [rows, cols] = size(source_img);
    matched_img = zeros(rows, cols, 'uint8');
    for i = 1:rows
        for j = 1:cols
            matched_img(i, j) = mapping(source_img(i, j) + 1);
        end
    end
end
