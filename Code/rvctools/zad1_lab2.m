mdl_puma560; % ucitavanje modela puma560, varijabla p560 je model robota
%qn = [pi/2 pi/2 2*pi/3 -pi/2 -pi/3 2*pi/3]; % konfiguracija qn
q0 = [0 0 0 0 0 0]; % pocetna konfiguracija 
qn = [-pi pi/2 0 0 pi/5 pi/3]; % krajnja konfiguracija
% generisanje matrice transforamcije T za pumu za zadanu...
% konfiguraciju qn (DH parametri za pumu su vec poznati i nalaze se u objektu p560)
T = p560.fkine(qn); % direktna kinematika i dobivanje matrice T za konfiguraciju qn

% KONFIGURACIJA SE SASTOJI IZ 3 slova   
% 1.  'l'   arm to the left (default)    ili  'r'   arm to the right
% 2.  'u'   elbow up (default)           ili  'd'   elbow down
% 3.  'n'   wrist not flipped (default)  ili  'f'   wrist flipped (rotated by 180 deg)

% pa je mogucih 8 konfiguracija dato kao sljedece kombinacije slova
% lun - arm to the left with elbow up and wrist not flipped
% luf - arm to the left with elbow up and wrist flipped
% ldn - arm to the left with elbow down and wrist not flipped
% ldf - arm to the left with elbow down and wrist flipped
% run - arm to the right with elbow up and wrist not flipped
% ruf - arm to the right with elbow up and wrist flipped
% rdn - arm to the right with elbow down and wrist not flipped
% rdf - arm to the right with elbow down and wrist flipped

% inverzna kinematika koja ce dati konfiguraciju q_xyz s obzirom na 
% matricu transformacije T koja ce dovesti ruku u konfiguraciju qn iz nulte
% konfigureacije q0

t = [0:.05:2]'; % vrijeme trajanje jedne animacije 2 s
%--------------------------------------------------------------------------%
q_lun = p560.ikine6s(T, 'lun'); % inverzna kinematika
qn_lun = jtraj(q0, q_lun, t); % od pocetne do krajnje konfiguracije trajanje 2s
p560.plot(qn_lun); % animacija
%--------------------------------------------------------------------------%
q_luf = p560.ikine6s(T, 'luf');  % inverzna kinematika
qn_luf = jtraj(q0, q_luf, t); % od pocetne do krajnje konfiguracije trajanje 2s
p560.plot(qn_luf); % animacija
%--------------------------------------------------------------------------%
q_ldn = p560.ikine6s(T, 'ldn'); % inverzna kinematika
qn_ldn = jtraj(q0, q_ldn, t); % od pocetne do krajnje konfiguracije trajanje 2s
p560.plot(qn_ldn); % animacija
%--------------------------------------------------------------------------%
q_ldf = p560.ikine6s(T, 'ldf'); % inverzna kinematika
qn_ldf = jtraj(q0, q_ldf, t); % od pocetne do krajnje konfiguracije trajanje 2s
p560.plot(qn_ldf); % animacija
%--------------------------------------------------------------------------%

%--------------------------------------------------------------------------%
q_run = p560.ikine6s(T, 'run'); % inverzna kinematika
qn_run = jtraj(q0, q_run, t); % od pocetne do krajnje konfiguracije trajanje 2s
p560.plot(qn_run); % animacija
%--------------------------------------------------------------------------%
q_ruf = p560.ikine6s(T, 'ruf'); % inverzna kinematika
qn_ruf = jtraj(q0, q_ruf, t); % od pocetne do krajnje konfiguracije trajanje 2s
p560.plot(qn_ruf); % animacija
%--------------------------------------------------------------------------%
q_rdn = p560.ikine6s(T, 'rdn'); % inverzna kinematika
qn_rdn = jtraj(q0, q_rdn, t); % od pocetne do krajnje konfiguracije trajanje 2s
p560.plot(qn_rdn); % animacija
%--------------------------------------------------------------------------%
q_rdf = p560.ikine6s(T, 'rdf'); % inverzna kinematika
qn_rdf = jtraj(q0, q_rdf, t); % od pocetne do krajnje konfiguracije trajanje 2s
p560.plot(qn_rdf); % animacija
%--------------------------------------------------------------------------%

