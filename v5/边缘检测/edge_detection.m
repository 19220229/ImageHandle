function res = edge_detection(img,type)
     switch type
         case "robert算子"
             res = Robert(img);
         case "prewitt算子"
             res = Prewitt(img);
         case "sobel算子"
             res = sobel(img);
         case "拉普拉斯算子"
             res = laplacian(img);
     end
     
end

