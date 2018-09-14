close all;
clear all;
% extract yellow bird H,S,V range
%yellow_bird = imread('./Objects/yellow.png');
%yellow_bird = im2double(yellow_bird); % range value between 0 and 1

% select pixels "https://www.youtube.com/watch?v=oqmxaZYLIkg"
%d = impixel(yellow_bird);

% // find H, S, V rules
% //yellow bird: H > 0.14 & H < 0.2 & S > 0.5 & S < 0.9 & V>0.8
% //red bird: h>0.8 & s>0.7 & v>0.4 & v<0.9
% //black bird: h>0.15 & h<0.3 & s>0.6 & v>0.1 & v<0.5


%for frame_num = 1677:1715 %942
%[CC,bw2, region] = detect_object(1677); %yb: 892,900,935 %428 438 451for red bird %1125for black bird
%end
%make_video('./test/yellow_birds_result','jpg','yellow.avi',3)
%addpath('/Users/a111/Desktop/Project/CV/export_fig-master')  

% save coordinates when the slingshot occurs
% 1st red bird
rb1_x_coordination_havess = [];
rb1_y_coordination_havess = [];
% 2nd red bird
rb2_x_coordination_havess = [];
rb2_y_coordination_havess = [];
% yellow bird
yb_x_coordination_havess = [];
yb_y_coordination_havess = [];
% black bird
black_x_coordination_havess = [];
black_y_coordination_havess = [];
% white bird
wb1_x_coordination_havess = [];
wb1_y_coordination_havess = [];
wb2_x_coordination_havess = [];
wb2_y_coordination_havess = [];

for frame_num = 1431:1440
% start from it flies
have_yellow_bird = (frame_num <= 934) && (frame_num >= 892); 
have_red_bird = (frame_num <= 493 && frame_num >= 428) || (frame_num >=1688 && frame_num <=1715);
have_black_bird = (frame_num <= 1177) && (frame_num >= 1126);
have_slingshot = (frame_num >= 350 && frame_num <=441) || (frame_num >=660 && frame_num <=725) || (frame_num >= 859 && frame_num <=903) || (frame_num >=1105 && frame_num <=1137) || (frame_num >= 1337 && frame_num <=1395) || (frame_num >=1679 && frame_num <=1699);
have_blue_bird = (frame_num<= 784) && (frame_num >= 714);
have_white_bird = (frame_num<= 1444) && (frame_num >= 1382);

frame_path = ['./HSV_frames/',num2str(frame_num),'.jpg'];
frame = imread(frame_path);

if have_yellow_bird || have_red_bird || have_black_bird || have_slingshot|| have_blue_bird || have_white_bird
    RGB_path = ['./RGB_frames/',num2str(frame_num),'.jpg'];
    figure,imshow(RGB_path),
    hold on
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% detect birds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if position = [0,0], it means the object is not detected in this frame
%detect yellow bird 1
if have_yellow_bird
    position_yb = detect_yb(frame, frame_num);
end
% detect red bird 2
if have_red_bird
    position_rb = detect_rb(frame, frame_num);
end
% detect blue bird
if have_blue_bird
    position_bb = detect_blue(frame, frame_num);
end

% detect white bird
if have_white_bird
    position_wb = detect_white(frame, frame_num);
end

%detect black bird
if have_black_bird
    position_black = detect_black(frame, frame_num);
end

%detect slingshot 6
if have_slingshot
    position_ss = detect_slingshot(frame, frame_num);
end
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% track birds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% track the second red bird
if have_red_bird && (frame_num >=1688 && frame_num <=1715)
    % calculate curve when the slingshot occurs
    if have_slingshot
        if position_ss(1)*position_ss(2)*position_rb(1)*position_rb(2) ~=0
            newx = position_rb(1) - position_ss(1);
            newy = position_rb(2) - position_ss(2);
            rb2_x_coordination_havess = [rb2_x_coordination_havess, newx];
            rb2_y_coordination_havess = [rb2_y_coordination_havess, newy];
        end
    end
end

% track the first red bird
if have_red_bird && (frame_num <= 493 && frame_num >= 428)
    % calculate curve when the slingshot occurs
    if have_slingshot
        if position_ss(1)*position_ss(2)*position_rb(1)*position_rb(2) ~=0
            newx = position_rb(1) - position_ss(1);
            newy = position_rb(2) - position_ss(2);
            rb1_x_coordination_havess = [rb1_x_coordination_havess, newx];
            rb1_y_coordination_havess = [rb1_y_coordination_havess, newy];
        end
    end
end
% track yellow bird
if have_yellow_bird && have_slingshot
    % calculate curve when the slingshot occurs
    if position_ss(1)*position_ss(2)*position_yb(1)*position_yb(2) ~=0
       newx = position_yb(1) - position_ss(1);
       newy = position_yb(2) - position_ss(2);
       yb_x_coordination_havess = [yb_x_coordination_havess, newx];
       yb_y_coordination_havess = [yb_y_coordination_havess, newy];
    end
end

% track black bird
if have_black_bird && have_slingshot
    % calculate curve when the slingshot occurs
    if position_ss(1)*position_ss(2)*position_black(1)*position_black(2) ~=0
       newx = position_black(1) - position_ss(1);
       newy = position_black(2) - position_ss(2);
       black_x_coordination_havess = [black_x_coordination_havess, newx];
       black_y_coordination_havess = [black_y_coordination_havess, newy];
    end
end

% track white bird
if have_white_bird && have_slingshot && frame_num <= 1428
    % calculate curve when the slingshot occurs
    if position_ss(1)*position_ss(2)*position_wb(1)*position_wb(2) ~=0
       newx = position_wb(1) - position_ss(1);
       newy = position_wb(2) - position_ss(2);
       wb1_x_coordination_havess = [wb1_x_coordination_havess, newx];
       wb1_y_coordination_havess = [wb1_y_coordination_havess, newy];
    end
end

if have_white_bird && frame_num >= 1429
    % calculate curve when the slingshot occurs
    if position_wb(1)*position_wb(2) ~=0
       newx = position_wb(1) - 142;
       newy = position_wb(2) - 94;
       wb2_x_coordination_havess = [wb2_x_coordination_havess, newx];
       wb2_y_coordination_havess = [wb2_y_coordination_havess, newy];
    end
end

end

% calculate coe of curves
rb2_coeff = polyfit(rb2_x_coordination_havess, rb2_y_coordination_havess, 2);
rb1_coeff = polyfit(rb1_x_coordination_havess, rb1_y_coordination_havess, 2);
yb_coeff = polyfit(yb_x_coordination_havess, yb_y_coordination_havess, 2);
black_coeff = polyfit(black_x_coordination_havess, black_y_coordination_havess, 2);
wb1_coeff = polyfit(wb1_x_coordination_havess, wb1_y_coordination_havess, 2);
wb2_coeff = polyfit(wb2_x_coordination_havess, wb2_y_coordination_havess, 2);










