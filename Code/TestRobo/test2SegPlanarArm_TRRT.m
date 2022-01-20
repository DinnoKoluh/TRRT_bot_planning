clear;
close all;
L = [1;1];
qi = [-170; 21];
qf = [64; 28];

initConfig = toRad([qi; 0]);
finalConfig = toRad([qf; 0]);

robot = PlanarArm(L,initConfig, finalConfig);

obstacles = make2Dobstacles();
robot.obstacles = expandObstacles(obstacles, 0);

maxNodeNum = 1500; % max broj cvorova
q_init = Node([qi', costFunction(robot)], 1); % pocetna konfiguracija
robot.currConfig = finalConfig;
q_final = Node([qf', costFunction(robot)], 1); % finalna konfiguracija
robot.currConfig = initConfig;

boundary.begin = [-180, -180]; % pocetak konfiguracijskog prostora
boundary.end = [180, 180]; % kraj konfiguracijskog prostora
minDistance = 1; % minimalna dopustena distanca do cilja

pltRRT = 0; 
% xlim([-180, 180]);
% ylim([-180, 180]);

deltaQ = 7; % za koliko se siri stablo

rng(6);
% Karakteristike TRRT-a
T = 1e-4;
K = 1000;
alpha = 1.25;
maxFails = 20;
c_max = 0.35;
rho = 0.05;

G1 = TRRT(maxNodeNum, boundary, deltaQ, minDistance); % inicijalizacija grafa
G1.setTRRTproperties(terrain, T, K, alpha, maxFails, c_max, rho);

G2 = TRRT(maxNodeNum, boundary, deltaQ, minDistance);
G2.setTRRTproperties(terrain, T, K, alpha, maxFails, c_max, rho);

G1.robot = robot;
G2.robot = robot;

close all;
open('TRRTsummer.fig');
hold on;

mi = [0.3, 0.3];
eta = 0.2;
[G] = myRoboBiRRT(robot, G1, G2, q_init, q_final, pltRRT, eta, mi);

% Dobivanje vektora svih konfiguracija od pocetne do krajnje
robot.configVector = robot.getMotionConfigVector(G, q_init, q_final);


figure;
plot2Dobstacles(obstacles);
hold on;
robot.bot.plot(robot.configVector(1:2,:)','trail', '-');


