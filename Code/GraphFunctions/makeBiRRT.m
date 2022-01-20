function [G1] = makeBiRRT(G1, G2, q_init, q_final, plotGraph)
    
    maxIter = G1.maxNodeNum + G2.maxNodeNum;
    G1.maxNodeNum = 1;
    G1.addNode(q_init);

    G2.maxNodeNum = 1;
    G2.addNode(q_final);

    i = 1;
    q_1 = Node();
    while i <= maxIter
        if mod(i,2) == 1
            G1.maxNodeNum = G1.getNodeNum + 1;
            [G1, q_1] = findRRT(G1, q_init, q_final, plotGraph, 'BiRRT');
        else
            G2.maxNodeNum = G2.getNodeNum + 1;
            [G2, q_2] = findRRT(G2, q_final, q_init, plotGraph, 'BiRRT');
        end
        % Connection attempt
        q_try = G2.nearestNode(q_1);
        if distance(q_1.coordinates, q_try.coordinates) < G1.minDistance && ...
                ( (checkIntersection(G1.obstacles, q_1.coordinates, q_try.coordinates, 10) || isempty(G1.obstacles)) )
            G1.mergeRRTs(G2, q_1, q_try);
            if plotGraph
                plotEdge(q_try, q_1, 'cyan',4);
            end
            display(['Solution found! (Bidirectional ', class(G1), ').', sprintf('\n'), 'Number of needed iterations: ', ...
                num2str(i)]);
            return;
        end
        i = i + 1;
    end
end

