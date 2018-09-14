function [newx, newy] = track_yb(position_ss, position_yb)
newx = position_yb(1) - position_ss(1);
newy = position_yb(2) - position_ss(2);
end