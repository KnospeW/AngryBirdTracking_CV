obj = VideoReader('video.mp4');
numFrames = obj.NumberOfFrames;% number of frames
 for k = 1 : numFrames
     frame = readFrame(obj,k);
     imwrite(frame,strcat(num2str(k),'.jpg'),'jpg');
     %baseFileName = sprintf('%s', k);
     %fullFileName = fullfile('./new', baseFileName); 
     %imwrite(frame,fullFileName,'jpg')
end