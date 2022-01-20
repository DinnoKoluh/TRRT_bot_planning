close all;

%obstacles = makeRoboExamples('AnthroSphericalArmWrist1');
robot.obstacles = obstacles;

%obstacles =make3Dobstacles();
xlim([-2, 2]);
ylim([-1, 2]);
zlim([-2, 2]);
%plot3Dobstacles(obstacles);
plot3Dobstacles(robot.obstacles);
%plot3Dobstacles(expandObstacles(obstacles,0.0));
%plot2Dobstacles(obstacles);
hold on;
%robot.bot.plot(robot.configVector','trail', '-','nojoints');
% hold on;
% robot.plotRoboNthSegmentPath(3);
% hold on;
% robot.plotRoboNthSegmentPath(2);
% hold on;
% robot.plotRoboNthSegmentPath(1);
%robot.bot.plot(robot.configVector','trail', '-','nojoints','delay',0.5);
robot.bot.plot(robot.configVector','trail', '-','nojoints');
robot.bot.teach();
% plot3Dobstacles(obstacles);


