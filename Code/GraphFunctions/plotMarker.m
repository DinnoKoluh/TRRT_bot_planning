function [] = plotMarker(position, txt)
    if length(position) == 2
        hold on;
        plot(position(1,1), position(1,2) , 'ro', 'MarkerEdgeColor','k',...
        'MarkerFaceColor','g','MarkerSize',10);
        hold on;
        text(position(1,1), position(1,2), txt, 'FontSize',8,...
        'HorizontalAlignment','center');
        hold on;
    elseif length(position) == 3
        hold on;
        plot3(position(1,1), position(1,2), position(1,3) , 'ro', 'MarkerEdgeColor','k',...
        'MarkerFaceColor','g','MarkerSize',10);
        hold on;
        text(position(1,1), position(1,2), position(1,3), txt, 'FontSize',8,...
        'HorizontalAlignment','center');
        hold on;
    else 
        error('Wrong coordinate dimensions!');
    end
end

