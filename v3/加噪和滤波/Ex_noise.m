function res = Ex_noise(img, a)
   [rows, cols, c] = size(img);
    res=im2double(img);
    res =res+(-a) * log(1 - rand(rows, cols, c));
    
    res = max(min(res, 1), 0);
    res = im2uint8(res);
end
