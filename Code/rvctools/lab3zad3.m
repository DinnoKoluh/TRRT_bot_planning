mdl_puma560;
% Zadatak sam radio na nacin generisanja tacaka preko jednacina pravih
% jer se ispostavilo jako tesko naci tacke na slijep ako ne znamo jednacine
% jer cesto puma ode u singularne tacke, a i ovako je lakse mijenjati
% dimenzije slova. Takodjer samo promatrao slucaj kada da robot ne smije
% opet da crta po vec crtanim linijama tako da kad se vraca nazad on se
% digne za "d" da ne ide po vec nacrtanim linijama. Pocinjem iz donjeg
% lijevog ugla i zavrsama u istom. "C" je visina na kojoj se crta slovo.
C = 0.2;
d = 0.2;
% donja lijeva tacka
x1 = -0.3;
y1 = 0.0;
% vrh
x2 = 0.0;
y2 = 0.6;

ka = (y1-y2)/(x1-x2);
La = (x1*y2-x2*y1)/(x1-x2);

% donja desna tacka, x3 je takvo da slovo bude simetricno u odnosu na vrh
y3 = y1;
x3 = 2*x2-x1;

kb = (y2-y3)/(x2-x3);
Lb = (x2*y3-x3*y2)/(x2-x3);

% koordinate horizontalne linije
y4 = 0.3;
y5 = y4;

x4 = (y4-Lb)/kb;
x5 = (y5-La)/ka;

lijeviDonjiVrh = [x1, y1, C];
vrh = [x2, y2, C];
desniDonjiVrh = [x3, y3, C];
digniSeSaDesnogDonjegVrha = [x3, y3, C+d];
odiISpustiSeNaPocetakHorizontale = [x4,y4,C];
odiNaDrugiKrajHorizontale = [x5, y5, C];
odiDigniIOdiNaPocetak = [x1, y1, C+d];
spustiNaPocetak = [x1, y1, C];

T1 = transl(lijeviDonjiVrh);
T2 = transl(vrh);
T3 = transl(desniDonjiVrh);
T4 = transl(digniSeSaDesnogDonjegVrha);
T5 = transl(odiISpustiSeNaPocetakHorizontale);
T6 = transl(odiNaDrugiKrajHorizontale);
T7 = transl(odiDigniIOdiNaPocetak);
T8 = transl(spustiNaPocetak);

T_lijevo_vrh = ctraj(T1, T2, 20);
T_vrh_desno = ctraj(T2, T3, 20);
T_desno_gore = ctraj(T3, T4, 10);
T_gore_horiz = ctraj(T4, T5, 15);
T_horiz_horiz = ctraj(T5, T6, 20);
T_nazad = ctraj(T6,T7,20);
T_nazad_na_pocetak = ctraj(T7,T8,10);

q_lijevo_vrh = p560.ikine6s(T_lijevo_vrh);
q_vrh_desno = p560.ikine6s(T_vrh_desno);
q_desno_gore = p560.ikine6s(T_desno_gore);
q_gore_horiz = p560.ikine6s(T_gore_horiz);
q_horiz_horiz = p560.ikine6s(T_horiz_horiz);
q_nazad = p560.ikine6s(T_nazad);
q_nazad_na_pocetak = p560.ikine6s(T_nazad_na_pocetak);

Q = [q_lijevo_vrh; q_vrh_desno; q_desno_gore; q_gore_horiz; q_horiz_horiz; q_nazad; q_nazad_na_pocetak];
p560.plot(Q,'trail', '-'); % animcija za ctraj