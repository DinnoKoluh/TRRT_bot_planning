function [ob] = make3Dobstacles( )
% d = 1;
% init = [0, 0, 0];
% final = [1, 1, 1];
% d = abs((abs(init)-abs(final)))/2;
% [x,y,z] = meshgrid(init(1,1):d(1,1):final(1,1), init(1,2):d(1,2):final(1,2), init(1,3):d(1,3):final(1,3));
% x = x(:);
% y = y(:);
% z = z(:);
% % celija koja sadrzi prepreke
%  obstacles{1,1} = [x,y,z];
 
% init = [-6, 3, 0.2];
% final = [4, 4, 1];
% [x,y,z] = meshgrid(init(1,1):d:final(1,1), init(1,2):d:final(1,2), init(1,3):d:final(1,3));
% x = x(:);
% y = y(:);
% z = z(:);
% 
% % % celija koja sadrzi prepreke
%  obstacles{2,1} = [x,y,z];
    initx = -0.4;
    inity = -0.5;
    initz = -0.5;

    dx = 0.2;

    sirina_gd = 2;
    sirina_ld = 0.4;

    visinaz = 2;
    dz = 0.4;

    obstacles = {};
    obstacles{1,1} = makeRectangularSolid([initx, inity, initz],[dx, sirina_ld,  visinaz]);
    obstacles{2,1} = makeRectangularSolid([initx, inity + sirina_gd - sirina_ld, initz], [dx,sirina_ld,visinaz]);
    obstacles{3,1} = makeRectangularSolid([initx, inity, initz + visinaz - dz], [dx, sirina_gd, dz]);
    obstacles{4,1} = makeRectangularSolid([initx, inity, initz], [dx, sirina_gd, dz]);
    ob = {};
    for i = 1:length(obstacles)
        x = obstacles{i,1}(:,1);
        y = obstacles{i,1}(:,2);
        z = obstacles{i,1}(:,3);
        ob{i,1} = [y,x,z];
    end
        
%     p = [-1,0.9,-1];
%     d = [3,0.5,2];
%     ob{5,1} = makeRectangularSolid(p,d);



end

