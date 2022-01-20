

L = [1;1];
initConfig = toRad([-170;21]);
finalConfig = toRad([64; 28]);

robot = PlanarArm(L,initConfig, finalConfig);
obstacles = makeRobo2Dobstacles();
robot.obstacles = obstacles;
d = zeros(1,1);
a = 0;
b = 0;
for k = 1:2
    robot.obstacles = {obstacles{k,1}};
    for i = -180:5:180
        i
        a = a + 1;
        b = 0;
        for j = -180:5:180
            robot.currConfig = toRad([i;j]);
            if checkRoboIntersection(robot);
                if k == 1
                    plot(i,j,'bx');
                    hold on;
                else
                    plot(i,j,'gx');
                    hold on;
                end
            end
    %         b = b + 1;
    %         robot.currConfig = toRad([i;j]);
    %         cost = costFunction(robot);
    %         d(b,a) = cost;             
        end
    end
end
[X,Y] = meshgrid(-180:5:180);
surf(X,Y,d);
shading interp
colormap(jet);




% L = [1; 0.5; 0.4];
% 
% initConfig = toRad([-170; 0; 0]);
% finalConfig = toRad([61; 28; 2]);
% 
% robot = PlanarArm(L,initConfig, finalConfig);
% 
% obstacles = makeRobo2Dobstacles();
% robot.obstacles = expandObstacles(obstacles,0.0);
% 
% d = zeros(1,1,1);
% a = 0;
% b = 0;
% c = 0;
% for i = -180:10:180
%     a = a + 1;
%     b = 0;
%     i
%     for j = -180:10:180
%         b = b + 1;
%         c = 0;
%         for k = -180:10:180
%         robot.currConfig = toRad([i;j;k]);
%         c = c + 1;
% %         d(a,b,c) = cost;
%             if checkRoboIntersection(robot)
%                 plot3(i,j,k,'r*');
%                 hold on;
%                 drawnow;
%             end
%         end
%     end
% end


% L = [1; 1];
% 
% initConfig = toRad([-170; 0; 0]);
% finalConfig = toRad([61; 28; 2]);
% 
% robot = PlanarArm(L,initConfig, finalConfig);
% 
% obstacles = makeRobo2Dobstacles();
% robot.obstacles = expandObstacles(obstacles,0.0);
% 
% d = zeros(1,1);
% a = 0;
% b = 0;
% c = 0;
% for i = -180:1:180
%     a = a + 1;
%     b = 0;
%     i
%     for j = -180:1:180
%         b = b + 1;
%         robot.currConfig = toRad([i;j]);
%             if checkRoboIntersection(robot)
%                 d(b,a) = 1;
%             else
%                 d(b,a) = 0;
%             end
%     end
% end
% 
% [X,Y] = meshgrid(-180:1:180);
% C = X.*Y;
% surfc(X,Y,d,C)
% %surf(X,Y,d);
% shading interp
% colormap(jet);