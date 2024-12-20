function res = laplacian(img)
    img=im2double(img);
    % 拉普拉斯 算子核
    H = [0 -1 0; -1 4 -1; 0 -1 0];
    
    res = imfilter(img, H, 'replicate');
    res=abs(res);
    
end

