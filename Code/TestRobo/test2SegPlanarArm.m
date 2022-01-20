clear;
close all;

L = [1;1];
initConfig = toRad([-170;21]);
finalConfig = toRad([64; 28]);

robot = PlanarArm(L,initConfig, finalConfig);

obstacles = make2Dobstacles();
robot.obstacles = expandObstacles(obstacles,0.0);
%robot.obstacles = {};

maxNodeNum = 1500; % max broj cvorova
q_init = Node(toDeg(initConfig)', 1); % pocetna konfiguracija
q_final = Node(toDeg(finalConfig)', 1); % finalna konfiguracija

boundary.begin = [-180, -180]; % pocetak konfiguracijskog prostora
boundary.end = [180, 180]; % kraj konfiguracijskog prostora
minDistance = 1; % minimalna dopustena distanca do cilja

pltRRT = 1; 
% xlim([-180, 180]);
% ylim([-180, 180]);
open('summer.fig');
hold on;

deltaQ = 5; % za koliko se siri stablo

rng(6);

G1 = RRT(maxNodeNum, boundary, deltaQ, minDistance); % inicijalizacija grafa
G2 = RRT(maxNodeNum, boundary, deltaQ, minDistance);

mi = [0.3, 0.3];
eta = 0.5;
[G] = myRoboBiRRT(robot, G1, G2, q_init, q_final, pltRRT, eta, mi);

% Dobivanje vektora svih konfiguracija od po?etne do krajnje
robot.configVector = robot.getMotionConfigVector(G, q_init, q_final);

% figure;
% plot2Dobstacles(obstacles);
% hold on;
% %%%%%%robot.bot.plot(robot.configVector', 'trail','-');
% robot.plotRobotPath();
% 
% hold on;
% robot.plotRoboNthSegmentPath(2);
% hold on;
% robot.plotRoboNthSegmentPath(1);
% 
% robot.getNthSegmentPathLength(1);
% robot.getNthSegmentPathLength(2);

figure;
plot2Dobstacles(obstacles);
hold on;
robot.bot.plot(robot.configVector','trail', '-');