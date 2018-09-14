%yellow

% load('yellowbird_curve.mat')
% figure, imshow('./RGB_frames/935.jpg')
% hold on
% fitted = zeros(480,2);
% for j = 1:480
%   fitted(j,1) = j;
%   %if -yb_coeff(1)*j^2 + yb_coeff(2)*j + yb_coeff(3)+233 >0
%   fitted(j,2) = yb_coeff(1)*j^2 + yb_coeff(2)*j + yb_coeff(3)+260;%+233
%   %end
% end
% plot(fitted(:,1),fitted(:,2),'b-','linewidth',1.5);

%black
% load('blackbird_curve.mat')
% figure, imshow('./RGB_frames/1175.jpg')
% hold on
% fitted = zeros(480,2);
% for j = 1:480
%   fitted(j,1) = j;
%   %if -yb_coeff(1)*j^2 + yb_coeff(2)*j + yb_coeff(3)+233 >0
%   fitted(j,2) = black_coeff(1)*j^2 + black_coeff(2)*j + black_coeff(3)+175;%+233
%   %end
% end
% plot(fitted(:,1),fitted(:,2),'b-','linewidth',1.5);

%white
% load('whitebird_curve.mat')
% figure, imshow('./RGB_frames/1429.jpg')
% hold on
% fitted = zeros(480,2);
% for j = 1:480
%   fitted(j,1) = j;
%   %if -yb_coeff(1)*j^2 + yb_coeff(2)*j + yb_coeff(3)+233 >0
%   fitted(j,2) = wb_coeff(1)*j^2 + wb_coeff(2)*j + wb_coeff(3)+100;%+233
%   %end
% end
% plot(fitted(:,1),fitted(:,2),'b-','linewidth',1.5);
load('whitebird_curve2.mat')
figure, imshow('./RGB_frames/1440.jpg')
hold on
fitted = zeros(480,2);
for j = 1:480
  fitted(j,1) = j;
  %if -yb_coeff(1)*j^2 + yb_coeff(2)*j + yb_coeff(3)+233 >0
  fitted(j,2) = wb2_coeff(1)*j^2 + wb2_coeff(2)*j + wb2_coeff(3)+160;%+233
  %end
end
plot(fitted(:,1),fitted(:,2),'b-','linewidth',1.5);


