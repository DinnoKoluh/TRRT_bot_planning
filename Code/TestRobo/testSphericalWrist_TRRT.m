clear;
close all;
L = [0; 0; 0];
d = [0.0; 0.0; 0.5];

qi = [-90; 90; 0];
qf = [0; -90; 120];

initConfig = toRad([qi; 0]);
finalConfig = toRad([qf; 0]);

robot = SphericalWrist(L,initConfig, finalConfig,d);
%robot.d = d;

%obstacles = makeWindow(robot);
obstacles = makeRoboExamples('SphericalWrist');
robot.obstacles = expandObstacles(obstacles,0.0);
% obstacles = {};
 
maxNodeNum = 10000; % max broj cvorova
q_init = Node([qi', costFunction(robot)], 1); % pocetna konfiguracija
robot.currConfig = finalConfig;
q_final = Node([qf', costFunction(robot)], 1); % finalna konfiguracija
robot.currConfig = initConfig;

boundary.begin = [-180, -180, -180]; % pocetak konfiguracijskog prostora
boundary.end = [180, 180, 180]; % kraj konfiguracijskog prostora
minDistance = 1; % minimalna dopustena distanca do cilja

pltRRT = 0; 

deltaQ = 10; % za koliko se siri stablo

rng(6);
% Karakteristike TRRT-a
T = 2e-6;
K = 1*(q_init.coordinates(1,end)+q_final.coordinates(1,end))/2;
alpha = 4.19;

% T = 2e-6;
% K = 1000;
% alpha = 1.25;

maxFails = 18;
c_max = 0.75;
rho = 0.05;
terrain = false;

% Inicijalizacija grafova
G1 = TRRT(maxNodeNum, boundary, deltaQ, minDistance); 
G1.setTRRTproperties(terrain, T, K, alpha, maxFails, c_max, rho);

G2 = TRRT(maxNodeNum, boundary, deltaQ, minDistance);
G2.setTRRTproperties(terrain, T, K, alpha, maxFails, c_max, rho);

G1.robot = robot;
G2.robot = robot;
close all;

mi = [0.3, 0.18];
eta = 0.35;
[G] = myRoboBiRRT(robot, G1, G2, q_init, q_final, pltRRT, eta, mi);
% return;
% Dobivanje vektora svih konfiguracija od po?etne do krajnje
robot.configVector = robot.getMotionConfigVector(G, q_init, q_final);

figure;
xlim([-1, 1]);
ylim([-1, 1]);
zlim([-1, 1]);
plot3Dobstacles(obstacles);
hold on;
robot.bot.plot(robot.configVector','trail', '-');
