% Parametri radnog prostora 
% Planarna dvosegmentna ruka
L = [1;1];
initConfig = [toRad(160); toRad(5)];
finalConfig = [toRad(20); toRad(-5)];

robot = PlanarArm(L,initConfig, finalConfig);

     alpha = toRad(65);
   ob{1,1} = getRectangle([1,1],1,2)*getRotationMatrix(alpha);
   ob{2,1} = getRectangle([-1,1.2],1,2);

robot.obstacles = ob;
% robot.plotSegments(1);
% configObstacles = robot.getConfigSpaceObstacles();

%figure;
%configObstacles = robot.configObstacles;

d = zeros(1,1);
a = 0;
b = 0;
for i = -50:4:50
    i
    a = a + 1;
    b = 0;
    for j = -50:4:50
        b = b + 1;
        robot.currConfig = toRad([i;j]);
        cost = costFunction(robot);
        d(b,a) = cost;             
%         if cost < 0.4
%             plot3(i, j, costFunction(robot),'b*');
%         else
%             plot3(i, j, costFunction(robot),'r*');
%         end

    end
end
[X,Y] = meshgrid(-50:4:50);
surf(X,Y,d);

