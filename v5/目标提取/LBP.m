function lbp = LBP(img)
    img=rgb2gray(img);
    [N,M]=size(img);
    lbp=zeros(N,M);
    for j=2:N-1
        for i=2:M-1
            neighbor = [j-1 i-1;j-1 i;j-1 i+1; j i+1;j+1 i+1;j+1 i; j+1 i-1;j i-1];
            count = 0;
            for k = 1:8
                if img(neighbor(k,1),neighbor(k,2))>img(j,i)
                    count = count + 2^(8-k);
                end
            end
            lbp(j,i)=count;
        end
    end
    lbp=uint8(lbp);
end

