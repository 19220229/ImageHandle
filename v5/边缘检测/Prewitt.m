function res = Prewitt(img)
    img=im2double(img);
    % Prewitt 算子核
    Hx = [-1 0 1; -1 0 1; -1 0 1];
    Hy = [1 1 1; 0 0 0; -1 -1 -1];
    
    Ix = imfilter(img, Hx, 'replicate');
    Iy = imfilter(img, Hy, 'replicate');
    res = abs(Ix) +abs(Iy);

end
