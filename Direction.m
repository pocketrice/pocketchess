classdef Direction
    properties
        Offset % Must be (±x,±y)
    end

    enumeration
        Left([0,-1])
        Right([0,1])
        Up([1,0])
        Down([-1,0])
        LeftUp([1,-1])
        LeftDown([-1,-1])
        RightUp([1,1])
        RightDown([-1,1])
        NA([0,0])
    end

    methods
        function obj = Direction(Offset)
            obj.Offset = Offset;
        end
    end
end