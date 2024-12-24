function res = salt_noise(img, density)
    [rows, cols, c] = size(img);
    num_pixels = round(density * rows * cols);  

    % 盐噪声（像素值为255）
    salt_pixels = randi([1, rows * cols], [num_pixels, 1]);
    res = double(img);
    res(salt_pixels) = 255;

    % 胡椒噪声（像素值为0）
    pepper_pixels = randi([1, rows * cols], [num_pixels, 1]);
    res(pepper_pixels) = 0;

    res = uint8(res);
end
