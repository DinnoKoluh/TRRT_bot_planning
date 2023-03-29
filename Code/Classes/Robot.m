classdef Robot
    properties
        bot = SerialLink.empty();
        d = [0; 0; 0];
        dim = 0; % rename to dof
        segLengths = double.empty(); % rename to a
        initConfig = double.empty();
        finalConfig = double.empty();
        currConfig = double.empty();
        configVector = double.empty();
        obstacles = {};
        configObstacles = {};
        options = optimoptions(@lsqlin,'Algorithm','interior-point','Display','off');
    end
    
    methods
        % Constructor of the Robot class
        function obj = Robot(varargin)
            if nargin >= 1
                obj.dim = length(varargin{1});
                obj.segLengths = varargin{1};
                if nargin >= 3
                    obj.initConfig = varargin{2};
                    obj.currConfig = obj.initConfig;
                    if nargin >= 4
                        obj.finalConfig = varargin{3};
                    end
                end
            end
        end
        % A functions which sets the DH parameters based on the current
        % configuration
        function DH = getDHparameters(obj)
            if isa(obj,'PlanarArm')
                DH = zeros(obj.dim,4);
                DH(:,1) = obj.segLengths;
                DH(:,4) = obj.currConfig(1:obj.dim,1);
            elseif isa(obj, 'AnthroArm')
                DH = zeros(obj.dim,4);
                DH(:,1) = obj.segLengths;
                DH(:,2) = [pi/2; 0; 0];
                DH(:,3) = obj.d; % For the base of the antropomorphic arm
                DH(:,4) = obj.currConfig(1:obj.dim,1);
            elseif isa(obj, 'SphericalWrist')
                DH = zeros(obj.dim,4);
                DH(:,1) = obj.segLengths;
                DH(:,2) = [-pi/2; pi/2; 0];
                DH(:,3) = obj.d; % Set the lenght of the rotational joint
                DH(:,4) = obj.currConfig(1:obj.dim,1);
            elseif isa(obj, 'AnthroSphericalArmWrist')
                DH = zeros(obj.dim,4);
                DH(:,1) = obj.segLengths;
                DH(:,2) = [pi/2; 0; pi/2; -pi/2; pi/2; 0];
                DH(:,3) = obj.d; % Set the lenght of the rotational joint
                DH(:,4) = obj.currConfig(1:obj.dim,1);
            end
        end
        
        % A function which returns the transformation matrix
        function T = getNthTransMatrix(obj, n)
            T = eye(4);
            DH = obj.getDHparameters();
            for i = 1:n
                ai = DH(i,1);
                alphai = DH(i,2);
                di = DH(i,3);
                thetai = DH(i,4);
                A = [cos(thetai) -sin(thetai)*cos(alphai) sin(thetai)*sin(alphai)  ai*cos(thetai);
                     sin(thetai) cos(thetai)*cos(alphai)  -cos(thetai)*sin(alphai) ai*sin(thetai);
                         0              sin(alphai)                  cos(alphai)       di        ;
                         0                   0                          0               1        ];
                T = T*A;
            end
        end
        
        % A function which returns the position of the n-th segment of a
        % planar arm
        function [position] = getNthSegmentPosition(obj,n)
            T = obj.getNthTransMatrix(n);
            position = T(1:3,4);
        end
        
        % A function which returns a vector of all robot configurations
        % from the strating to the ending one
        function conVector = getMotionConfigVector(obj, G, q_init, q_final) 
            [v] = G.getShortestPath(q_init, q_final);
            %conVector = zeros(obj.dim,length(v));
            conVector = zeros(obj.dim+1,length(v));
            for i = 1:length(v)
                if length(obj.currConfig) == obj.dim
                    conVector(1:end-1,i) = toRad(G.nodes(v(i)).coordinates)';
                else
                    conVector(:,i) = toRad(G.nodes(v(i)).coordinates)';
                    conVector(end,i) = G.nodes(v(i)).coordinates(1,end);
                end
            end
            conVector = conVector(1:end-1,:); % deletion of the last row which is the cost function
        end
        
        % A functions which returns the covered distance of the n-th robot
        % segment
        function d = getNthSegmentPathLength (obj, n)
            d = 0;
            for i = 1:length(obj.configVector)
                obj.currConfig = obj.configVector(:,i);
                if i == 1
                    p1 = obj.getNthSegmentPosition(n);
                    continue;
                end
                p2 = obj.getNthSegmentPosition(n);
                d = d + distance(p1,p2);
                p1 = p2;
            end
            display(['Segment broj ',num2str(n),' je presao put od: ', num2str(d),'.']);
        end
        
        % % % % % ROBO TOOLBOX
        function links = getBotLinks(obj)
            links = Link.empty();
            DH = obj.getDHparameters();
            for i = 1:obj.dim
                links(1,i) = Link('d', DH(i,3), 'a', DH(i,1), 'alpha', DH(i,2));
            end
        end

        % % % % % PLOTTING
        % A functions which plots one configuration of the whole robot
        function plotSegments (obj,iter)
            for i = 1:obj.dim
                %color = [abs(sin(i*i-1)/i), abs(sin(i*i/4+0.3)), abs(cos(i+1.2)/i)];
                if mod(i,2) == 0
                    color = [24, 137, 225]/255;
                else
                    color = [239, 95, 50]/255;
                end
                if i == 1
                    p1 = zeros(1,3);
                end
                p2 = obj.getNthSegmentPosition(i)';
                if i < obj.dim
                    plot3([p1(1,1),p2(1,1)], [p1(1,2),p2(1,2)], [p1(1,3), p2(1,3)], 'ro', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',5);
                    hold on;
                end
                plot3([p1(1,1),p2(1,1)], [p1(1,2),p2(1,2)], [p1(1,3), p2(1,3)],'Color', color, 'LineWidth',1.2);
                hold on;
                p1 = p2;
            end
              %a = 1.1;
              %text(a*p2(1,1),a*p2(1,2),p2(1,3)+0.1,[num2str(iter)],  'FontSize',9)
        end
        
        % A function which plots the movement of the robot from the
        % starting to the ending configuration
        function plotRobotPath(obj)
            to = length(obj.configVector);
            %to = 20;
            for i = 1:1:to
                obj.currConfig = obj.configVector(:,i);
%                 xlim([-4,4]);
%                 ylim([-4,4]);
%                 zlim([-4,4]);
                obj.plotSegments(i);
                pause(0.02);
            end
        end
        
        % Function which plots the trajectory of the n-th segment of the
        % robot
        function plotRoboNthSegmentPath(obj, n)
            hold on;
            for i = 1:length(obj.configVector)
                obj.currConfig = obj.configVector(:,i);
                if i == 1
                    pos1 = obj.getNthSegmentPosition(n);
                    continue;
                end
                pos2 = obj.getNthSegmentPosition(n);
                plot3([pos1(1,1), pos2(1,1)], [pos1(2,1), pos2(2,1)], [pos1(3,1), pos2(3,1)], 'k', 'Linewidth',2);
                hold on;
                %pause(0.05);
                pos1 = pos2;
            end
        end
        
    end
    
end

