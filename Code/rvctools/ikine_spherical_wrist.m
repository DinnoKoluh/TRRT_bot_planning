function [q] = ikine_spherical_wrist(R, conf_type)
    % R matrica rotacije s obzirom na vrh manipulatora
    nx = R(1,1);
    ny = R(2,1);
    nz = R(3,1);
    sx = R(1,2);
    sy = R(2,2);
    sz = R(3,2);
    ax = R(1,3);
    ay = R(2,3);
    az = R(3,3);
    % trazenje uglova
    theta4_1 = atan2(ay,ax);
    theta4_2 = atan2(-ay,-ax);
    %-------------------------------------------------------------------%
    theta5_1 = atan2(sqrt(ax^2+ay^2),az);
    theta5_2 = atan2(-sqrt(ax^2+ay^2), az);
    %-------------------------------------------------------------------%
    theta6_1 = atan2(sz, -nz);
    theta6_2 = atan2(-sz,nz);
    %-------------------------------------------------------------------%
    q1 = [theta4_1; theta5_1; theta6_1]; % prva konfiguracija
    q2 = [theta4_2; theta5_2; theta6_2]; % druga konfiguracija
    
    if (strcmp(conf_type, 'first'))
        q = q1*180/pi;
    elseif (strcmp(conf_type, 'second'))
        q = q2*180/pi;
    else 
        disp('Unijeli ste pogresnu komandu');
    end
        
end

