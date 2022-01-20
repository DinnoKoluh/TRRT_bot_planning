time;
newTime = zeros(1,36);
for i = 1:36
        if i == 1
            newTime(1,1) = newT(1,1);
        else
            newTime(1,i) = newT(1,i) - newT(1,i-1);
        end
end

finalT = zeros(6,6);
sum = 0;
for i = 1:6
    for j = 1:6
        sum = sum + 1;
    finalT(i,j) = newTime(1,sum);
    end
end