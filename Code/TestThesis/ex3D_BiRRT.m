clear;
close all;

maxNodeNum = 70; % max broj cvorova

q_init = Node([1, 1, 1], 1); % pocetna konfiguracija

q_final = Node([18, 14, 17], 1); % finalna konfiguracija

boundary.begin = [0, 0, 0]; % pocetak konfiguracijskog prostora
boundary.end = [20, 20, 20]; % kraj konfiguracijskog prostora

minDistance = 3; % minimalna dopustena distanca do cilja

obstacles = {makeRectangularSolid([10,8,5],[5,5,9])*getRotationMatrix([12;20;15],'Deg');...
    makeRectangularSolid([2,2,8],[5,4,3])*getRotationMatrix([-10;0;-10],'Deg')};
plot3Dobstacles(obstacles);
%obstacles = make3Dobstacles(); % pravljenje prepreka
%obstacles = make2Dobstacles(); % pravljenje prepreka
pltRRT = 0; 

deltaQ = 1; % za koliko se siri stablo

rng(7);
G1 = RRT(maxNodeNum, boundary, deltaQ, minDistance, obstacles); % inicijalizacija grafa
G2 = RRT(maxNodeNum, boundary, deltaQ, minDistance, obstacles);

mi = [0.00, 0.0];
eta = 0.50;
[G, con] = myBiRRT(G1, G2, q_init, q_final, pltRRT, eta, mi);
%figure;

G1.plotRRT(1,1, 'k');
G2.plotRRT(1,1, 'b');
%plotEdge(con(1,1),con(2,1),'y',1.6);
G1.plotRRTpath(q_init, q_final);
plotMarker(q_init.coordinates, '$S$');
plotMarker(q_final.coordinates, '$F$');
daspect([1 1 1]);
zlim([0,20]);
