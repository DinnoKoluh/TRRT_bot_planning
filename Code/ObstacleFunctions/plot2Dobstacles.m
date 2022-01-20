function plot2Dobstacles(obstacles, varargin)
    color = [0.4660, 0.6740, 0.1880];
    if nargin == 2
        color = varargin{1};
    end
    for i = 1:length(obstacles)
        k = convhull(obstacles{i,1});
        hold on;
        fill(obstacles{i,1}(k,1),obstacles{i,1}(k,2),'r','FaceColor',color);
        m = mean(obstacles{i,1});
        hold on;
        txt = strcat('$\mathcal{W}_{ob_{',num2str(i),'}}$');
        text(m(1,1),m(1,2),txt,  'FontSize',15);
        hold on;  
    end

end

