clear;
close all;
L = [1;1];
qi = [-166; 0];
qf = [64; 28];

initConfig = toRad([qi; 0]);
finalConfig = toRad([qf; 0]);

robot = PlanarArm(L,initConfig, finalConfig);

obstacles = make2Dobstacles();
robot.obstacles = expandObstacles(obstacles, 0);

maxNodeNum = 10000; % max broj cvorova
q_init = Node([qi', costFunction(robot)], 1); % pocetna konfiguracija
robot.currConfig = finalConfig;
q_final = Node([qf', costFunction(robot)], 1); % finalna konfiguracija
robot.currConfig = initConfig;

boundary.begin = [-180, -180]; % pocetak konfiguracijskog prostora
boundary.end = [180, 180]; % kraj konfiguracijskog prostora
minDistance = 2; % minimalna dopustena distanca do cilja

pltRRT = 0; 
% xlim([-180, 180]);
% ylim([-180, 180]);
deltaQ = 6; % za koliko se siri stablo

rng(6);
% Karakteristike TRRT-a
T = 7e-5;
K = (q_init.coordinates(1,end)+q_final.coordinates(1,end))/2;
alpha = 2.69;

% T = 1e-4;
% K = 1500;
% alpha = 1.15;

maxFails = 15;
c_max = 0.35;
rho = 0.05;

G1 = TRRT(maxNodeNum, boundary, deltaQ, minDistance); % inicijalizacija grafa
G1.setTRRTproperties(terrain, T, K, alpha, maxFails, c_max, rho);

G2 = TRRT(maxNodeNum, boundary, deltaQ, minDistance);
G2.setTRRTproperties(terrain, T, K, alpha, maxFails, c_max, rho);

G1.robot = robot;
G2.robot = robot;


mi = [0.50, 0.20];
eta = 0.33;
[G, Ga, Gb, con] = myRoboBiRRT(robot, G1, G2, q_init, q_final, pltRRT, eta, mi);
% return;
close all;
open('2SPR_CM_005.fig');
hold on;
Ga.plotRRT(1,1, 'y');
Gb.plotRRT(1,1, 'r');
G.plotRRTpath(q_init, q_final);
plotEdge(con(1,1),con(2,1),'cyan',3.6);
plotMarker(q_init.coordinates, '$S$');
plotMarker(q_final.coordinates, '$F$');
%daspect([1 1 1]);

% Dobivanje vektora svih konfiguracija od po?etne do krajnje
robot.configVector = robot.getMotionConfigVector(G, q_init, q_final);

figure;
plot2Dobstacles(obstacles);
robot.plotRobotPath();
robot.plotRoboNthSegmentPath(robot.dim);
grid on;
xlabel('$x$','fontsize',25);
ylabel('$y$','fontsize',25);
xlim([-2,3]);
ylim([-2.5,3.5]);
daspect([1 1 1]);

robot.getNthSegmentPathLength(2);

getAveragePathCost(robot, robot.configVector);


