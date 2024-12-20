%理想低通滤波
function g = frequency_filter(img,d0)
    if size(img, 3) == 3
        [N, M, ~] = size(img);  
        g = zeros(N, M, 3, 'uint8');  
        
        for i = 1:3
            g(:,:,i) = single_frequence_filter(img(:,:,i), d0);
        end
    else
        g = single_channel_filter(img, d0);
    end
end

