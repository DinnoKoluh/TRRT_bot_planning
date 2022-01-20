% L = 360;
% H = 360;
% 
% R = 360/(2*pi);
% H_prim = 360/(2*pi);
% 
% X_new = d.*R*cos(X.*(2*pi/L));
% Y_new = d.*R*sin(X.*(2*pi/L));
% Z_new = X.*(H_prim/H);
% 
% surf(X_new, Y_new, Z_new)
% axis equal

[X_c,Y_c,Z_c] = cylinder(d(1:end,1));

% X_c = X_c + d;
% Y_c = Y_c + d;

surf(X_c,Y_c,100*Z_c);