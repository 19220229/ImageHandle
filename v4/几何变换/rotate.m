%采用双线性插值和后映射法
function rotate_img=rotate(input,angle)
    [row,col,channel]=size(input);
    theta=deg2rad(angle);

    %确定旋转后新图像的尺寸
    Max_x=max(max(cos(theta)*(row-1),cos(theta)*(row-1)+sin(theta)*(col-1)), ...
              max(sin(theta)*(col-1),0));
    Min_x=min(min(cos(theta)*(row-1),cos(theta)*(row-1)+sin(theta)*(col-1)), ...
              min(sin(theta)*(col-1),0));
    Max_y=max(max(-1*sin(theta)*(row-1),-1*sin(theta)*(row-1)+cos(theta)*(col-1)), ...
              max(cos(theta)*(col-1),0));
    Min_y=min(min(-1*sin(theta)*(row-1),-1*sin(theta)*(row-1)+cos(theta)*(col-1)), ...
              min(cos(theta)*(col-1),0));
    
    new_row=ceil(Max_x-Min_x+1);
    new_col=ceil(Max_y-Min_y+1);
    rotate_img=zeros(new_row,new_col,channel);

    %图像中心
    center_x = ceil(new_row / 2);
    center_y = ceil(new_col / 2);

    %坐标变换、后映射
    for i=1:new_row
        for j=1:new_col
            % 以图像中心为基准进行旋转
            tmp_x = i - center_x;
            tmp_y = j - center_y;
            %原始图像中对应的坐标点
            old_x=cos(theta)*tmp_x-sin(theta)*tmp_y+row/2;
            old_y=sin(theta)*tmp_x+cos(theta)*tmp_y+col/2;

            if old_x>=0&&old_x<=row+1&&old_y>=0&&old_y<=col+1
                x1=floor(old_x);
                x2=ceil(old_x);
                y1=floor(old_y);
                y2=ceil(old_y);
               
                P1 = zeros(1, 1, channel);
                P2 = zeros(1, 1, channel);
                P3 = zeros(1, 1, channel);
                P4 = zeros(1, 1, channel);
                if x1 >= 1 && x1 <= row && y1 >= 1 && y1 <= col
                    P1 = input(x1, y1, :);  % 左上角点
                end
                if x1 >= 1 && x1 <= row && y2 >= 1 && y2 <= col
                    P2 = input(x1, y2, :);  % 左下角点
                end
                if x2 >= 1 && x2 <= row && y1 >= 1 && y1 <= col
                    P3 = input(x2, y1, :);  % 右上角点
                end
                if x2 >= 1 && x2 <= row && y2 >= 1 && y2 <= col
                    P4 = input(x2, y2, :);  % 右下角点
                end
                u = old_x - x1;
                v = old_y - y1;

               for c = 1:channel
                    rotate_img(i, j, c) =  (1-u)*(1-v)*P1(1,1,c) + (1-u)*v*P2(1,1,c) + ...
                                             u*(1-v)*P3(1,1,c) + u*v*P4(1,1,c);
               end
            end
        end
    rotate_img=uint8(rotate_img);
end





