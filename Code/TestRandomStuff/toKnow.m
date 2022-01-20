% stvara slike konfiguracija
robot.bot.plot(robot.configVector', 'movie', 'N') 
% vraca uglove sa animacije
q = robot.bot.getpos();


[M,c] = contourf(d,'.');
colormap(jet);
colormap(flipud(bonde));
shading interp

% pisanje latex
set(0,'defaulttextinterpreter','latex');

%  odnos osa bude isti
daspect([1 1 1]);

% renderoanje slike
set(gcf, 'Renderer', 'Painters');
set(gcf,'renderer','opengl'); % ocuva transparency

% MOZDA POSLIJE DODATI U LATEX UPRAVLJANJE SIRENJEM STABLA KADA JE ETA =
% 0.5


f.GraphicsSmoothing = 'off';


ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.XColor = 'r';