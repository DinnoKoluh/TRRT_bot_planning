clear;
close all;
L = [0; 1; 0; 0; 0; 0];
d = [0;0;0; 0.5; 0; 0.5];

%1
qi = [45; 90; 90; 0; 0; 0];
qf = [90; -20;  20;  90;  60;  45];

%2
% qi = [140; -6.4; -56.4; -90; 72; -7.2];
% qf = [38.8; -35.2;  -25.6;  -64.8;  54;  120];

initConfig = toRad([qi; 0]);
finalConfig = toRad([qf; 0]);

robot = AnthroSphericalArmWrist(L,initConfig, finalConfig,d);

obstacles = makeRoboExamples('AnthroSphericalArmWrist1');
%obstacles = {};
%obstacles = makeWindow();
robot.obstacles = obstacles;
 
maxNodeNum = 15000; % max broj cvorova
q_init = Node([qi', costFunction(robot)], 1); % pocetna konfiguracija
robot.currConfig = finalConfig;
q_final = Node([qf', costFunction(robot)], 1); % finalna konfiguracija
robot.currConfig = initConfig;

boundary.begin = -180*ones(1,6); % pocetak konfiguracijskog prostora
boundary.end = 180*ones(1,6); % kraj konfiguracijskog prostora
minDistance = 1; % minimalna dopustena distanca do cilja

pltRRT = 0; 

deltaQ = 10; % za koliko se siri stablo

rng(6);
% Karakteristike TRRT-a
T = 1e-6;
K = 1000;
K = 1*(q_init.coordinates(1,end)+q_final.coordinates(1,end))/2;

alpha = 1.2;
maxFails = 5;
c_max = 0.75;
rho = 0.15;

% Inicijalizacija grafova
G1 = TRRT(maxNodeNum, boundary, deltaQ, minDistance); 
G1.setTRRTproperties(terrain, T, K, alpha, maxFails, c_max, rho);

G2 = TRRT(maxNodeNum, boundary, deltaQ, minDistance);
G2.setTRRTproperties(terrain, T, K, alpha, maxFails, 0.45, rho);

G1.robot = robot;
G2.robot = robot;
close all;

mi = [0.50, 0.30];
eta = 0.05;
[G, Ga, Gb, con] = myRoboBiRRT(robot, G1, G2, q_init, q_final, pltRRT, eta, mi);
return;
% Dobivanje vektora svih konfiguracija od po?etne do krajnje
robot.configVector = robot.getMotionConfigVector(G, q_init, q_final);

f = figure;
plot3Dobstacles(obstacles);
xlim([-2, 2]);
ylim([-2, 2]);
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
