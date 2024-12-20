%线性变换
function res = Linear_my(img)
    alpha=60;
    img = double(img); 
    res = tand(alpha).*img;
    res=uint8(mat2gray(res) * 255); 
end