function [ ob ] = rotateObstacle(ob, R, point)

len = length(ob(:,1));
dim = length(ob(1,:));
dummy = double.empty();
for i = 1:dim
    a = point(1,i)*ones(len,1);
    dummy = [dummy a];
end
ob = (ob-dummy)*R+dummy;

end

