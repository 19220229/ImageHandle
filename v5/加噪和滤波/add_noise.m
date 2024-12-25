function res = add_noise(img, noise_type, noise_params)
    switch noise_type
        case "高斯噪声"
            mean = noise_params(1);
            var = noise_params(2);
            res = gaussian_noise(img, mean, var);
        
        case "椒盐噪声"
            a = noise_params(1);
            res = salt_noise(img, a);
      
        otherwise
            error('Unknown noise type');
    end
end
