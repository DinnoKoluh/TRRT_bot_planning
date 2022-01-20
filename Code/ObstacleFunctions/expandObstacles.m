function [exObstacles] = expandObstacles(obstacles, ex)
    % A function which stretches the obstacles in all directions by the sam
    % amount
    num = length(obstacles);
    exObstacles = obstacles;
    for i = 1:num
        m = mean(obstacles{i,1});
        for j = 1:length(obstacles{i,1})
            vector = obstacles{i,1}(j,:) - m;
            unit_vector = vector / distance(m, obstacles{i,1}(j,:));
            exObstacles{i,1}(j,:) = obstacles{i,1}(j,:) + ex * unit_vector;
        end
    end
end

