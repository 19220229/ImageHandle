
function res = median_filter(img, window_size)
    [rows, cols, channels] = size(img);
    window = floor(window_size / 2);
    res = zeros(size(img), 'uint8');
    for c = 1:channels
        for i = 1:rows
            for j = 1:cols
                r_min = max(1, i - window);
                r_max = min(rows, i + window);
                c_min = max(1, j - window);
                c_max = min(cols, j + window);
                local_window = img(r_min:r_max, c_min:c_max, c);
                res(i, j, c) = median(local_window(:));
            end
        end
    end
end
