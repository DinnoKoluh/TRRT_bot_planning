%clear;
close all;
rng(13);
t1 = tic;

maxNodeNum = 20000; % max number of nodes

boundary.begin = [-20, -20]; % the begining of the configuration space
boundary.end = [20, 20]; % the end of the configuration space
plotTerrain = 1;
terrain = makeTerrain(boundary, plotTerrain);

q_init = Node([-17, 19, terrain(-17,19)], 1); % starting configuration

q_final = Node([18, 18, terrain(18,18)], 1); % final configuration

minDistance = 2; % minimal allowed distance to the goal

plotT_RRT = 1;

obstacles = {};

deltaQ = 1;

% TRRT characteristics
T = 5e-5;
K = (terrain(-17,19)+terrain(18,18))/2;
alpha = 1.5;
maxFails = 20;
c_max = 0.38;
rho = 0.05;
rho
G1 = TRRT(maxNodeNum, boundary, deltaQ, minDistance, obstacles);
G1.setTRRTproperties(terrain, T, K, alpha, maxFails, c_max, rho);

G2 = TRRT(maxNodeNum, boundary, deltaQ, minDistance, obstacles);
G2.setTRRTproperties(terrain, T, K, alpha, maxFails, c_max, rho); 

%[G, q_end] = makeTRRT(G, q_init, q_final, plotT_RRT);
% [G1, q_end] = findRRT(G1, q_init, q_final, plotT_RRT, 'TRRT');
% q_final = q_end;

%[G] = makeBiRRT(G1, G2, q_init, q_final, plotT_RRT);

mi = [0.15, 0.15];
eta = 0.25;
[G, Ga,Gb,con, numOfIterations] = myBiRRT(G1, G2, q_init, q_final, plotT_RRT, eta, mi);
%  figure;
t2  = toc(t1);
return;
 plotTerrain = 1;
 terrain = makeTerrain(boundary, plotTerrain);
 G1.plotRRT(1,1,'k');
 G2.plotRRT(1,1,'y');
 G1.plotRRTpath(q_init, q_final);

% type - 'RRT', 'TRRT'




