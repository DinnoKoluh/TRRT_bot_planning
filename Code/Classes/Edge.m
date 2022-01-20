classdef Edge < handle
    properties
        node1 = Node.empty();
        node2 = Node.empty();
        weight = Inf;
    end
    
    methods
        % variable list of input argumentes
        % 1. (node1, node2, weight) in this order 
        % 2. (node1, node2) and weight is calculated inside the constructor
        % as the distance between the nodes
        function obj = Edge(varargin)
            if nargin == 2
                obj.node1 = varargin{1};
                obj.node2 = varargin{2};
                obj.weight = distance(obj.node1.coordinates, obj.node2.coordinates);
            elseif nargin == 3
                obj.node1 = varargin{1};
                obj.node2 = varargin{2};
                obj.weight = varargin{3};
            end
        end
        
        function setNodes(obj, n1, n2)
            obj.node1 = n1;
            obj.node2 = n2;
            obj.weight = distance(n2.coordinates, n1.coordinates);
        end
        
        function setNode1 (obj, n1)
            obj.node1 = (n1);
        end
        
        function setNode2 (obj, n2)
            obj.node2 = (n2);
        end
        
        function setweight(obj, w)
            obj.weight = w;
        end
        
    end
    
end

