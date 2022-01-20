clear;
close all;

L = [1;1];
initConfig = toRad([-120;-30]);
finalConfig = toRad([-0; 150]);

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

pltRRT = 0; 
% xlim([-180, 180]);
% ylim([-180, 180]);
open('roboConfigSpace1.fig');
hold on;

deltaQ = 10; % za koliko se siri stablo

rng(5);

G1 = RRT(maxNodeNum, boundary, deltaQ, minDistance); % inicijalizacija grafa
G2 = RRT(maxNodeNum, boundary, deltaQ, minDistance);

mi = [1, 1];
eta = 0;
[G, Ga, Gb, con] = myRoboBiRRT(robot, G1, G2, q_init, q_final, pltRRT, eta, mi);
G1.plotRRT(1,1, 'k');
G1.plotRRTpath(q_init, q_final);

plotMarker(q_init.coordinates, '$S$');
plotMarker(q_final.coordinates, '$F$');


% Dobivanje vektora svih konfiguracija od po?etne do krajnje
robot.configVector = robot.getMotionConfigVector(G, q_init, q_final);

figure;
grid on;
plot2Dobstacles({obstacles{1,1}},'r');
hold on;
plot2Dobstacles({obstacles{2,1}},'g');
hold on;
robot.plotRobotPath();
xlim([-3,3]);
ylim([-3,4]);
xlabel('$x$','fontsize',25);
ylabel('$y$','fontsize',25);
% 
% hold on;
% robot.plotRoboNthSegmentPath(2);
% hold on;
% robot.plotRoboNthSegmentPath(1);
% 
% robot.getNthSegmentPathLength(1);
% robot.getNthSegmentPathLength(2);

% figure;
% plot2Dobstacles(obstacles);
% hold on;
% robot.bot.plot(robot.configVector','trail', '-');