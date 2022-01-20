function [cost] = getCurrConfigCost(robot)
    % taking the current configuration
    cost = Inf;
    if checkRoboIntersection(robot)
        cost = 0;
        return;
    else
%     a = robot.getNthSegmentPosition(robot.dim-1)';
%     b = robot.getNthSegmentPosition(robot.dim)';
%     if isa(robot, 'PlanarArm')
%         a = a(1,1:2);
%         b = b(1,1:2);
%     end
%     if isSegmentInFreeSpace(robot.obstacles, a, b, 15) == 0
%         cost = 0;
%         return;
%     else
        currCost = cost;
        p = robot.getNthSegmentPosition(robot.dim);
        for i = 1:length(robot.obstacles)            
            if isa(robot,'PlanarArm')
                cost = p_poly_dist(p(1,1), p(2,1), robot.obstacles{i,1}(:,1), robot.obstacles{i,1}(:,2));
            else
                [A,b,Aeq,beq] = vert2lcon(robot.obstacles{i,1});
                closest = lsqlin(eye(3),p,A,b,Aeq,beq,[],[],[],robot.options);
                cost = distance(p,closest);
                 
            end
            if cost < currCost
                currCost = cost;
            end
        end
        cost = currCost;
    end

end

