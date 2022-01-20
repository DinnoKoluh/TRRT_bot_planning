classdef TRRT < RRTstar
    properties
        robot = Robot.empty();
        terrain; % Function handler which decribes the surface of the terrain 
        T = 0; % "Temperature"
        K = 0; % Normalization constant K
        alpha = 0; % Paremter which adjusts the temperature
        maxFails = 0;
        c_max = 0; % Max height
        nFails = 0;
        rho = 0; % Parameter which controls the graph spreading
        %frontierNodes = 0;
        refinerNodes = 0;
    end
    
    methods
        % Constructor
        function obj = TRRT(varargin)
                obj@RRTstar(varargin{:});
        end
        
        function setTRRTproperties (obj, terrain, T, K, alpha, maxFails, c_max, rho)
            obj.terrain = terrain;
            obj.T = T;
            obj.K = K;
            obj.alpha = alpha;
            obj.maxFails = maxFails;
            obj.c_max = c_max;
            obj.rho = rho;
        end
        
        function p = getTranProbability (obj, c_i, c_j, d_ij)
            p = 1;
            deltaC = c_j - c_i;
            if deltaC > 0
                p = exp(-deltaC/(d_ij*obj.K*obj.T));
            end
        end
        
        function transition = transitionTest(obj, q1, q2)
            obj.T;
            if isempty(obj.robot)
                c_i = obj.terrain(q1.coordinates(1,1), q1.coordinates(1,2));
                c_j = obj.terrain(q2.coordinates(1,1), q2.coordinates(1,2));
            else
                %obj.robot.currConfig = toRad(q1.coordinates');
                %c_i = costFunction(obj.robot);
                c_i = q1.coordinates(1,end);
                %obj.robot.currConfig = toRad(q2.coordinates');
                %c_j = costFunction(obj.robot);
                c_j = q2.coordinates(1,end);
                %q1.coordinates(1,end) = c_i;
                %q2.coordinates(1,end) = c_j;
            end
            % CHECK THIS
            d_ij = distance(q1.coordinates, q2.coordinates);
            
            if c_j > obj.c_max
                transition = 0;
                return;
            end
            
            if c_j < c_i
                transition = 1;
                return;
            end
            
            if myRand(0,1) < obj.getTranProbability(c_i, c_j, d_ij)
                obj.T = obj.T / obj.alpha;
                obj.nFails = 0;
                transition = 1;
                return;
            else
                if obj.nFails > obj.maxFails
                    obj.T = obj.T * obj.alpha;
                    obj.nFails = 0;
                else
                    obj.nFails = obj.nFails + 1;
                end
                transition = 0;
                return;
            end
            
            
        end
        
        function expand = minExpandControl(obj, q_1, q_2)
            if distance(q_1.coordinates, q_2.coordinates) > obj.deltaQ
                %obj.frontierNodes = obj.frontierNodes + 1;
                expand = 1;
                return;
            else
                if (obj.refinerNodes + 1) / (obj.getNodeNum + 1) > obj.rho
                    expand = 0;
                    return;
                else
                    %obj.frontierNodes = obj.frontierNodes + 1;
                    obj.refinerNodes = obj.refinerNodes + 1;
                    expand = 1;
                    return;
                end
            end
        end
        
        function displayTRRTproperties (obj)
            newline = sprintf('\n');
            display(['T = ', num2str(obj.temperature), '.', newline, 'K = ', num2str(obj.K), '.', ...
                newline, 'alpha = ', num2str(obj.alpha), newline, 'maxFails = ', num2str(obj.maxFails)]);
        
        end
        
        function rand_coor = randConfig (obj)
            % Function which generates random coordinates inside the given
            % range but keeps the z axis on the surface of the terrain
            len = length(obj.boundary.begin)+1;
            rand_coor = zeros(1,len);
            for i = 1:len
                if i == len
                    if isempty(obj.robot)
                        rand_coor(1,3) = obj.terrain(rand_coor(1,1), rand_coor(1,2));
                        return;
                    else
                          obj.robot.currConfig = toRad(rand_coor');
%                         rand_coor(1,len) = costFunction(obj.robot);
%                           rand_coor(1,len) = directCost(obj.robot);
                          rand_coor(1,len) = myRand(0,1);
                    end
                    return;
                end
                rand_coor(1,i) = myRand(obj.boundary.begin(1,i), obj.boundary.end(1,i));
            end
            
        end
        
        function [q_new] = newConfig(obj, q_near, q_rand)
            % A function which generates a node which found on the
            % direction between two given node such that it is for the
            % value deltaQ away from q_near but such that the z coordinate
            % lies on the surface of the shape of the given terrain (so
            % that the whole graph lies on the surface of the terrain)
            q_new = Node();
            vector = q_rand.coordinates - q_near.coordinates;
            unit_vector = vector / distance(q_rand.coordinates, q_near.coordinates);
            q_new.coordinates = q_near.coordinates + obj.deltaQ * unit_vector;
            q_new.index = q_rand.index;
            if isempty(obj.robot)
                q_new.coordinates(1,end) = obj.terrain(q_new.coordinates(1,1),q_new.coordinates(1,2));
            else
                obj.robot.currConfig = toRad(q_new.coordinates');
                q_new.coordinates(1,end) = costFunction(obj.robot);
            end
        end
        
    end
    
end

