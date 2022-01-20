function [ c ] = directCost(robot)
    cost = Inf;
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
    c = exp(-3*cost);

end

