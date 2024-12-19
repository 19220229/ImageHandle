%对数变换,处理过暗图像
function res = Log(img)
    img = double(img);
    res = log(1 + img);
    res=uint8(mat2gray(res) * 255); 
end
