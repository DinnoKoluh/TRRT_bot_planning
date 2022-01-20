clear all;
close all;
L = [0.5; 0.5; 0.5; 0.5; 0.5; 0.5];
initConfig = toRad([-90; 0; 0; 0; 0; 0]);

finalConfig = toRad([90;-90; 90; -10; 10; 0]);
%finalConfig = toRad([170;10;-90; -10; 10; 20]);

robot = PlanarArm(L,initConfig, finalConfig);

P1 = getRectangle([1,1.3],1,2);
P2 = getRectangle([-1,1.5],1,2);
obstacles = {P1; P2};
    
%obstacles = makeRobo2Dobstacles();
robot.obstacles = expandObstacles(obstacles,0.0);


maxNodeNum = 1500; % max broj cvorova
q_init = Node(toDeg(initConfig)', 1); % pocetna konfiguracija
q_final = Node(toDeg(finalConfig)', 1); % finalna konfiguracija

boundary.begin = -180*ones(1,6); % pocetak konfiguracijskog prostora
boundary.end = 180*ones(1,6); % kraj konfiguracijskog prostora
minDistance = 1; % minimalna dopustena distanca do cilja

pltRRT = 0; 

deltaQ = 10; % za koliko se siri stablo

rng(6);
G1 = RRT(maxNodeNum, boundary, deltaQ, minDistance); % inicijalizacija grafa
G2 = RRT(maxNodeNum, boundary, deltaQ, minDistance);

mi = [0.5, 0.5];
eta = 0.2;
[G] = myRoboBiRRT(robot, G1, G2, q_init, q_final, pltRRT, eta, mi);

% Dobivanje vektora svih konfiguracija od po?etne do krajnje
robot.configVector = robot.getMotionConfigVector(G, q_init, q_final);

figure;
plot2Dobstacles(obstacles);
hold on;
robot.bot.plot(robot.configVector','trail', '-');

% figure;
% makeRobo2Dobstacles(1);
% robot.plotRobotPath();

% robot.getNthSegmentPathLength(1);
% robot.getNthSegmentPathLength(2);
% robot.getNthSegmentPathLength(3);
% robot.getNthSegmentPathLength(4);
% robot.getNthSegmentPathLength(5);
robot.plotRoboNthSegmentPath(1);
robot.plotRoboNthSegmentPath(2);
robot.plotRoboNthSegmentPath(3);
robot.plotRoboNthSegmentPath(4);
robot.plotRoboNthSegmentPath(5);