    close all;
    initx = 0;
    inity = 0;
    initz = 0;

    dx = 0.3;

    sirina_gd = 3.5;
    sirina_ld = 0.7;

    visinaz = 3.5;
    dz = 0.7;

    obstacles = {};
    obstacles{1,1} = makeRectangularSolid([initx, inity, initz],[dx, sirina_ld,  visinaz]);
    obstacles{2,1} = makeRectangularSolid([initx, inity + sirina_gd - sirina_ld, initz], [dx,sirina_ld,visinaz]);
    obstacles{3,1} = makeRectangularSolid([initx, inity, initz + visinaz - dz], [dx, sirina_gd, dz]);
    obstacles{4,1} = makeRectangularSolid([initx, inity, initz], [dx, sirina_gd, dz]);
    ob = {};
    for i = 1:length(obstacles)
        x = obstacles{i,1}(:,1);
        y = obstacles{i,1}(:,2);
        z = obstacles{i,1}(:,3);
        ob{i,1} = [z,y,x];
    end

figure;
plot3Dobstacles(obstacles);
xlabel('$x$','fontsize',25);
ylabel('$y$','fontsize',25);
zlabel('$z$','fontsize',25);
grid on;
xlim([-2,2]);
ylim([-1,4]);
zlim([-1,4]);
%line([0,0,-5],[0,0,-5],[0,0,-5]);
daspect([1 1 1]);
plot3([0,0],[0,0],[-5,5],'k','LineWidth',2);

figure;
for i = 1:4
    obstacles{i,1} = rotateObstacle(obstacles{i,1},getRotationMatrix([0;0;90],'Deg'), [0,0,0]);
end
plot3Dobstacles(obstacles);
xlabel('$x$','fontsize',25);
ylabel('$y$','fontsize',25);
zlabel('$z$','fontsize',25);
grid on;
xlim([-1,4]);
ylim([-2,2]);
zlim([-1,4]);
daspect([1 1 1]);
plot3([0,0],[0,0],[-5,5],'k','LineWidth',2);
