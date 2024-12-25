function res = bilateral_filter(image, sigma_s, sigma_r)
    img = im2double(image);
    [rows, cols, channels] = size(img);
    res = zeros(size(img));
    half_window = ceil(3 * sigma_s);

    %计算空间权重
    [x, y] = meshgrid(-half_window:half_window, -half_window:half_window);%生成二维的网格坐标矩阵
    s_weight = exp(-(x.^2 + y.^2) / (2 * sigma_s^2));
    
    for ch = 1:channels
        for i = 1:rows
            for j = 1:cols
                % 滤波窗口
                i_min = max(i - half_window, 1);
                i_max = min(i + half_window, rows);
                j_min = max(j - half_window, 1);
                j_max = min(j + half_window, cols);
                region = img(i_min:i_max, j_min:j_max, ch);
                
                % 计算强度权重
                intensity_diff = region - img(i, j, ch);
                r_weight = exp(-(intensity_diff.^2) / (2 * sigma_r^2));
                
                % 组合权重
                combined_weight = s_weight((i_min:i_max) - i + half_window + 1, ...
                                                 (j_min:j_max) - j + half_window + 1) ...
                                  .* r_weight;
                
                % 应用双边滤波
                res(i, j, ch) = sum(region(:) .* combined_weight(:)) / sum(combined_weight(:));
            end
        end
    end
  
end


