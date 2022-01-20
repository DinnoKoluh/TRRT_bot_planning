classdef Node < handle
    properties
        coordinates = [0,0];
        index = 1; % index of the node
        degree = 0; % degree of the node
    end
    
    methods
        % variable list of input arguments
        % the order should be (coordinates, index) 
        function obj = Node(varargin)
            if nargin == 1
                obj.coordinates = varargin{1};
            elseif nargin == 2
                obj.coordinates = varargin{1};
                obj.index = varargin{2};
            end
        end
        
        function setCoordinates(obj, pos)
            obj.coordinates = pos;
        end
        
        function setIndex(obj, ind)
            obj.index = ind;
        end
        
        function degreeUp (obj, deg)
            obj.degree = obj.degree + deg;
        end
        
        function degreeDown (obj, deg)
            obj.degree = obj.degree - deg;
        end

    end
    
end

