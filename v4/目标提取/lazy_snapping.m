function res =lazy_snapping(img)
    L=superpixels(img,500);
    figure;imshow(img);
    ho=drawfreehand;
    foreground=createMask(ho,img);
    hb=drawfreehand;
    background=createMask(hb,img);
    BW=lazysnapping(img,L,foreground,background);
    
    mask=cat(3,BW,BW,BW);
    
    res=uint8(mask).*img;
end

