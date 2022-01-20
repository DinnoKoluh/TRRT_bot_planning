% Upisa DH parametara
Link1 = Link('d', 0, 'a', 0, 'alpha', pi/2); %Prvi link 
Link2 = Link('d', 0, 'a', 0.4318, 'alpha', 0); %Drugi link
Link3 = Link('d', 0.15, 'a', 0.0203, 'alpha', -pi/2); %Treci link 
Link4 = Link('d', 0.4318, 'a', 0, 'alpha', pi/2); %Cetvrti link
Link5 = Link('d', 0, 'a', 0, 'alpha', -pi/2); %Peti link 
Link6 = Link('d', 0, 'a', 0, 'alpha', 0); %Sesti link

my_robot = SerialLink([Link1 Link2 Link3 Link4 Link5 Link6]); % Povezivanje
% Plotanje + animacija sa teach metodom i inicijalizacija
% zakretaja pojedinih zglobova na nulte pocetne uslove
my_robot.teach([0.0 0.0 0.0 0.0 0.0 0.0]); 
