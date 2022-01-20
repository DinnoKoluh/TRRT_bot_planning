function [col] = checkRoboMove(robot, config1, config2, disect)
    % Function which checks if there is a collision between the robot and
    % the obstacles if the initial and final configurations are given and
    % the robot moves uniformly from the initial to the final configuration
    configs = zeros(robot.dim, disect);
    for i = 1:robot.dim
        configs(i,:) = linspace(config1(i,1), config2(i,1), disect);
    end
    for i = 1:disect
        robot.currConfig = configs(:,i);
        %robot.plotSegments(i);
        if checkRoboIntersection(robot)
            col = 1;
            return;
        end
    end
    col = 0;

end

