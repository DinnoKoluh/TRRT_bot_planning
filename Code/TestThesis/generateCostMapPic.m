% Parametri radnog prostora 
% Planarna dvosegmentna ruka
L = [1;1];
initConfig = [toRad(160); toRad(5)];
finalConfig = [toRad(20); toRad(-5)];

robot = PlanarArm(L,initConfig, finalConfig);

robot.obstacles = make2Dobstacles();

d = zeros(1,1);
a = 0;
b = 0;
in = 5;
for i = -180:in:180
    i
    a = a + 1;
    b = 0;
    for j = -180:in:180
        b = b + 1;
        robot.currConfig = toRad([i;j]);
        cost = costFunction(robot)-0.05;
        d(b,a) = cost;             

    end
end
[X,Y] = meshgrid(-180:in:180);
surf(X,Y,d);
xlim([-180,180]);
ylim([-180,180]);
zlim([-0.05,1]);
grid on;
xlabel('$q_1[^{\circ}]$','fontsize',25);
ylabel('$q_2[^{\circ}]$','fontsize',25);
zlabel('$c = f_c(q_1,q_2)$','fontsize',25);
ax=gca;
ax.XTick = -180:45:180;
ax.YTick = -180:45:180;
