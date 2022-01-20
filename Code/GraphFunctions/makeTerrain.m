function [fun] = makeTerrain(boundary, plotTerrain)
    % Function which returns the function of the surface of the terrain and
    % can plot that terrain
    
    % Terrain1

    %fun = @(x,y) exp(-0.05*((x+5).^2+0.5*(x-y).^2))-0.4*exp(-0.05*((x-10).^2+0.5*(x-y).^2))+0.03*sin(x)+0.02*cos(y);

    % Terrain2

    % fun = @(x,y) exp(-0.05*((x+5).^2+0.5*(x-y).^2))+0.4*exp(-0.05*((x-10).^2+0.5*(x-y).^2))+0.03*sin(x)+0.02*cos(y)...
    %     +  exp(-0.05*((x+20).^2+0.05*(x-y-1).^2)) + exp(-0.05*((x-20).^2+0.1*(x-y-20).^2)) + ...
    %     exp(-0.05*((x+12).^2+0.1*(x+y).^2));

    % Terrain3
    fun = @(x,y) exp(-0.05*((x+6).^2+0.5*((x+6)-(y+6)).^2))+0.4*exp(-0.05*((x-12).^2+0.5*(x-y).^2))+0.03*sin(x)+0.02*cos(y)...
        +  exp(-0.05*((x+20).^2+0.05*(x-y-1).^2)) + exp(-0.05*((x-20).^2+0.1*(x-y-20).^2)) + ...
        exp(-0.05*((x+12).^2+0.1*(x+y).^2)) + exp(-0.08*((x-5).^2+0.1*((x-5)+y+7).^2)) - plotTerrain/50;
    d = 1;
    if plotTerrain
        beginX = boundary.begin(1,1);
        finalX = boundary.end(1,1);
        beginY = boundary.begin(1,2);
        finalY = boundary.end(1,2);
        [X,Y] = meshgrid(beginX:d:finalX, beginY:d:finalY);
        Z = fun(X,Y);
        hold on;
        surf(X,Y,Z);
        hold on;
        % x = 20*rand();
        % y = 20*rand();
        colormap(jet);
        xlabel('x');
        ylabel('y');
        zlabel('z');
        % plot3(x,y,fun(x,y),'r.', 'MarkerSize', 25)
        % hold on;
    end
end

