classdef AnthroArm < Robot
    properties
        
    end
    
    methods
        % Constructor of the AnthroArm class
        function obj = AnthroArm(varargin)
            obj@Robot(varargin{1,1:end-1});
            obj.d = varargin{1,end};
            obj.bot = SerialLink(obj.getBotLinks(), 'name', ['Anthro Arm']);
        end
        
    end
    
end

