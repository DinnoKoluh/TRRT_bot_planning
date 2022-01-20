% obstacles = makeWindow();
% 
% xlim([-4, 4]);
% ylim([-4, 4]);
% zlim([-4, 4]);
% 
% xlabel('x');
% ylabel('y');
% zlabel('z');
% plot3Dobstacles(obstacles);

% xlim([-8, 8]);
% ylim([-8, 8]);
% zlim([-8, 8]);
% plot3Dobstacles(obstacles);
% hold on;
% robot.plotRobotPath();

% obstacles = makeRobo2Dobstacles();
% plot2Dobstacles(obstacles);
% p = [-3,5];
% hold on;
% plot(p(1,1),p(1,2),'r*');

% d1 = p_poly_dist(p(:,1),p(:,2),obstacles{1,1}(:,1), obstacles{1,1}(:,2))
% d2 = p_poly_dist(p(:,1),p(:,2),obstacles{2,1}(:,1), obstacles{2,1}(:,2))

% L = [1;1; 0.5];
% initConfig = toRad([-170; 21]);
% finalConfig = toRad([64; 28]);
% 
% robot = TRRT_PlanarArm(L,initConfig, finalConfig);
% robot.plotSegments(1);
% robot.currConfig = finalConfig;
% hold on;
% robot.plotSegments(2);
% robot.obstacles = obstacles;
% plot2Dobstacles(obstacles);
% xlim([-180, 180]);
% ylim([-180, 180]);
% zlim([-180, 180]);
% open('untitled.fig');
% hold on;
% d = zeros(1,1);
% a = 0;
% b = 0;
% for i = -180:10:180
%     a = a + 1;
%     b = 0;
%     for j = -180:10:180
%         b = b + 1;
%         robot.currConfig = toRad([i;j]);
%         cost = costFunction(robot);
%         d(a,b) = cost;
%         
%         
% %         if cost < 0.4
% %             plot3(i, j, costFunction(robot),'b*');
% %         else
% %             plot3(i, j, costFunction(robot),'r*');
% %         end
%         hold on;
%         drawnow;
%     end
%end

% xlim([-10, 10]);
% ylim([-10, 10]);
% zlim([-10, 10]);
%obstacles{1,1} = [-6, -4, 0.2; 4, -3, 1];
obstacles = makeRobo3Dobstacles();
 k1 = plot3Dobstacles(obstacles);
p = [-2.1,-1.8,6];
 plot3(p(1,1),p(1,2),p(1,3),'b*');
 
[A,b,Aeq,beq] = vert2lcon(obstacles{2,1});
closest = lsqlin(speye(3),p,A,b,Aeq,beq);

distance(p,closest)
