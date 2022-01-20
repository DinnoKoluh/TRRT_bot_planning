function [P] = getRectangle(r,w,h)
x = r(1,1);
y = r(1,2);
P = [x y; x+w y; x+w y+h; x y+h];
end

