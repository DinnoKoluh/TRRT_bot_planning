function [R] = getRotationMatrix(angle, varargin)
    if nargin == 2
        if strcmp(varargin{:},'Deg')
            angle = toRad(angle);
        end
    end
    % Angle given in radians
    if length(angle) == 1
        R = [cos(angle) -sin(angle); sin(angle) cos(angle)];
    elseif length(angle) == 3
        alphaX = angle(1,1); 
        alphaY = angle(2,1);
        alphaZ = angle(3,1);
        Rx = [1 0 0; 0 cos(alphaX) -sin(alphaX); 0 sin(alphaX) cos(alphaX)];
        Ry = [cos(alphaY) 0 sin(alphaY); 0 1 0; -sin(alphaY) 0 cos(alphaY)];
        Rz = [cos(alphaZ) -sin(alphaZ) 0; sin(alphaZ) cos(alphaZ) 0; 0 0 1];
        R = Rx*Ry*Rz;
    else
        error('Dimension of given coordinates wrong!');
    end

end

