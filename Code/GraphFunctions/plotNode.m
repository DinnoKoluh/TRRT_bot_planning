function [] = plotNode(q, color, size)
    % Functions which plots a graph node
    if length(q.coordinates) == 2
        hold on;
        plot(q.coordinates(1,1), q.coordinates(1,2), color, 'MarkerSize', size);
        hold on;
    elseif length(q.coordinates) == 3
        hold on;
        plot3(q.coordinates(1,1), q.coordinates(1,2), q.coordinates(1,3), color, 'MarkerSize', size);
        hold on;
    end

end

