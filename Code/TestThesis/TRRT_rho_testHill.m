clear;
rho_prim = [0.001 0.01 0.05 0.1 0.5 1];
to = 6;

L_KP = zeros(to, 1);
c_av = zeros(to, 1);
iterN = zeros(to, 1);
nodeN = zeros(to, 1);
time = zeros(to, 1);

for i = 1:to
    rho = rho_prim(i);
    testTRRT;

    [~, lenKP] = G1.getShortestPath(q_init, q_final);
    c = getTerrainAvCost(G1, q_init, q_final);



    L_KP(i,1) = lenKP;
    c_av(i,1) = c;
    iterN(i,1) = numOfIterations;
    nodeN(i,1) = G1.getNodeNum;
    time(i,1) = t2;
end

out = [rho_prim' L_KP c_av iterN nodeN time];

