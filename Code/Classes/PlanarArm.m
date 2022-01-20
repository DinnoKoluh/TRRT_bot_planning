classdef PlanarArm < Robot
    properties (Access = public)

    end
    
    methods
        % The constructor of the PlanarRobot class
        function obj = PlanarArm(varargin)
                obj = obj@Robot(varargin{:});
                obj.bot = SerialLink(obj.getBotLinks(), 'name', [num2str(obj.dim),'SegPlanarArm']);
        end
        % FUNCTIONS WHICH PLOT OBSTACLES INSIDE THE CONFIGURATION SPACE
        function con = getConfigSpaceObstacles(obj)
            points = [0,0];
            s = 1;
            for k = 1:length(obj.obstacles)
                for i = -180:10:180
                    %i
                    for j = -180:10:180
                        obj.currConfig = [toRad(i); toRad(j)];
                        if obj.obstacleIntersection({obj.obstacles{k,1}})
                            plot(i,j,'x','Color',[abs(sin(k*k-1)/k), abs(sin(k*k/4+0.3)), abs(cos(k+1.2)/k)]);
                            points(s,1) = i;
                            points(s,2) = j;
                            s = s + 1;
                            hold on;
                            drawnow;
                        end
                    end
                end
%                 p = convhull(points);
%                 points = points(p,:);
%                 hold on;
%                 fill(points(:,1),points(:,2),'r','FaceColor',[0.4660, 0.6740, 0.1880]);
%                 xlabel('Theta1');
%                 ylabel('Theta2');
                xlim([-180 180]);
                ylim([-180 180]);
                obj.configObstacles{k,1} = points;
                s = 1;
                points = [0,0];
                
            end
            con = obj.configObstacles;
        end
        
        function intersection = obstacleIntersection(obj, obstacle)
            
            for i = 1:obj.dim
                if i == 1
                    p1 = zeros(1,obj.dim);
                end
                p2 = obj.getNthSegmentPosition(i)';
                p2 = p2(1,1:2);
                if checkIntersection(obstacle, p1, p2, 25) == 0
                    intersection = 1;
                    return;
                end
                p1 = p2;
            end
            intersection = 0;
        end
    end  
end

