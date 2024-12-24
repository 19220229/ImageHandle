% 理想低通滤波处理单个通道
function g = single_frequence_filter(channel, d0)
    FImg = fftshift(fft2(double(channel)));  
    [N, M] = size(FImg);  
    g = zeros(N, M);  

    r1 = floor(M / 2);
    r2 = floor(N / 2);

    for x = 1:M
        for y = 1:N
            d = sqrt((x - r1)^2 + (y - r2)^2);
            if d <= d0
                h = 1;  
            else
                h = 0;  
            end
            g(y, x) = h * FImg(y, x); 
        end
    end

    g = real(ifft2(ifftshift(g)));
    g = uint8(g);
end
