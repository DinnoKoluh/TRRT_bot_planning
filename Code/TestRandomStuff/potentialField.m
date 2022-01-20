L = [1;1];
initConfig = [toRad(160); toRad(5)];
finalConfig = [toRad(20); toRad(-5)];

robot = PlanarArm(L,initConfig, finalConfig);

obstacles = make2Dobstacles();
robot.obstacles = {obstacles{1,1}};

d = zeros(1,1);
a = 0;
b = 0;
in = 10;
for i = -180:in:180
    i
    a = a + 1;
    b = 0;
    for j = -180:in:180
        b = b + 1;
        robot.currConfig = toRad([i;j]);
        cost = costFunction(robot);
        %d(b,a) = exp(-distance([i,j],[0,0])/180);             
        %d(b,a) = -(distance([i,j],[0,0])/180)/exp(-distance([i,j],[0,0])/180);  
        d(b,a) = -(distance([i,j],[0,0])/180)/exp(-distance([i,j],[0,0])/180)-cost; 
        if cost == 1
            plot(i,j,'rx');
            hold on;
        end
    end
end
[X,Y] = meshgrid(-180:in:180);

% hold on;
% open('2SPR_CS.fig');
hold on;
[DX,DY] = gradient(d,in);
quiver(X,Y,DX,DY,1)
hold on
contour(X,Y,d)
        
        
        