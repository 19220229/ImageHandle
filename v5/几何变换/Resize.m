function resize_img = Resize(input,kx,ky)
    [row,col,channel]=size(input);
    new_row=ceil(row*kx);
    new_col=ceil(col*ky);
    resize_img=zeros(new_row,new_col,channel);

    center_x=ceil(new_row/2);
    center_y=ceil(new_col/2);

    for i=1:new_row
        for j=1:new_col
            %得到相对于中心的坐标
            tmp_i=i-center_x;
            tmp_j=j-center_y;

            old_x = tmp_i/ kx+ceil(row/2);  
            old_y = tmp_j / ky+ceil(col/2) ;

        %采用边界延拓，确保取的点在原图像范围内
            x1=max(floor(old_x),1);
            x2=min(ceil(old_x),row);
            y1=max(floor(old_y),1);
            y2=min(ceil(old_y),col);
            if x1>x2 x1=x2;end;
            if y1>y2 y1=y2;end;
        
            P1 = input(x1, y1, :);
            P2 = input(x1, y2, :);
            P3 = input(x2, y1, :);
            P4 = input(x2, y2, :);  

            % 计算 u 和 v
            u = old_x - x1;
            v = old_y - y1;

           for c = 1:channel
                resize_img(i, j, c) = (1-u)*(1-v)*P1(1,1,c) + u*(1-v)*P3(1,1,c) + ...
                                      (1-u)*v*P2(1,1,c) + u*v*P4(1,1,c);
           end

        end
    end
    resize_img=uint8(resize_img);
end

