function [] = plotEdge(q_1, q_2, color, width)
    % A functions which plots an edge of the graph
    if length(q_1.coordinates) == 2
        hold on;
        plot([q_1.coordinates(1,1) q_2.coordinates(1,1)], [q_1.coordinates(1,2) q_2.coordinates(1,2)],color,'LineWidth',width);
        hold on;
    elseif length(q_1.coordinates) == 3
        hold on;
        plot3([q_1.coordinates(1,1) q_2.coordinates(1,1)], ...
            [q_1.coordinates(1,2) q_2.coordinates(1,2)],...
            [q_1.coordinates(1,3) q_2.coordinates(1,3)],color,'LineWidth',width);
        hold on;
    end
end

