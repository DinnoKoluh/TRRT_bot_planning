figure;
grid on;
plot2Dobstacles({obstacles{1,1}},'r');
hold on;
plot2Dobstacles({obstacles{2,1}},'g');
hold on;
robot.currConfig = initConfig;
robot.plotSegments('$Start$');
robot.currConfig = finalConfig;
robot.plotSegments('$Final$');

xlim([-3,3]);
ylim([-3,4]);
xlabel('$x$','fontsize',25);
ylabel('$y$','fontsize',25);
daspect([1 1 1]);

figure;
open('roboConfigSpace1.fig');
daspect([1 1 1]);
plotMarker(q_init.coordinates, '$S$');
plotMarker(q_final.coordinates, '$F$');