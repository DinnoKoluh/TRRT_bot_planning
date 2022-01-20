mdl_puma560; % ucitavanje modela puma560, varijabla p560 je model robota
q0 = [0 0 0 0 0 0]; % pocetna konfiguracija 
qn = [-pi pi/2 0 0 pi/5 pi/3]; % krajnja konfiguracija
T0 = p560.fkine(q0); % direktna kinematika i dobivanje matrice T za konfiguraciju q0
Tn = p560.fkine(qn); % direktna kinematika i dobivanje matrice T za konfiguraciju qn

t = [0:.05:4]'; % vrijeme trajanje jedne animacije 2 s
%--------------------------------------------------------------------------%
q_jtraj = jtraj(q0, qn, t); % od pocetne do krajnje konfiguracije trajanje 4s
T_ctraj = ctraj(T0, Tn, 50);
q_ctraj = p560.ikine6s(T_ctraj);
p560.plot(q_jtraj); % animacija za jtraj
p560.plot(q_ctraj); % animcija za ctraj

figure;
% za jtraj plotovi
subplot(3,2,1); plot(t, q_jtraj(:,1)); xlabel('Time [s]'); ylabel('Joint1 [rad]'); grid on;
subplot(3,2,2); plot(t, q_jtraj(:,2)); xlabel('Time [s]'); ylabel('Joint2 [rad]'); grid on;
subplot(3,2,3); plot(t, q_jtraj(:,3)); xlabel('Time [s]'); ylabel('Joint3 [rad]'); grid on;
subplot(3,2,4); plot(t, q_jtraj(:,4)); xlabel('Time [s]'); ylabel('Joint4 [rad]'); grid on;
subplot(3,2,5); plot(t, q_jtraj(:,5)); xlabel('Time [s]'); ylabel('Joint5 [rad]'); grid on;
subplot(3,2,6); plot(t, q_jtraj(:,6)); xlabel('Time [s]'); ylabel('Joint6 [rad]'); grid on;
% za ctraj plotovi
figure;
subplot(3,2,1); plot(q_ctraj(:,1)); xlabel('Time [s]'); ylabel('Joint1 [rad]'); grid on;
subplot(3,2,2); plot(q_ctraj(:,2)); xlabel('Time [s]'); ylabel('Joint2 [rad]'); grid on;
subplot(3,2,3); plot(q_ctraj(:,3)); xlabel('Time [s]'); ylabel('Joint3 [rad]'); grid on;
subplot(3,2,4); plot(q_ctraj(:,4)); xlabel('Time [s]'); ylabel('Joint4 [rad]'); grid on;
subplot(3,2,5); plot(q_ctraj(:,5)); xlabel('Time [s]'); ylabel('Joint5 [rad]'); grid on;
subplot(3,2,6); plot(q_ctraj(:,6)); xlabel('Time [s]'); ylabel('Joint6 [rad]'); grid on;