function hogVisImg = HOG_2(img)
    % 图像预处理
    img = rgb2gray(img);
    img = double(img);
    [N, M] = size(img);
    img = sqrt(img); % 校正

    % Sobel算子计算梯度
    Hy = [-1 0 1];
    Hx = Hy';
    Gy = imfilter(img, Hy, 'replicate');
    Gx = imfilter(img, Hx, 'replicate');

    % 计算梯度幅值和方向
    Grad = sqrt(Gx.^2 + Gy.^2); % 梯度幅值
    Phase = atan2d(Gy, Gx); % 计算方向，atan2d 自动处理分母为零的情况
    Phase(Phase < 0) = Phase(Phase < 0) + 180; % 将角度转换到[0, 180)区间

    % HOG参数
    step = 8; % 每个Cell的大小为8x8
    K = 9; % 角度分成9个bins
    angle = 180 / K; % 每个bin的角度范围

    % 为了提高效率，提前预计算并缓存必要的数据
    numCellsX = floor(M / step);
    numCellsY = floor(N / step);
    Cell = cell(numCellsX, numCellsY);

    % 创建用于可视化的图像
    hogVisImg = zeros(size(img));

    % 计算梯度方向直方图
    for i = 1:numCellsX
        for j = 1:numCellsY
            % 每个cell区域的范围
            xStart = (i - 1) * step + 1;
            xEnd = min(i * step, M); % 处理图像边界
            yStart = (j - 1) * step + 1;
            yEnd = min(j * step, N); % 处理图像边界

            % 获取当前区域的梯度值和方向
            Gtmp = Grad(yStart:yEnd, xStart:xEnd);
            angTmp = Phase(yStart:yEnd, xStart:xEnd);

            % 对梯度幅值进行归一化
            Gtmp = Gtmp / sum(Gtmp(:) + eps); 

            % 创建方向直方图
            Hist = zeros(1, K);
            for x = 1:(xEnd - xStart + 1)
                for y = 1:(yEnd - yStart + 1)
                    ang = angTmp(y, x);
                    binIdx = mod(floor(ang / angle), K) + 1; % 修正这里
                    Hist(binIdx) = Hist(binIdx) + Gtmp(y, x);
                end
            end

            % 存储当前cell的特征
            Cell{i, j} = Hist;

            % 可视化当前单元格的梯度
            for k = 1:K
                theta = (k - 0.5) * angle; % 计算当前bin的中心方向
                xCenter = round((xStart + xEnd) / 2);
                yCenter = round((yStart + yEnd) / 2);
                len = Hist(k) * step * 2; % 梯度长度
                dx = len * cosd(theta) / 2;
                dy = len * sind(theta) / 2;

                % 在可视化图像上绘制梯度方向
                x1 = xCenter - dx;
                x2 = xCenter + dx;
                y1 = yCenter - dy;
                y2 = yCenter + dy;
                hogVisImg = insertShape(hogVisImg, 'Line', [x1, y1, x2, y2], 'Color', 'white', 'LineWidth', 1);
            end
        end
    end

    % 合并cell特征，形成最终的HOG特征
    feature = [];
    for i = 1:numCellsX - 1
        for j = 1:numCellsY - 1
            f = [Cell{i, j}(:)' Cell{i, j+1}(:)' Cell{i+1, j}(:)' Cell{i+1, j+1}(:)'];
            f = f / sum(f); % 归一化
            feature = [feature, f]; % 追加到最终特征
        end
    end

    % 显示原始图像和HOG特征图
    figure;
    subplot(1, 2, 1);
    imshow(img,[]);
    title('Original Image');

    subplot(1, 2, 2);
    imshow(hogVisImg, []);
    title('HOG Visualization');
end
