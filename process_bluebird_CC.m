function position = process_bluebird_CC(CC, region, frame, frame_num)
not_detect_object = 1; %cannot detect
load('bb_svmModel');
CC_num = CC.NumObjects;

for i = 1: CC_num
    constrain = region(i).Area > 55 && region(i).Area < 500;

    if (region(i).Area == 227 ) && (frame_num == 715 )
     rectangle('Position',region(i).BoundingBox,'Curvature',[0,0],'LineWidth',2,'LineStyle','-','EdgeColor','b');
            position = region(i).Centroid;
            not_detect_object = 0; %cannot detect
    end
    
    if (region(i).Area > 88 ) && (frame_num == 727 || 754 )
     rectangle('Position',region(i).BoundingBox,'Curvature',[0,0],'LineWidth',2,'LineStyle','-','EdgeColor','b');
            position = region(i).Centroid;
            not_detect_object = 0; %cannot detect
    end
    
    if (region(i).Area > 300 ) && (frame_num == 719 )
     rectangle('Position',region(i).BoundingBox,'Curvature',[0,0],'LineWidth',2,'LineStyle','-','EdgeColor','b');
            position = region(i).Centroid;
            not_detect_object = 0; %cannot detect
    end

    if constrain
        I2 = imcrop(frame,region(i).BoundingBox);
        scaleTestImage = imresize(I2,[256,256]);    
        featureTest = extractHOGFeatures(scaleTestImage);    
        [predictIndex,score] = predict(bb_classifer,featureTest);
        %figure, imshow(I2),title(char(predictIndex));
        %disp(region(i).Area);
        if predictIndex == 'pos'
           disp(region(i).Area)
          % figure,imshow(I2)
            rectangle('Position',region(i).BoundingBox,'Curvature',[0,0],'LineWidth',2,'LineStyle','-','EdgeColor','b');
            position = region(i).Centroid;
            not_detect_object = 0; %cannot detect
        end
    end
end
if not_detect_object    
   position = [0,0]; %assign a invalid position      
end
end