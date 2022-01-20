d = zeros(1,1);
a = 0;
b = 0;
init = -10;
final = 10;
inc = 1;
digits(3)
set(0,'defaulttextinterpreter','latex');
for i = init:inc:final
    a = a + 1;
    b = 0;
    for j = init:inc:final
        b = b + 1;
        cost = 0.25*distance([0,0],[i,j])^2;
        cost = exp(-0.05*distance([-5,0],[i,j])^2) + exp(-0.2*distance([5,8],[i,j])^2);
        %cost = 1/(1+0.0025*distance([0,0],[i,j])^2);
        d(b,a) = cost;             
        plot3(i,j,cost+5, 'k.', 'MarkerSize', 10);
        hold on;
        text(i+0.1,j-0.2,cost+20,[num2str(round(cost,2))], 'Color', 'k', 'FontSize',8)
        hold on;
    end
end
hold on;
[X,Y] = meshgrid(init:inc:final);
grid on;
surf(X,Y,d);
xlabel('$x_1$','fontsize',25);
ylabel('$x_2$','fontsize',25);
zlabel('$x_3$','fontsize',25);
daspect([1 1 1]);
% zlim([0,50])
% text(-5,0,1.2,['$\mathbf{x}_0$'], 'Color', 'k', 'FontSize',15);
% hold on;
% text(5,8,1.2,['$\mathbf{x}_1$'], 'Color', 'k', 'FontSize',15);
%colormap(autumn);


