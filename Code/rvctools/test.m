DH_ex = [0 0 0 pi/2; 0 0 0.4318 0; 0 0.15 0.0203 -pi/2; 0 0.4318 0 pi/2; 0 0 0 -pi/2; 0 0 0 0];
q = [0 0 0 0 0 0];
draw = 1;
my_fkine(DH_ex, q', draw);

ex = SerialLink(DH_ex);
ex.plot(q);
out = ex.fkine(q)
% mozemo vidjeti da su identicni rezultati