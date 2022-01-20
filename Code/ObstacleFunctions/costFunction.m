function [cost] = costFunction(robot)
% L = [1;1];
% initConfig = toRad([-170; 21]);
% finalConfig = toRad([64; 28]);
% robot = TRRT_PlanarArm(L,initConfig, finalConfig);
% obstacles = makeRobo2Dobstacles();
% robot.obstacles = obstacles;
% robot.currConfig = toRad([i;j]);
%cost = 1/(1+getCurrConfigCost(robot));
cost = exp(-3*getCurrConfigCost(robot));
%cost = getCurrConfigCost(robot);
end

