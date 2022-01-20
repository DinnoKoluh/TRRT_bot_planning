clear;
close all;
L = [0; 0; 0];
d = [0.0; 0.0; 0.5];

initConfig = toRad([-90; 90; 0]);
finalConfig = toRad([0; -90; 120]);

robot = SphericalWrist(L,initConfig, finalConfig,d);
%robot.d = d;

%obstacles = makeWindow(robot);
obstacles = makeRoboExamples('SphericalWrist');
robot.obstacles = expandObstacles(obstacles,0.0);
% obstacles = {};
 
maxNodeNum = 1500; % max broj cvorova
q_init = Node(toDeg(initConfig)', 1); % pocetna konfiguracija
q_final = Node(toDeg(finalConfig)', 1); % finalna konfiguracija

boundary.begin = [-180, -180, -180]; % pocetak konfiguracijskog prostora
boundary.end = [180, 180, 180]; % kraj konfiguracijskog prostora
minDistance = 1; % minimalna dopustena distanca do cilja

% xlim([-180, 180]);
% ylim([-180, 180]);
% zlim([-180, 180]);

pltRRT = 0; 

deltaQ = 10; % za koliko se siri stablo

rng(6);
G1 = RRT(maxNodeNum, boundary, deltaQ, minDistance); % inicijalizacija grafa
G2 = RRT(maxNodeNum, boundary, deltaQ, minDistance);

mi = [0.3, 0.18];
eta = 0.35;
[G] = myRoboBiRRT(robot, G1, G2, q_init, q_final, pltRRT, eta, mi);
return;
% Dobivanje vektora svih konfiguracija od po?etne do krajnje
robot.configVector = robot.getMotionConfigVector(G, q_init, q_final);

f = figure;
plot3Dobstacles(obstacles);
xlim([-1, 0.5]);
ylim([-1, 1]);
zlim([-1, 1]);
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
