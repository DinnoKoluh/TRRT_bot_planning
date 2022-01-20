classdef RRT < handle & matlab.mixin.Copyable
    properties
        maxNodeNum = 0; % max number of nodes in the graph
        boundary;
        deltaQ = Inf;
        minDistance = Inf;
        obstacles = {};
        nodes = Node.empty(); % making an empty object of type Node
        edges = Edge.empty(); % making an empty object of type Edge
    end
    
    methods 
        % Constructor
        function obj = RRT(varargin)
            if nargin >= 1
                obj.maxNodeNum = varargin{1};
                if nargin >= 2
                    obj.boundary = varargin{2};
                    if nargin >= 3
                        obj.deltaQ = varargin{3};
                        if nargin >= 4
                            obj.minDistance = varargin{4};
                            if nargin >= 5
                                obj.obstacles = varargin{5};
                            end
                        end
                    end
                end
            end        
        end
        
        function len = getNodeNum(obj)
            len = length(obj.nodes);
        end 
        
        function len = getEdgeNum(obj)
            len = length(obj.edges);
        end
        
        function checkErrors(obj)
            if obj.getNodeNum() == obj.maxNodeNum
                error('Reached max number of nodes in the graph!');
            end
        end
        
        %varargin can be 1 object of type Node or 2 objects (coordinates,
        %index) so that inside this method we can make an object of type
        %Node
        %varargin moze biti 1 objekat tipa Node ili 2 objekta (coordinates,
        %index tako da unutar metode se napravi objekat tipa Node
        % IT'S POSSIBLE TO MAKE THAT THE NODES ARE ALWAYS SORETED BY INDEX!!
        function addNode (obj, varargin)
            obj.checkErrors();
            if nargin == 2
                node = varargin{1};
            elseif nargin == 3
                node = Node(varargin{1}, varargin{2});
            end

            obj.nodes(obj.getNodeNum()+1,1) = node;
        end
        
        function addEdge (obj, varargin)
            if nargin == 2
                edge = varargin{1};
            elseif nargin == 3
                edge = Edge(varargin{1}, varargin{2});
                varargin{1}.degreeUp(1);
                varargin{2}.degreeUp(1);
            elseif nargin == 4
                edge = Edge(varargin{1}, varargin{2}, varargin{3});
            else 
                error('Wrong input for edge creation!');
            end
            obj.edges(obj.getEdgeNum()+1,1) = edge;

        end
        
        function removeNode (obj, node)
            for i = 1:obj.getNodeNum()
                if obj.nodes(i,1).index == node.index
                    obj.removeEdge(node);
                    obj.nodes(i,:) = [];
                    return;
                end
            end
        end
        
        function removeEdge (obj, node1, varargin)
            if nargin == 2
                toRemove = double.empty();
                toRemoveIndex = 1;
                for i = 1:obj.getEdgeNum()
                    if obj.edges(i,1).node1.index == node1.index || obj.edges(i,1).node2.index == node1.index
                        obj.edges(i,1).node1.degreeDown(1);
                        obj.edges(i,1).node2.degreeDown(1);
                        toRemove(toRemoveIndex, 1) = i;
                        toRemoveIndex = toRemoveIndex + 1;
                    end
                end
                obj.edges(toRemove,:) = [];
            elseif nargin == 3
                node2 = varargin{1};
                for i = 1:obj.getEdgeNum()
                    if (obj.edges(i,1).node1.index == node1.index && obj.edges(i,1).node2.index == node2.index)...
                            || (obj.edges(i,1).node1.index == node2.index && obj.edges(i,1).node2.index == node1.index)
                        obj.edges(i,1).node1.degreeDown(1);
                        obj.edges(i,1).node2.degreeDown(1);
                        obj.edges(i,:) = [];
                        return;
                    end
                end
            end
                
        end
        
        function indexes = getNodeIndexes (obj)
            indexes = [obj.nodes(:,1).index]';
        end
        
        function degrees = getNodeDegrees (obj)
            degs = [obj.nodes(:,1).degree]';
            degrees = [obj.getNodeIndexes(), degs];
        end
        
        function mat = getEdgeMatrix (obj)
           % mat = double.empty(obj.getEdgeNum(), 3);
           first = [obj.edges.node1];
           second = [obj.edges.node2];
            mat = [first(:).index; second(:).index; obj.edges.weight]';
        end
        
        function matlabG = getMatlabGraph (obj)
            edgeMatrix = obj.getEdgeMatrix();
            % Pravljenje Matlabove verzije grafa
            matlabG = graph(edgeMatrix(:,1), edgeMatrix(:,2), edgeMatrix(:,3)); 
        end
        
        function [q_near, min] = nearestNode(obj, q_rand)
            % A function which based on the given node q_rand finds the node
            % inside the graph which is the closest to q_rand
            min = Inf;
            index = 1;
            for i = 1:obj.getNodeNum()
                d = distance(q_rand.coordinates, obj.nodes(i,1).coordinates);
                if d < min
                    min = d;
                    index = i;
                end
            end

            q_near = obj.nodes(index,1);

        end
        
        function [v, len] = getShortestPath(obj, node1, node2)
            [v, len] = shortestpath(obj.getMatlabGraph(), node1.index, node2.index);
        end
        
        function plotRRT (obj, pltNodes, pltEdges, color)
            grid on;
            set(0,'defaulttextinterpreter','latex');
            xlim([obj.boundary.begin(1,1), obj.boundary.end(1,1)]);
            ylim([obj.boundary.begin(1,2), obj.boundary.end(1,2)]);
            xlabel('$q_1$','fontsize',25);
            ylabel('$q_2$','fontsize',25);
            zlabel('$q_3$','fontsize',25);
            % Plotting the edges
            if pltEdges
                for i = 1:obj.getEdgeNum()
                    plotEdge(obj.edges(i,1).node1, obj.edges(i,1).node2, color, 1.4);
                end
            end
            
            % Plotting the nodes
            if pltNodes
                for i = 1:obj.getNodeNum()
                    % bilo 15
                    plotNode(obj.nodes(i,1), strcat(color,'.'), 10);
%                     text(obj.nodes(i,1).coordinates(1,1),obj.nodes(i,1).coordinates(1,2),...
%                        [num2str(obj.nodes(i,1).index)],  'FontSize',9)
                end
            end

        end
                
        function plotRRTpath(obj, q_s, q_f)
             [shortestV, shortestPath] = obj.getShortestPath(q_s, q_f);
             display(['Length of the found path (CS): ', num2str(shortestPath)]);     
%                 nodeIn = varargin{1};
%                 shortestPath = Inf;
%                 shortestV = double.empty();
%                 for i = 1:obj.getNodeNum()
%                     if distance(obj.nodes(i,1).coordinates, nodeIn(2,1).coordinates) < obj.minDistance
%                         [V, len] = obj.getShortestPath(nodeIn(1,1), obj.nodes(i,1));
%                         if len < shortestPath
%                             shortestPath = len;
%                             shortestV = V;
%                         end
%                     end
%                 end
                        
                for i = 1:length(shortestV)-1
%                for i = 1:length(shortestV)
                    % ako su cvorovi sortirani, ako nisu onda se mora
                    % napraviti funckija find node
%                     text(obj.nodes(shortestV(i),1).coordinates(1,1)-8,obj.nodes(shortestV(i),1).coordinates(1,2)+3,...
%                        [num2str(i)],  'FontSize',9)
                   plotEdge(obj.nodes(shortestV(i),1), obj.nodes(shortestV(i+1),1), 'g', 1.5);
                end
                plotMarker(q_s.coordinates, '$S$');
                plotMarker(q_f.coordinates, '$F$');
                %display(['Length of the found path (CS): ', num2str(shortestPath)]);
            end
        
        function node = findNode(obj, index)
            for i = 1:obj.getNodeNum()
                if index == obj.nodes(i,1).index
                    node = obj.nodes(i,1);
                    return;
                end
            end
            error('Node with the given index not found!');
        end
        
        function invertNodeOrder (obj)
            % Deep copy of nodes - after the indexes in the nodes change
            % than the indexes in the edges change accordingly
            % Invertion of the node list
            for i = 1:obj.getNodeNum()
                obj.nodes(i,1).index = obj.getNodeNum() - obj.nodes(i,1).index + 1;
            end
        end
        
        function shiftNodeIndexes (obj, n)
            for i = 1:obj.getNodeNum()
                obj.nodes(i,1).index = obj.nodes(i,1).index + n;
            end
        end
        
        % Function which connects two graph to their minimal distance but
        % it's freqeunt calling is not efficient
        function [con, node1, node2] = tryConnectRRTs (obj, G, minD, obstacles)
            con = 0;
            currD = minD;
            indexes = double.empty();
            for i = 1:obj.getNodeNum()
                for j = 1:G.getNodeNum()
                    d = distance(obj.nodes(i,1).coordinates, G.nodes(j,1).coordinates);
                    if (d < currD) && isSegmentInCfree(obstacles, obj.nodes(i,1).coordinates, G.nodes(j,1).coordinates)
                        con = 1;
                        indexes = [i j];
                        currD = d;
                    end
                end
            end
            node1 = obj.nodes(indexes(1,1),1);
            node2 = G.nodes(indexes(1,2), 1);
        end
        
        %Function which connects two graph between given nodes
        function mergeRRTs (obj, G, node1, node2)
            obj.maxNodeNum = obj.maxNodeNum + G.maxNodeNum;
            obj.addEdge(node1, node2);
            %G.invertNodeOrder();
            G.shiftNodeIndexes(obj.getNodeNum()); % shifting the node indexes of the second graph
            for i = 1:G.getNodeNum()
                obj.addNode(G.nodes(i,1));
            end
            for i = 1:G.getEdgeNum()
                obj.addEdge(G.edges(i,1));
            end
            
        end

        function rand_coor = randConfig (obj)
        % Function which generates random coordinates inside the given
        % range
            rand_coor = double.empty(1,0);
            for i = 1:length(obj.boundary.begin)
                rand_coor(1,i) = myRand(obj.boundary.begin(1,i),obj.boundary.end(1,i));       
            end
        end
        
        function [q_new] = newConfig(obj, q_near, q_rand)
            % Function which generates a node which is in the direction
            % between two sent nodes such that it is for the value deltaQ away from the
            % node q_near
            q_new = Node();
            vector = q_rand.coordinates - q_near.coordinates;
            unit_vector = vector / distance(q_rand.coordinates, q_near.coordinates);
            q_new.coordinates = q_near.coordinates + obj.deltaQ * unit_vector;
            q_new.index = q_rand.index;
        end
        
        function m = getMean(obj)
            a = [obj.nodes(:,1).coordinates];
            b = a(:,1:2:end);
            c = a(:,2:2:end);
            m(1,1) = mean(b);
            m(1,2) = mean(c);
        end
    end
    
end
%THE IMPORTANT THING IS THAT THE NODES ARE SORTED BY THE INDEX
