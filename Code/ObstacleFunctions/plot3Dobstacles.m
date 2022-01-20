function k1 = plot3Dobstacles(obstacles)
    for i = 1:length(obstacles)
%         if mod(i,2) == 0
%             color = 'r';
%         else
%             color = 'g';
%         end
        color = [0.4660, 0.6740, 0.1880];
        x = obstacles{i,1}(:,1);
        y = obstacles{i,1}(:,2);
        z = obstacles{i,1}(:,3);
        [k1,av1] = convhull(x,y,z);
        hold on;
        trisurf(k1,x,y,z,'FaceColor',color)
        axis equal
        hold on;
    end

end