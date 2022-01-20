function [ob] = makeWindow()
%d = 0.4;
%     initx = -1.5;
%     inity = 1.0;
%     initz = -2.2;
% 
%     dx = 0.3;
% 
%     sirina_gd = 3.5;
%     sirina_ld = 0.7;
% 
%     visinaz = 3.5;
%     dz = 0.7;
% 
%     obstacles = {};
%     obstacles{1,1} = makeRectangularSolid([initx, inity, initz],[dx, sirina_ld,  visinaz]);
%     obstacles{2,1} = makeRectangularSolid([initx, inity + sirina_gd - sirina_ld, initz], [dx,sirina_ld,visinaz]);
%     obstacles{3,1} = makeRectangularSolid([initx, inity, initz + visinaz - dz], [dx, sirina_gd, dz]);
%     obstacles{4,1} = makeRectangularSolid([initx, inity, initz], [dx, sirina_gd, dz]);
%     ob = {};
%     for i = 1:length(obstacles)
%         x = obstacles{i,1}(:,1);
%         y = obstacles{i,1}(:,2);
%         z = obstacles{i,1}(:,3);
%         ob{i,1} = [z,y,x];
%     end
    
        p = [-2.2,1,-3.7];
        d = [3.5,3.5,1];
        ob{1,1} = makeRectangularSolid(p,d);
    
% % lijeva strana
% init =  [initx, inity, initz];
% final = [initx + dx, inity + sirina_ld, initz + visinaz];
% [x,y,z] = meshgrid(init(1,1):d:final(1,1), init(1,2):d:final(1,2), init(1,3):d:final(1,3));
% x = x(:);
% y = y(:);
% z = z(:);
% 
% obstacles{1,1} = [x,y,z];
% 
% % desna strana 
% init = [initx, inity + sirina_gd - sirina_ld, initz];
% final = [initx + dx, inity + sirina_gd, initz + visinaz];
% [x,y,z] = meshgrid(init(1,1):d:final(1,1), init(1,2):d:final(1,2), init(1,3):d:final(1,3));
% x = x(:);
% y = y(:);
% z = z(:);
% 
% obstacles{2,1} = [x,y,z];
% 
% % gornja strana 
% init = [initx, inity, initz + visinaz - dz];
% final = [initx + dx, inity + sirina_gd, initz + visinaz];
% [x,y,z] = meshgrid(init(1,1):d:final(1,1), init(1,2):d:final(1,2), init(1,3):d:final(1,3));
% x = x(:);
% y = y(:);
% z = z(:);
% 
% obstacles{3,1} = [x,y,z];
% 
% % donja strana 
% init = [initx,              inity, initz];
% final = [initx + dx,  inity + sirina_gd,  initz + dz];
% [x,y,z] = meshgrid(init(1,1):d:final(1,1), init(1,2):d:final(1,2), init(1,3):d:final(1,3));
% x = x(:);
% y = y(:);
% z = z(:);
% 
% obstacles{4,1} = [x,y,z];
end

