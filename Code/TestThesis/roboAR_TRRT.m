clear;
close all;
L = [0; 1.5; 1.5];
d = [0; 0; 0];
qi = [45; 135; -45];
qf = [55; 0; -45];

% WINDOW CONFIG
initConfig = toRad([qi; 0]);
finalConfig = toRad([qf; 0]);

robot = AnthroArm(L,initConfig, finalConfig, d);

obstacles = makeRoboExamples('AnthroArm');
robot.obstacles = obstacles;

 
maxNodeNum = 15000; % max broj cvorova
q_init = Node([qi', costFunction(robot)], 1); % pocetna konfiguracija
robot.currConfig = finalConfig;
q_final = Node([qf', costFunction(robot)], 1); % finalna konfiguracija
robot.currConfig = initConfig;

boundary.begin = [-180, -180, -180]; % pocetak konfiguracijskog prostora
boundary.end = [180, 180, 180]; % kraj konfiguracijskog prostora
minDistance = 1; % minimalna dopustena distanca do cilja

pltRRT = 0; 

deltaQ = 8; % za koliko se siri stablo

rng(7);
% Karakteristike TRRT-a
T = 9e-5;
K = 1*(q_init.coordinates(1,end)+q_final.coordinates(1,end))/2;
alpha = 2.15;

% T = 1e-4;
% K = 1000;
% alpha = 1.25;


maxFails = 9;
c_max = 0.42;
rho = 0.12;

% Inicijalizacija grafova
G1 = TRRT(maxNodeNum, boundary, deltaQ, minDistance); 
G1.setTRRTproperties(terrain, T, K, alpha, maxFails, c_max, rho);

G2 = TRRT(maxNodeNum, boundary, deltaQ, minDistance);
G2.setTRRTproperties(terrain, T, K, alpha, maxFails, c_max, rho);

G1.robot = robot;
G2.robot = robot;
close all;

mi = [0.65, 0.30];
eta = 0.28;
[G] = myRoboBiRRT(robot, G1, G2, q_init, q_final, pltRRT, eta, mi);
% return;
% Dobivanje vektora svih konfiguracija od po?etne do krajnje
robot.configVector = robot.getMotionConfigVector(G, q_init, q_final);
% figure;
% xlim([-1, 4]);
% ylim([-1, 4]);
% zlim([-4, 4]);
% plot3Dobstacles(obstacles);
% hold on;
% robot.bot.plot(robot.configVector','trail', '-');

figure;
plot3([0,0],[0,0],[0,-3],'b','Linewidth',5);
plot3Dobstacles(obstacles);
robot.plotRobotPath();
robot.plotRoboNthSegmentPath(robot.dim);
grid on;
xlabel('$x$','fontsize',25);
ylabel('$y$','fontsize',25);
zlabel('$z$','fontsize',25);

% xlim([-2, 3.5]);
% ylim([-3, 3]);
% zlim([-3, 3]);

[v, len] = G1.getShortestPath(q_init, q_final);
len
robot.getNthSegmentPathLength(robot.dim);

getAveragePathCost(robot, robot.configVector);
