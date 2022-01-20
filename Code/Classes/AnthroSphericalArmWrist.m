classdef AnthroSphericalArmWrist < Robot
    properties
    end
    
    methods
        % Constructor of the AnthroSphericalArmWrist class
        function obj = AnthroSphericalArmWrist(varargin)
            obj@Robot(varargin{:});
            obj.d = varargin{1,end};
            obj.bot = SerialLink(obj.getBotLinks(), 'name', ['AnthroSphericalArmWrist']);
        end
    end
    
end

