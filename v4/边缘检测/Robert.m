function res = Robert(img)
    img=im2double(img);
    % Robert算子
    Hx = [1 0; 0 -1];
    Hy = [0 1; -1 0];
    
    Ix = imfilter(img, Hx, 'replicate');
    Iy = imfilter(img, Hy, 'replicate');
    res = abs(Ix) +abs(Iy);

    

end

