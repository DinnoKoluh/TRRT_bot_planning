function [ rect ] = makeRectangularSolid(init, d)
    % Function which creates a rectangular solid
    dx = d(1,1);
    dy = d(1,2);
    dz = d(1,3);
    newInit = [init; init; init; init; init; init; init; init];
    vek(1,:) = [0,0,0];
    vek(2,:) = [dx,0,0];
    vek(3,:) = [0,dy,0];
    vek(4,:) = [0,0,dz];
    vek(5,:) = [dx,dy,0];
    vek(6,:) = [0,dy,dz];
    vek(7,:) = [dx,0,dz];
    vek(8,:) = [dx,dy,dz];
    rect = vek + newInit;
end

