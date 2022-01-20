function [ q ] = ikine_elbow_manipulator(P, conf_type)
    % P vektor 3x1 (x,y,z) koordinate u Dekartovom k.s. finalne pozicije ruke
    % conf_type nacina dolaska od pocentne konfiguracije do finalne
    % Posto nije receno u zadatku duzine zglobova postavit cemo neke
    % vrijednosti
    a2 = 2;
    a3 = 1;
    % komponenet vektora P
    px = P(1,1);
    py = P(2,1);
    pz = P(3,1);
    %-------------------------------------------------------------------%
    %USLOV da bi se mogla dostici trazena pozicija
    if ~(abs(a2-a3) <= sqrt(px^2+py^2+pz^2) && sqrt(px^2+py^2+pz^2) <= a2+a3)
        disp('Nije moguce doci do trazene pozicije');
        return
    end
    %-------------------------------------------------------------------%
    c3 = (px^2+py^2+pz^2-a2^2-a3^2)/(2*a2*a3);
    s3_pos = sqrt(1-c3^2); % pozitivno rjesenje korjenjovanja
    s3_neg = -sqrt(1-c3^2); % negativno rjesenje korjenovanja
    
    theta3_1 = atan2(s3_pos,c3); % prvo rjesenje za ugao theta3
    theta3_2 = atan2(s3_neg,c3); % drugo rjesenje za ugao theta3
    %-------------------------------------------------------------------%
    % slijede 4 rjesenja za ugao theta2
    theta2_1 = atan2((a2 + a3*c3)*pz - a3*s3_pos*sqrt(px^2+py^2), ...
        (a2 + a3*c3)*sqrt(px^2+py^2) + a3*s3_pos*pz);
    
    theta2_2 = atan2((a2 + a3*c3)*pz + a3*s3_pos*sqrt(px^2+py^2), ...
        -(a2 + a3*c3)*sqrt(px^2+py^2) + a3*s3_pos*pz);
    
    theta2_3 = atan2((a2 + a3*c3)*pz - a3*s3_neg*sqrt(px^2+py^2), ...
        (a2 + a3*c3)*sqrt(px^2+py^2) + a3*s3_neg*pz);
    
    theta2_4 = atan2((a2 + a3*c3)*pz + a3*s3_neg*sqrt(px^2+py^2), ...
        -(a2 + a3*c3)*sqrt(px^2+py^2) + a3*s3_neg*pz);
    %-------------------------------------------------------------------%
    theta1_1 = atan2(py,px);
    theta1_2 = atan2(-py,-px);
    %-------------------------------------------------------------------%
    q1 = [theta1_1; theta2_1; theta3_1]; % shoulder-right/elbow-up (ru)
    q2 = [theta1_1; theta2_3; theta3_2]; % shoulder-left/elbow-up (lu)
    q3 = [theta1_2; theta2_2; theta3_1]; % shoulder-right/elbow-down (rd)
    q4 = [theta1_2; theta2_4; theta3_2]; % shoulder-left/ elbow-down (ld)
    %-------------------------------------------------------------------%
    if (strcmp(conf_type,'ru'))
        q = q1*180/pi;
    elseif (strcmp(conf_type,'lu'))
        q = q2*180/pi;
    elseif (strcmp(conf_type,'rd'))
        q = q3*180/pi;
    elseif (strcmp(conf_type, 'ld'))
        q = q4*180/pi;
    else
        disp('Unijeli ste pogresnu komandu');
        return;
    end
                
end

