function [r] = myRand(a,b)
    % Functions which returns a random number in the intervale [a,b]
    r = a + (b-a).*rand();
end

