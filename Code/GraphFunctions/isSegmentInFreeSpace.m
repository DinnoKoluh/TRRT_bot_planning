function [inter, points] = isSegmentInFreeSpace (obstacles, p1, p2, disect)
    % A function which checks if the segments between p1/p2 intersects an
    % obstacle. We discretize the segment into points and with the function
    % inhull check if the points are inside or outside the obstacle

    % 0 - segment in Cobs - intersects the obstacle
    % 1 - segment in Cfree - doesn't intersect the obstacle
    inter = 1;
    %disect = 25; % on how many points to dicretize the segment

    dim = length(p1); % space dimension
    points = zeros(disect, dim); % discretized points

    for i = 1:dim
        points(:,i) = linspace(p1(1,i), p2(1,i), disect);
    end
%     hold on;
%     plot3(points(:,1),points(:,2),points(:,3),'b.')
    for i = 1:length(obstacles)
        if sum(inhull(points, obstacles{i,1})) > 0 
            inter = 0;
            return;
        end
%         for j = 1:length(points)
%             if inhull(points(j,:), obstacles{i,1}) == 1
%                 inter = 0;
%                 return;
%             end
%         end
    end

end
