function avPathCost = getAveragePathCost(robot, path)
%     pathCost = sum(path(end,:));
%     avPathCost = pathCost/length(path(end,:));
    pathCost = 0;
    for i = 1:length(path(1,:))
        robot.currConfig = path(:,i);
        pathCost = pathCost + costFunction(robot);
    end
    
    avPathCost = pathCost / length(path(1,:));
%     display(['Broj cvorova puta: ', num2str(length(path(1,:))), sprintf('\n'), 'Ukupna tezina puta: ',...
%         num2str(pathCost), sprintf('\n'), 'Srednja tezina puta: ', num2str(avPathCost)])
    
end

