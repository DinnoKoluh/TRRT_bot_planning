clear;
close all;
rng(5);

maxNodeNum = 15000; % maksimalan broj iteracije (cvorova)

boundary.begin = [-20, -20]; % pocetak konfiguracijskog prostora
boundary.end = [20, 20]; % kraj konfiguracijskog prostora
plotTerrain = 0;
terrain = makeTerrain(boundary, plotTerrain);

q_init = Node([-17, 19, terrain(-17,19)], 1); % pocetna konfiguracija

q_final = Node([18, 18, terrain(18,18)], 1); % krajnja konfiguracija

minDistance = 2; % minimalna dopustena distanca do cilja

plotT_RRT = 0;

obstacles = {};

deltaQ = 1;

% Karakteristike TRRT-a
T = 1e-6;
K = (terrain(-17,19)+terrain(18,18))/2;
alpha = 1.25;
maxFails = 15;
c_max = 0.38;
rho = 0.05;

G1 = TRRT(maxNodeNum, boundary, deltaQ, minDistance, obstacles);
G1.setTRRTproperties(terrain, T, K, alpha, maxFails, c_max, rho);

G2 = TRRT(maxNodeNum, boundary, deltaQ, minDistance, obstacles);
G2.setTRRTproperties(terrain, T, K, alpha, maxFails, c_max, rho); 

mi = [0.10, 0.10];
eta = 0.5;
[G, Ga, Gb, con] = myBiRRT(G1, G2, q_init, q_final, plotT_RRT, eta, mi);


 figure;
 plotTerrain = 1;
 terrain = makeTerrain(boundary, plotTerrain);
 G1.plotRRT(1,1,'y');
 G2.plotRRT(1,1,'y');
  G1.plotRRTpath(q_init, q_final);
%  plotEdge(con(1,1),con(2,1),'r',2.5)

plotMarker(q_init.coordinates, '$S$');
plotMarker(q_final.coordinates, '$F$');
zlim([-0.2,1.1]);
%daspect([1 1 1]);
%set(gcf, 'Renderer', 'Painters');
% type - 'RRT', 'TRRT'




