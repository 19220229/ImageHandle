function feature= HOG(img)
    img=rgb2gray(img);
    img=double(img);
    [N,M]=size(img);
    img=sqrt(img);%校正
    Hy=[-1 0 1];
    Hx=Hy';
    Gy=imfilter(img,Hy,'replicate');
    Gx=imfilter(img,Hx,'replicate');
    Grad=sqrt(Gx.^2+Gy.^2);%计算梯度
    Phase=zeros(N,M);
    Eps=0.0001;
    for i=1:M
        for j=1:N
            if abs(Gx(j,i))<Eps&&abs(Gy(j,i))<Eps
                Phase(j,i)=270;
            elseif abs(Gx(j,i))<Eps&&abs(Gy(j,i))>Eps
                Phase(j,i)=90
            else
                Phase(j,i)=atan(Gy(j,i)/Gx(j,i))*180/pi;
                if Phase(j,i)<0
                    Phase(j,i)=Phase(j,i)+180;
                end
            end
        end
    end
    step=8;K=9;angle=180/K;
    Cell=cell(1,1);Celli=1;Cellj=1;
    for i = 1:step:M-step+1
        Cellj = 1;
        for j = 1:step:N-step+1
            Gtmp = Grad(j:j+step-1, i:i+step-1);
            Gtmp = Gtmp / sum(sum(Gtmp));
            Hist = zeros(1, K);
            for x = 1:step
                for y = 1:step
                    ang = Phase(j+y-1, i+x-1);
                    if ang <= 180
                        Hist(floor(ang/angle) + 1) = Hist(floor(ang/angle) + 1) + Gtmp(y, x);
                    end
                end
            end
            Cell{Cellj, Celli} = Hist;
            Cellj = Cellj + 1;
        end
        Celli = Celli + 1;
    end

    [CellN,CellM]=size(Cell);
    feature=cell(1,(CellM-1)*(CellN-1));
    for i=1:CellM-1
        for j=1:CellN-1
            f=[];
            f=[f Cell{j,i}(:)' Cell{j,i+1}(:)' Cell{j+1,i}(:)' Cell{j+1,i+1}(:)'];
            f=f./sum(f);
            feature{(i-1)*(CellN-1)+j}=f;
        end
    end



    


    
end

