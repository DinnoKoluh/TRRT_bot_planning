function [ T ] = my_fkine( DHtable, q, draw )
[m,n] = size(DHtable); % m,n dimenzije DH tabele (n = 4)
T = eye(n); % postavljanje matrice T na jedinicnu za pocetak
P = zeros(n); % matrica nula za crtanje
% prolazak kroz sve redove DH tabele
    for i=1:m
        % Citanje parametara sa tabele kao u zadatku 2
        theta = DHtable(i,1) + q(i,1); % sabiranje pocetne konfiguracije na postojecu
        d = DHtable(i,2);
        a = DHtable(i,3);
        alpha = DHtable(i,4);
        %matrica homogenih transformacija A
        A = [cos(theta), -sin(theta)*cos(alpha), sin(theta)*sin(alpha), a*cos(theta);
             sin(theta), cos(theta)*cos(alpha), -cos(theta)*sin(alpha), a*sin(theta);
             0         , sin(alpha)           , cos(alpha)            , d           ;
             0         , 0                    , 0                     , 1           ;];
         T = T*A; % uzastopno mnozenje matrica A
        if (draw ~= 0)
            P = [P T(:, 4)]; % dobivanje p vektora iz zadnje kolone
            x = P(1, :);
            y = P(2, :);
            z = P(3, :);
                if (i == m) 
                    figure;
                end
            plot3(x, y, z);
            grid on;
        end
    end

end

    
         
        

