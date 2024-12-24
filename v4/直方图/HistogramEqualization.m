 % 直方图均衡化
 function res = HistogramEqualization(img)
    [histogram, ~] = computeHistogram(img);
    [h, w] = size(img);
    res = zeros(h, w,'uint8');
    
    %计算累计分布函数
    s=zeros(256,1);
    s(1)=histogram(1);
    for t=2:256
        s(t)=s(t-1)+histogram(t);
    end
    s=s/(w*h);%归一化
    s = round(s * 255); % 映射新的灰度值

    %生成新图像
    for x = 1:w
        for y = 1:h
            res(y, x) = s(img(y, x) + 1);
        end
    end
    
end
