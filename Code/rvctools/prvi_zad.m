Link1 = Link('d', 0, 'a', 15, 'alpha', 0); %Prvi link 
Link2 = Link('d', 0, 'a', 25, 'alpha', 0); %Drugi link
my_robot = SerialLink ([Link1 Link2]); % Povezivanje linkova
my_robot.plot([-0.3 -0.4]); % Plotanje i inicijalizacija zakretaja ruke