function res = salt_noise(img, density)
    [rows, cols, c] = size(img);
    num_pixels = round(density * rows * cols);  
    res = img;
    % 盐噪声
    salt_pixels = randi([1, rows * cols], [num_pixels, 1]);
    res(salt_pixels) = 255;

    % 胡椒噪声
    pepper_pixels = randi([1, rows * cols], [num_pixels, 1]);
    res(pepper_pixels) = 0;

end
