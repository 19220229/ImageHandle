%线性变换
function res = Linear_my(img)
    a=10;b=10000;
    img=im2double(img);
    res=a*img+b;
    
    res=uint8(mat2gray(res)*255); 
end