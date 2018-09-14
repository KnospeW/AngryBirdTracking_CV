file_path = './RGB_frames';
img_path_list=dir([file_path './*.jpg']);%?????????jpg?????,????????data,name???  
img_num=length(img_path_list);%???????  
for k = 1:img_num
    thisFileName = fullfile(img_path_list(k).folder, img_path_list(k).name);
    RGB_image = imread(thisFileName);
    HSV_image = rgb2hsv(RGB_image);
    fprintf('%s\n',img_path_list(k).name);%??????????  
    baseFileName = sprintf('%s', img_path_list(k).name); % e.g. "1.jpg"
    fullFileName = fullfile('./HSV_frames', baseFileName); 
    imwrite(HSV_image,fullFileName);
end
    