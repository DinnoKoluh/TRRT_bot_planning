clear;
close all;
L = [0; 1.5; 1.5];
d = [1; 0; 0];

initConfig = toRad([0; 0; 0]);
finalConfig = toRad([45; 0; -70]);

robot = AnthroArm(L,initConfig, finalConfig, d);

obstacles = makeRoboExamples('AnthroArm');
%obstacles = makeRobo3Dobstacles();
robot.obstacles = expandObstacles(obstacles,0.0);
%robot.obstacles = {};

 
maxNodeNum = 1500; % max broj cvorova
q_init = Node(toDeg(initConfig)', 1); % pocetna konfiguracija
q_final = Node(toDeg(finalConfig)', 1); % finalna konfiguracija

boundary.begin = [-180, -180, -180]; % pocetak konfiguracijskog prostora
boundary.end = [180, 180, 180]; % kraj konfiguracijskog prostora
minDistance = 1; % minimalna dopustena distanca do cilja

% xlim([-180, 180]);
% ylim([-180, 180]);
% zlim([-180, 180]);

pltRRT = 1; 

deltaQ = 10; % za koliko se siri stablo

rng(6);
G1 = RRT(maxNodeNum, boundary, deltaQ, minDistance); % inicijalizacija grafa
G2 = RRT(maxNodeNum, boundary, deltaQ, minDistance);

mi = [0.3, 0.3];
eta = 0.5;
[G] = myRoboBiRRT(robot, G1, G2, q_init, q_final, pltRRT, eta, mi);

% Dobivanje vektora svih konfiguracija od po?etne do krajnje
robot.configVector = robot.getMotionConfigVector(G, q_init, q_final);

% figure;
% plot3Dobstacles(obstacles);
% hold on;
% robot.plotRobotPath();
% hold on;
% robot.plotRoboNthSegmentPath(3);

figure;
xlim([-1, 4]);
ylim([-1, 4]);
zlim([-4, 4]);
plot3Dobstacles(obstacles);
hold on;
robot.bot.plot(robot.configVector','trail', '-');
