clear;
close all;

maxNodeNum = 10000; % max number of nodes

q_init = Node([0, 0], 1); % starting configuration

q_final = Node([18, 14], 1); % final configuration

boundary.begin = [0, 0]; % the begining of the configuration space
boundary.end = [20, 20]; % the end of the configuration space

minDistance = 1; % minimal allowed distance to the goal

obstacles = {getRectangle([5,2],3,7); getRectangle([8,13],7,3)};
plot2Dobstacles(obstacles);
%obstacles = make3Dobstacles(); % obstacle creation
%obstacles = make2Dobstacles(); % obstacle creation
pltRRT = 1; 

deltaQ = 1;  % how much the tree expands

rng(6);
G1 = RRT(maxNodeNum, boundary, deltaQ, minDistance, obstacles);% graph initialization
G2 = RRT(maxNodeNum, boundary, deltaQ, minDistance, obstacles);

 [G1, q_end] = findRRT(G1, q_init, q_final, pltRRT, 'RRT');
% q_final = q_end;

% [G] = makeBiRRT(G1, G2, q_init, q_final, pltRRT);
%figure;

G1.plotRRTpath(q_init, q_final);


