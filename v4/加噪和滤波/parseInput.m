function params = parseInput(inputString)
    % 将输入字符串按逗号分隔解析为数值数组
    try
        params = str2double(strsplit(inputString, ','));
        if any(isnan(params))
            error('输入包含非数字内容！');
        end
    catch
        error('参数解析失败，请检查输入格式！');
    end
end
