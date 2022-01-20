clear all;
close all;
L = [1; 0.5; 0.5];

initConfig = toRad([-170; 0; 0]);
finalConfig = toRad([61; 28; 2]);

robot = PlanarArm(L,initConfig, finalConfig);

P1 = rotateObstacle(getRectangle([1,0.5],2,1),getRotationMatrix(-10,'Deg'), [1,0.5]);
P2 = rotateObstacle(getRectangle([-0.8,1.0],0.5,2),getRotationMatrix(20,'Deg'), [-0.8,1.0]);
obstacles = {P1; P2};

robot.obstacles = obstacles;
%robot.obstacles = {};

maxNodeNum = 1500; % max broj cvorova
q_init = Node(toDeg(initConfig)', 1); % pocetna konfiguracija
q_final = Node(toDeg(finalConfig)', 1); % finalna konfiguracija

boundary.begin = [-180, -180, -180]; % pocetak konfiguracijskog prostora
boundary.end = [180, 180, -180]; % kraj konfiguracijskog prostora
minDistance = 1; % minimalna dopustena distanca do cilja

pltRRT = 0; 

deltaQ = 8; % za koliko se siri stablo

rng(6);
G1 = RRT(maxNodeNum, boundary, deltaQ, minDistance); % inicijalizacija grafa
G2 = RRT(maxNodeNum, boundary, deltaQ, minDistance);

mi = [0.25, 0.15];
eta = 0.2;
[G, Ga, Gb, con] = myRoboBiRRT(robot, G1, G2, q_init, q_final, pltRRT, eta, mi);
return;
open('2SPR_CS.fig');
% hold on;
% Ga.plotRRT(1,1, 'k');
% Gb.plotRRT(1,1, 'b');
% G.plotRRTpath(q_init, q_final);
% plotEdge(con(1,1),con(2,1),'cyan',3.6);
% plotMarker(q_init.coordinates, '$S$');
% plotMarker(q_final.coordinates, '$F$');
% daspect([1 1 1]);

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
ylim([-2.5,3]);
daspect([1 1 1]);

[v, len] = G1.getShortestPath(q_init, q_final);
len
robot.getNthSegmentPathLength(robot.dim);

getAveragePathCost(robot, robot.configVector);