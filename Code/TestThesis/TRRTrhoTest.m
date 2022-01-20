clear;
rho_prim = [0.001 0.005 0.01 0.05 0.1 0.5];
to = 6;

L_RP = zeros(to, 1);
L_KP = zeros(to, 1);
c_av = zeros(to, 1);
iterN = zeros(to, 1);
nodeN = zeros(to, 1);
time = zeros(to, 1);

for i = 1:to
    rho = rho_prim(i);
    TRRT_TESTING;
    robot.configVector = robot.getMotionConfigVector(G, q_init, q_final);

    lenRP = robot.getNthSegmentPathLength(robot.dim);
    [~, lenKP] = G1.getShortestPath(q_init, q_final);
    c = getAveragePathCost(robot, robot.configVector);



    L_RP(i,1) = lenRP;
    L_KP(i,1) = lenKP;
    c_av(i,1) = c;
    iterN(i,1) = numOfIterations;
    nodeN(i,1) = G1.getNodeNum;
    time(i,1) = t2;
end


