function [d] = distance(a,b)
    % a - coordinates of the first point (n - dimensional vector)
    % b - coordinates of the second point (n - dimensional vector)
    if length(a) ~= length(b)
       error('Points must have the same dimension!');
    end
    n = length(a);
    d = 0;

    for i = 1:n
        d = d + ( a(i)-b(i) )^2;
    end
    d = sqrt(d);
end

