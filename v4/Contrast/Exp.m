%指数变换，针对过亮图像
function res = Exp(img)
    img = double(img);
    res=exp(0.325*(img-225)/30)-1;
    res=uint8(mat2gray(res) * 255); 
end

    