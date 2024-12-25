
function res = mean_filter(img, window_size)
    [rows, cols, channels] = size(img);
    radius = floor(window_size / 2);  
    res = zeros(size(img), 'uint8');
    for c = 1:channels  
        for i = 1:rows
            for j = 1:cols
                % 确定窗口边界
                r_min = max(1, i - radius);
                r_max = min(rows, i + radius);
                c_min = max(1, j - radius);
                c_max = min(cols, j + radius);
                local_window = img(r_min:r_max, c_min:c_max, c);%局部窗口
                res(i, j, c) = mean(local_window(:));
            end
        end
    end
end
