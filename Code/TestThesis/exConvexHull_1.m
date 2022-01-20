close all;
ob{1,1} = getRectangle([1,1],1,2);
ob{2,1} = getRectangle([-1,-2],3,1);
ob{3,1} = [0 3; -1 2; 1 2];

plot2Dobstacles(ob);
xlabel('$x$','fontsize',25);
ylabel('$y$','fontsize',25);
grid on;
xlim([-2,3]);
ylim([-3,4]);
daspect([1 1 1]);

figure;
ob{1,1} = rotateObstacle(ob{1,1},getRotationMatrix(30,'Deg'),[0,0]);
ob{2,1} = rotateObstacle(ob{2,1},getRotationMatrix(-15,'Deg'),[-1,-2]);
ob{3,1} = rotateObstacle([0 3; -1 2; 1 2], getRotationMatrix(-90,'Deg'), [0 3]);
plot2Dobstacles(ob);
xlabel('$x$','fontsize',25);
ylabel('$y$','fontsize',25);
grid on;
xlim([-2,3]);
ylim([-3,4]);
daspect([1 1 1]);
