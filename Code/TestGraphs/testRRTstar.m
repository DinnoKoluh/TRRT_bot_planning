clear;
close all;

maxNodeNum = 500; % max number of nodes

q_init = Node([50, 50], 1); % starting configuration

q_final = Node([90, 90], 1); % final configuration

boundary.begin = [0, 0]; % the begining of the configuration space
boundary.end = [100, 100]; % the end of the configuration space

minDistance = 4; % minimal allowed distance to the goal

obstacles = {};
%obstacles = make3Dobstacles(); % obstacle creation
%obstacles = make2Dobstacles(); % obstacle creation
pltRRT = 1; 

deltaQ = 2;  % how much the tree expands

rng(4);
G1 = RRTstar(maxNodeNum, boundary, deltaQ, minDistance, obstacles); % graph initialization
G1.gamma = 0;

[G1, q_end] = findRRTstar(G1, q_init, q_final, pltRRT, 'RRT');

%G1.getNodeIndexes()
%G1.getEdgeMatrix()

% G1.removeEdge(G1.nodes(4,1), G1.nodes(5,1));
% G1.removeNode(G1.nodes(3,1));
% figure;
% G1.getEdgeMatrix()
% %G1.edges(3,1).node1;
% G1.getNodeIndexes()
% G1.plotRRT(1,1)
%q_final = q_end;
%plot(G1.getMatlabGraph)
%G1.plotRRT(1,1, [q_init; q_final]);
G1.plotRRTpath(q_init, q_end);
