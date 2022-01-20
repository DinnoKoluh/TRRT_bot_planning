classdef SphericalWrist < Robot
    properties
    end
    
    methods
    % Constructor of the SphericalArm class
    function obj = SphericalWrist(varargin)
        obj@Robot(varargin{1,1:end-1});
        obj.d = varargin{1,end};
        obj.bot = SerialLink(obj.getBotLinks(), 'name', ['Spherical Wrist']);
    end
        
    end
    
end

