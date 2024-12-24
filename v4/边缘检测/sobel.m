function res = sobel(img)
    img=im2double(img);
    % Sobel 算子核
    Hx = [-1 0 1; -2 0 2; -1 0 1];
    Hy = [1 2 1; 0 0 0; -1 -2 -1];
    
    Ix = imfilter(img, Hx, 'replicate');
    Iy = imfilter(img, Hy, 'replicate');
    res = abs(Ix) +abs(Iy);

end
