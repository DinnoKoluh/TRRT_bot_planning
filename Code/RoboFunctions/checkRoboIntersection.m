function [intersection] = checkRoboIntersection(robot)

%     for i = 1:robot.dim
%         if i == 1
%             if isa(robot,'PlanarArm')
%                 p1 = zeros(1,2);
%             elseif isa(robot, 'AnthroArm') || isa(robot, 'SphericalWrist') || isa(robot, 'AnthroSphericalArmWrist')
%                 p1 = zeros(1,3);
%             end
%         end
%         p2 = robot.getNthSegmentPosition(i)';
%         if isa(robot, 'PlanarArm')
%             p2 = p2(1,1:2);
%         end
%         % rastaviti zglob robota na n dijelva i provjeriti da li sjece
%         % prepreke
%         if isSegmentInFreeSpace(robot.obstacles, p1, p2, 15) == 0
%             intersection = 1;
%             return;
%         end
%         p1 = p2;
%     end
%     intersection = 0;
    
    
    for i = 1:robot.dim
        if i == 1
            if isa(robot,'PlanarArm')
                P = zeros(robot.dim+1,2);
            elseif isa(robot, 'AnthroArm') || isa(robot, 'SphericalWrist') || isa(robot, 'AnthroSphericalArmWrist')
                P = zeros(robot.dim+1,3);
            end
        end
        p2 = robot.getNthSegmentPosition(i)';
        if isa(robot, 'PlanarArm')
            p2 = p2(1,1:2);
        end
        P(i+1,:) = p2;
        % decompose the robot joint into n parts and check if there is an intersection
    end
    
    for i = 0:robot.dim-1
        if isSegmentInFreeSpace(robot.obstacles, P(robot.dim+1-i,:), P(robot.dim-i,:), 15) == 0
            intersection = 1;
            return;
        end
    end
    intersection = 0;
    
    
end

