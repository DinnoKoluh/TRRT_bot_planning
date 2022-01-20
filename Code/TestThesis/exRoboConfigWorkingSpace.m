L = [1;1];
initConfig = toRad([-170;21]);
finalConfig = toRad([64; 28]);

robot = PlanarArm(L,initConfig, finalConfig);
obstacles = make2Dobstacles();
%robot.obstacles = obstacles;
d = zeros(1,1);
a = 0;
b = 0;
delta = 5;

for k = 1:2
    robot.obstacles = {obstacles{k,1}};
    for i = -180:delta:180
        i
        a = a + 1;
        b = 0;
        for j = -180:delta:180
            robot.currConfig = toRad([i;j]);
            if checkRoboIntersection(robot);
                if k == 1
                    plot(i,j,'rx');
                    hold on;
                else
                    plot(i,j,'gx');
                    hold on;
                end
            end
%             b = b + 1;
%             cost = costFunction(robot);
%             d(b,a) = cost;             
        end
    end
end

xlim([-180,180]);
ylim([-180,180]);
grid on;
xlabel('$q_1[^{\circ}]$','fontsize',25);
ylabel('$q_2[^{\circ}]$','fontsize',25);
ax=gca;
ax.XTick = -180:30:180;
ax.YTick = -180:30:180;
daspect([1 1 1]);

% figure;
% grid on;
% plot2Dobstacles({obstacles{1,1}},'b');
% hold on;
% plot2Dobstacles({obstacles{2,1}},'g')
% xlim([-3,3]);
% ylim([-0,3.5]);
% xlabel('$x$','fontsize',25);
% ylabel('$y$','fontsize',25);
% robot.currConfig = toRad([-120;-30]);
% robot.plotSegments(1);
% figure;
% [X,Y] = meshgrid(-180:delta:180);
% surf(X,Y,d);
% shading interp
% colormap(jet);




% L = [1; 0.5; 0.4];
% 
% initConfig = toRad([-170; 0; 0]);
% finalConfig = toRad([61; 28; 2]);
% 
% robot = PlanarArm(L,initConfig, finalConfig);
% 
% obstacles =make2Dobstacles();
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


