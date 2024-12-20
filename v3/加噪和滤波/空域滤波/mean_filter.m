function res = mean_filter(img, window_size)
    % 获取图像大小和窗口半径
    [rows, cols, channels] = size(img);
    radius = floor(window_size / 2);
    
    % 初始化输出图像
    res = zeros(size(img), 'uint8');
    
    % 遍历每个像素
    for c = 1:channels  % 对每个通道分别处理
        for i = 1:rows
            for j = 1:cols
                % 确定窗口边界
                r_min = max(1, i - radius);
                r_max = min(rows, i + radius);
                c_min = max(1, j - radius);
                c_max = min(cols, j + radius);
                
                % 提取局部窗口
                local_window = img(r_min:r_max, c_min:c_max, c);
                
                % 计算窗口内像素均值
                res(i, j, c) = mean(local_window(:));
            end
        end
    end
end
