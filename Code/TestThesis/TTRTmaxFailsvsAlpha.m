clear;
alpha_prim = [2 5 10 20 50 100];
maxFails_prim = [2 5 10 20 35 70];
to = 6;
[X,Y] = meshgrid(1:1:to);

L_RP = zeros(to, to);
L_KP = zeros(to, to);
c_av = zeros(to, to);
iterN = zeros(to, to);
nodeN = zeros(to, to);
time = zeros(to, to);

for i = 1:to
    alpha = alpha_prim(i);
    for j = 1:to
        maxFails = maxFails_prim(j);
        alpha
        maxFails
        TRRT_TESTING;
        robot.configVector = robot.getMotionConfigVector(G, q_init, q_final);
        
        lenRP = robot.getNthSegmentPathLength(robot.dim);
        [~, lenKP] = G1.getShortestPath(q_init, q_final);
        c = getAveragePathCost(robot, robot.configVector);
        
        
        
        L_RP(i,j) = lenRP;
        L_KP(i,j) = lenKP;
        c_av(i,j) = c;
        iterN(i,j) = numOfIterations;
        nodeN(i,j) = G1.getNodeNum;
        time(i,j) = t2;
    end
end


