clear;
close all;

maxNodeNum = 300; % max broj cvorova

q_init = Node([0, 0], 1); % pocetna konfiguracija

q_final = Node([18, 14], 1); % finalna konfiguracija

boundary.begin = [0, 0]; % pocetak konfiguracijskog prostora
boundary.end = [20, 20]; % kraj konfiguracijskog prostora

minDistance = 1; % minimalna dopustena distanca do cilja

obstacles = {getRectangle([5,4],3,7)*getRotationMatrix(20,'Deg'); getRectangle([2,13],7,3)*getRotationMatrix(15,'Deg')};
plot2Dobstacles(obstacles);
%obstacles = make3Dobstacles(); % pravljenje prepreka
%obstacles = make2Dobstacles(); % pravljenje prepreka
pltRRT = 0; 

deltaQ = 1; % za koliko se siri stablo

rng(7);
G1 = RRT(maxNodeNum, boundary, deltaQ, minDistance, obstacles); % inicijalizacija grafa
G2 = RRT(maxNodeNum, boundary, deltaQ, minDistance, obstacles);

 [G1, q_end] = findRRT(G1, q_init, q_final, pltRRT, 'RRT');
% q_final = q_end;

% [G] = makeBiRRT(G1, G2, q_init, q_final, pltRRT);
%figure;

G1.plotRRT(1,1,'k');
G1.plotRRTpath(q_init, q_final);
daspect([1 1 1]);

