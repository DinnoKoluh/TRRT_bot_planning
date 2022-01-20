clear;
close all;
L = [0; 1; 0; 0; 0; 0];
d = [0;0;0; 0.5; 0; 0.5];

% 1
initConfig = toRad([45; 90; 90; 0; 0; 0]);
finalConfig = toRad([90; -20;  20;  90;  60;  45]);
% 2
% initConfig = toRad([140; -6.4; -56.4; -90; 72; -7.2]);
% finalConfig = toRad([38.8; -35.2;  -25.6;  -64.8;  54;  120]);

robot = AnthroSphericalArmWrist(L,initConfig, finalConfig, d);

obstacles = makeRoboExamples('AnthroSphericalArmWrist1');
%obstacles = {};
%obstacles = makeWindow();
robot.obstacles = obstacles;

maxNodeNum = 10500; % max broj cvorova
q_init = Node(toDeg(initConfig)', 1); % pocetna konfiguracija
q_final = Node(toDeg(finalConfig)', 1); % finalna konfiguracija

boundary.begin = -180*ones(1,6); % pocetak konfiguracijskog prostora
boundary.end = 180*ones(1,6); % kraj konfiguracijskog prostora
minDistance = 1; % minimalna dopustena distanca do cilja

pltRRT = 0; 

deltaQ = 10; % za koliko se siri stablo

rng(6);
G1 = RRT(maxNodeNum, boundary, deltaQ, minDistance); % inicijalizacija grafa
G2 = RRT(maxNodeNum, boundary, deltaQ, minDistance);

mi = [0.50, 0.30];
eta = 0.05;
[G] = myRoboBiRRT(robot, G1, G2, q_init, q_final, pltRRT, eta, mi);
% return;
% Dobivanje vektora svih konfiguracija od po?etne do krajnje
robot.configVector = robot.getMotionConfigVector(G, q_init, q_final);

f = figure;
plot3Dobstacles(obstacles);
xlim([-1, 1.5]);
ylim([-0.7, 2]);
zlim([-2, 2]);
daspect([1 1 1]);
hold on;
plot3([0,0],[0,0],[0,-3],'b','Linewidth',5);
hold on;
robot.plotRobotPath();
robot.plotRoboNthSegmentPath(robot.dim);
grid on;
xlabel('$x$','fontsize',25);
ylabel('$y$','fontsize',25);
zlabel('$z$','fontsize',25);

[v, len] = G1.getShortestPath(q_init, q_final);
len
robot.getNthSegmentPathLength(robot.dim);

getAveragePathCost(robot, robot.configVector);

