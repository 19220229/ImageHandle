function res = HistogramMatching(source_img, template_img)
    % 计算源图像和模板图像的直方图
    [source_hist, ~] = computeHistogram(source_img);
    [template_hist, ~] = computeHistogram(template_img);

    % 计算源图像和模板图像的累积分布函数（CDF）
    s1 = zeros(256, 1);
    s1(1) = source_hist(1);
    for t = 2:256
        s1(t) = s1(t-1) + source_hist(t);
    end
    s1 = s1 / sum(source_hist); % 归一化

    s2 = zeros(256, 1);
    s2(1) = template_hist(1);
    for t = 2:256
        s2(t) = s2(t-1) + template_hist(t);
    end
    s2 = s2 / sum(template_hist); % 归一化

    % 构建灰度映射关系
    mapping = zeros(1, 256, 'uint8');
    for idx = 1:256
        % 找到原始灰度级在匹配图中对应的灰度值
        [value, min_idx] = min(abs(s2 - s1(idx)));
        mapping(idx) = min_idx - 1;
    end

    % 应用映射关系
    [H W]=size(source_img);
    res = zeros(H,W,'uint8');
    for i = 1:H
        for j = 1:W
            res(i,j) = mapping(source_img(i,j)+1);    
        end
    end
    
end


