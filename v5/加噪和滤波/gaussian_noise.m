function res = gaussian_noise(img, mean, var)
    [m, n, c] = size(img);
    res = im2double(img);

    for i = 1:c
        noise = mean + sqrt(var) * randn(m, n); 
        res(:,:,i) = res(:,:,i) + noise;       
    end
    
    res = max(min(res, 1), 0);
    res = im2uint8(res);
end