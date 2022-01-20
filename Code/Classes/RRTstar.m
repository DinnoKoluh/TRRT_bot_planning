classdef RRTstar < RRT
    properties
        gamma = 0;
    end
    
    methods
        function obj = RRTstar(varargin)
            obj@RRT(varargin{:});
        end
        
        function r = getBallRadius (obj, iteration, dim)
             r = obj.gamma * (log10(iteration)/iteration).^(1/dim);
%             hold on;
%             plot(iteration, r, 'r.');
             r = 10;
        end
        
        function out = getNodesInBall (obj, r, coordinates)
            % A function which finds the nodes which are inside the radius
            % r with the center in the sent coordinates
            outIndex = 1;
            out = Node.empty();
            for i = 1:obj.getNodeNum()
                d = distance(coordinates, obj.nodes(i,1).coordinates);
                if d < r
                    out(outIndex, 1) = obj.nodes(i,1);
                    outIndex = outIndex + 1;
                end
            end
        end
        
        function [bestParent, parents] = getBestParent (obj, parents, child)
            numOfParents = length(parents);
            shortestPath = Inf;
            bestParent = Node.empty();
            index = 0;

            for i = 1:numOfParents
                % Adding nodes
                obj.addEdge(parents(i,1), child);
                [~,pathLen] = obj.getShortestPath(obj.nodes(1,1), child);
                %length(pathLen
                % Deletion of the added node
                obj.edges(obj.getEdgeNum(),:) = [];
                parents(i,1).degreeDown(1);
                child.degreeDown(1);
                
                if pathLen < shortestPath
                    shortestPath = pathLen;
                    bestParent = parents(i,1);
                    index = i;
                end
            end
            if index
                parents(index) = [];
            end
        end
        
        function rewire (obj, q_new, parents)
            numOfParents = length(parents);
            for i = 1:numOfParents
                [~, currLength] = obj.getShortestPath(obj.nodes(1,1), parents(i,1));

                obj.addEdge(q_new, parents(i,1));

                [~, newLength] = obj.getShortestPath(obj.nodes(1,1), parents(i,1));
                
                obj.removeEdge(q_new, parents(i,1));

                %deg = [obj.getMatlabGraph().degree]; deg(parents(i,1).index,1)
                % obj.nodes(parents(i,1).index,1).degree
                if (newLength < currLength && obj.nodes(parents(i,1).index,1).degree <= 1)
                    obj.removeEdge(parents(i,1));
                    obj.addEdge(q_new, parents(i,1));
                end
            end
        end
    
    end    
end

