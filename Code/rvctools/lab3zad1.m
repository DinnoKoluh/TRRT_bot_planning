mdl_puma560;
qn = [-pi/3 pi/6 pi/3 0 0 0]; % kofiguracija robota koja daje ce dati P i Phi
init = [0.1 0.1 0.1 0.1 0.1 0.1]'; % pocetni uslov za q (unutar integratora
T = p560.fkine(qn);
p = T(1:3,4);
phi = tr2eul(T);
phi = phi';
input = [p; phi]; % 