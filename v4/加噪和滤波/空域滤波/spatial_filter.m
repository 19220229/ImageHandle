 %空域滤波
function res = spatial_filter(img, filter_type, filter_params)

    switch filter_type
        case "均值滤波"
            res = mean_filter(img, filter_params(1));
        
        case "中值滤波"
            res = median_filter(img, filter_params(1));
            
        case "双边滤波"
            res = bilateral_filter(img,filter_params(1), filter_params(2));
        otherwise
            error('Unknown filter type');
    end
end