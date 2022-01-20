clear;
close all;

maxNodeNum = 1500; % max number of nodes

q_init = Node([0, 0], 1); % starting configuration

q_final = Node([80, 80], 1); % final configuration

boundary.begin = [0, 0]; % the begining of the configuration space
boundary.end = [100, 100]; % the end of the configuration space
minDistance = 0.5; % minimal allowed distance to the goal

obstacles = {};
%obstacles = make3Dobstacles(); % obstacle creation
obstacles = make2Dobstacles(); % obstacle creation
pltRRT = 1; 

deltaQ = 1; % how much the tree expands

rng(5);
G1 = RRT(maxNodeNum, boundary, deltaQ, minDistance, obstacles); % graph initialization
G2 = RRT(maxNodeNum, boundary, deltaQ, minDistance, obstacles);

%  [G1, q_end] = findRRT(G1, q_init, q_final, pltRRT, 'RRT');
%  q_final = q_end;
mi = [0.50, 0.40];
eta = 0.5;
[G] = myBiRRT(G1, G2, q_init, q_final, pltRRT, eta, mi);
%figure;

%G1.plotRRT(1,1,'g')
%G1.plotRRT(1,1, [q_init; q_final]);
G1.plotRRTpath(q_init, q_final);

