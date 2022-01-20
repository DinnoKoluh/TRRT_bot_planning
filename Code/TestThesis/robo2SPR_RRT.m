clear;
close all;

L = [1;1];
initConfig = toRad([-166;0]);
finalConfig = toRad([64; 28]);

robot = PlanarArm(L,initConfig, finalConfig);

obstacles = make2Dobstacles();
robot.obstacles = expandObstacles(obstacles,0.0);

maxNodeNum = 1000; % max broj cvorova
q_init = Node(toDeg(initConfig)', 1); % pocetna konfiguracija
q_final = Node(toDeg(finalConfig)', 1); % finalna konfiguracija

boundary.begin = [-180, -180]; % pocetak konfiguracijskog prostora
boundary.end = [180, 180]; % kraj konfiguracijskog prostora
minDistance = 2; % minimalna dopustena distanca do cilja

pltRRT = 0; 

deltaQ = 6; % za koliko se siri stablo

rng(6);

G1 = RRT(maxNodeNum, boundary, deltaQ, minDistance); % inicijalizacija grafa
G2 = RRT(maxNodeNum, boundary, deltaQ, minDistance);

mi = [0.50, 0.20];
eta = 0.33;
[G, Ga, Gb, con] = myRoboBiRRT(robot, G1, G2, q_init, q_final, pltRRT, eta, mi);
return;
open('2SPR_CS.fig');
hold on;
Ga.plotRRT(1,1, 'k');
Gb.plotRRT(1,1, 'b');
G.plotRRTpath(q_init, q_final);
plotEdge(con(1,1),con(2,1),'cyan',3.6);
plotMarker(q_init.coordinates, '$S$');
plotMarker(q_final.coordinates, '$F$');
daspect([1 1 1]);

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

% figure;
% plot2Dobstacles(obstacles);
% hold on;
% robot.bot.plot(robot.configVector','trail', '-');


