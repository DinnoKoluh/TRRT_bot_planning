function [ ob ] = makeRoboExamples(ex)

    if strcmp(ex,'SphericalWrist')
        initx = -0.4;
        inity = -0.23;
        initz = -0.5;

        dx = 0.3;

        sirina_gd = 0.8;
        sirina_ld = 0.2;

        visinaz = 1.3;
        dz = 0.4;

        obstacles = {};
        % left side
        obstacles{1,1} = makeRectangularSolid([initx, inity, initz],[dx, sirina_ld,  visinaz]);
        % right side 
        obstacles{2,1} = makeRectangularSolid([initx, inity + sirina_gd - sirina_ld, initz], [dx,sirina_ld,visinaz]);
        % upper side
        %obstacles{3,1} = makeRectangularSolid([initx, inity, initz + visinaz - dz], [dx, sirina_gd, dz]);
        % lower side 
        obstacles{3,1} = makeRectangularSolid([initx, inity, initz], [dx, sirina_gd, dz]);
        ob = {};
        for i = 1:length(obstacles)
            obstacles{i,1} = rotateObstacle(obstacles{i,1}, getRotationMatrix([0;0;0],'Deg'), [initx, inity, 0]);
        end
        for i = 1:length(obstacles)
            x = obstacles{i,1}(:,1);
            y = obstacles{i,1}(:,2);
            z = obstacles{i,1}(:,3);
            ob{i,1} = [x,y,z];
        end

    %     p = [-1,0.9,-1];
    %     d = [3,0.5,2];
    %     ob{5,1} = makeRectangularSolid(p,d)
    
    
    elseif strcmp(ex,'AnthroArm')
        initx = 1.5;
        inity = 0.5;
        initz = -1;

        dx = 0.4;

        sirina_gd = 2;
        sirina_ld = 0.4;

        visinaz = 2;
        dz = 0.4;

        obstacles = {};
        obstacles{1,1} = makeRectangularSolid([initx, inity, initz],[dx, sirina_ld,  visinaz]);
        obstacles{2,1} = makeRectangularSolid([initx, inity + sirina_gd - sirina_ld, initz], [dx,sirina_ld,visinaz]);
        obstacles{3,1} = makeRectangularSolid([initx, inity, initz + visinaz - dz], [dx, sirina_gd, dz]);
        obstacles{4,1} = makeRectangularSolid([initx, inity, initz], [dx, sirina_gd, dz]);
        
        for i = 1:length(obstacles)
            obstacles{i,1} = rotateObstacle(obstacles{i,1}, getRotationMatrix([0;-10;-45],'Deg'), [initx, inity, 0]);
        end
        
        ob = {};
        for i = 1:length(obstacles)
            x = obstacles{i,1}(:,1);
            y = obstacles{i,1}(:,2);
            z = obstacles{i,1}(:,3);
            ob{i,1} = [x,y,z];
        end
        
    elseif strcmp(ex,'AnthroSphericalArmWrist1')
        initx = 0.5;
        inity = 0.3;
        initz = -1;

        dx = 0.3;

        sirina_gd = 1.5;
        sirina_ld = 0.2;

        visinaz = 1.5;
        dz = 0.3;

        obstacles = {};
        obstacles{1,1} = makeRectangularSolid([initx, inity, initz],[dx, sirina_ld,  visinaz]);
        obstacles{2,1} = makeRectangularSolid([initx, inity + sirina_gd - sirina_ld, initz], [dx,sirina_ld,visinaz]);
        obstacles{3,1} = makeRectangularSolid([initx, inity, initz + visinaz - dz], [dx, sirina_gd, dz]);
        obstacles{4,1} = makeRectangularSolid([initx, inity, initz], [dx, sirina_gd, dz]);
        ob = {};
        
        for i = 1:length(obstacles)
            obstacles{i,1} = rotateObstacle(obstacles{i,1}, getRotationMatrix([0;60;0],'Deg'), [initx, inity, initz]);
        end
        
        for i = 1:length(obstacles)
            x = obstacles{i,1}(:,1);
            y = obstacles{i,1}(:,2);
            z = obstacles{i,1}(:,3);
            ob{i,1} = [x,y,z];
        end

    elseif strcmp(ex,'AnthroSphericalArmWrist2')
        
    
    end


end

