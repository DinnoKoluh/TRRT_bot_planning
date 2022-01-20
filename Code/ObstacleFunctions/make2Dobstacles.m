function [obstacles] = make2Dobstacles()
    % function which creates obstacles
    % #1
    P1 = getRectangle([1,1],1,2);
    
    P2 = getRectangle([-1,1.2],1,2);

    % cell which contains the obstalcles
    obstacles = {P1; P2};
end

