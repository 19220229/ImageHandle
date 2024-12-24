img=imread("D:\课程文件\大三上\图像处理\image\lena.png");
res=LBP(img);
res2=HOG_2(img);
img=rgb2gray(img);
subplot(1,3,1),imshow(img);
subplot(1,3,2),imshow(res);
subplot(1,3,3),imshow(res2);