function [ c ] = getTerrainAvCost( G, q1, q2 )
    % returns the average cost of the path on the terrrain
    [v] = G.getShortestPath(q1, q2);
    c = 0;
    for i = 1:length(v)
        c = c + G.nodes(v(i)).coordinates(1,3);
    end
    c = c/length(v);

end

