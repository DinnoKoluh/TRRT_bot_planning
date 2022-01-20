clear;
close all;
L = [0; 1.5; 1.5];
d = [0; 0; 0];

initConfig = toRad([45; 135; -45]);
finalConfig = toRad([55; 0; -45]);

robot = AnthroArm(L,initConfig, finalConfig, d);

obstacles = makeRoboExamples('AnthroArm');
robot.obstacles = obstacles;

 
maxNodeNum = 5000; % max broj cvorova
q_init = Node(toDeg(initConfig)', 1); % pocetna konfiguracija
q_final = Node(toDeg(finalConfig)', 1); % finalna konfiguracija

boundary.begin = [-180, -180, -180]; % pocetak konfiguracijskog prostora
boundary.end = [180, 180, 180]; % kraj konfiguracijskog prostora
minDistance = 1; % minimalna dopustena distanca do cilja

pltRRT = 0; 

deltaQ = 8; % za koliko se siri stablo

rng(7);
G1 = RRT(maxNodeNum, boundary, deltaQ, minDistance); % inicijalizacija grafa
G2 = RRT(maxNodeNum, boundary, deltaQ, minDistance);

mi = [0.65, 0.30];
eta = 0.28;
[G, Ga, Gb, con] = myRoboBiRRT(robot, G1, G2, q_init, q_final, pltRRT, eta, mi);
% return;
% Dobivanje vektora svih konfiguracija od po?etne do krajnje
robot.configVector = robot.getMotionConfigVector(G, q_init, q_final);

f = figure;
plot3Dobstacles(obstacles);
xlim([-2, 3.5]);
ylim([-2, 2.5]);
zlim([-3, 3]);
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
