clear;
close all;
L = [1; 1.5; 1.5];
d = [0; 0; 0];
qi = [0; 0; 0];
qf = [45; 0; -70];

% WINDOW CONFIG
initConfig = toRad([qi; 0]);
finalConfig = toRad([qf; 0]);

robot = AnthroArm(L,initConfig, finalConfig, d);

obstacles = makeRoboExamples('AnthroArm');
%obstacles = makeRobo3Dobstacles();
robot.obstacles = expandObstacles(obstacles,0.0);
%robot.obstacles = {};

 
maxNodeNum = 1500; % max broj cvorova
q_init = Node([qi', costFunction(robot)], 1); % pocetna konfiguracija
robot.currConfig = finalConfig;
q_final = Node([qf', costFunction(robot)], 1); % finalna konfiguracija
robot.currConfig = initConfig;

boundary.begin = [-180, -180, -180]; % pocetak konfiguracijskog prostora
boundary.end = [180, 180, 180]; % kraj konfiguracijskog prostora
minDistance = 1; % minimalna dopustena distanca do cilja

pltRRT = 0; 

deltaQ = 8; % za koliko se siri stablo

rng(6);
% Karakteristike TRRT-a
T = 1e-4;
K = 1000;
alpha = 1.25;
maxFails = 20;
c_max = 0.35;
rho = 0.05;

% Inicijalizacija grafova
G1 = TRRT(maxNodeNum, boundary, deltaQ, minDistance); 
G1.setTRRTproperties(terrain, T, K, alpha, maxFails, c_max, rho);

G2 = TRRT(maxNodeNum, boundary, deltaQ, minDistance);
G2.setTRRTproperties(terrain, T, K, alpha, maxFails, c_max, rho);

G1.robot = robot;
G2.robot = robot;
close all;

mi = [0.5, 0.1];
eta = 0.25;
[G] = myRoboBiRRT(robot, G1, G2, q_init, q_final, pltRRT, eta, mi);

% Dobivanje vektora svih konfiguracija od po?etne do krajnje
robot.configVector = robot.getMotionConfigVector(G, q_init, q_final);

% Plotanje
figure;
xlim([-1, 4]);
ylim([-2, 4]);
zlim([-4, 4]);
plot3Dobstacles(obstacles);
hold on;
robot.bot.plot(robot.configVector','trail', '-');
