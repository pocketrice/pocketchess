classdef Direction
    properties
        Offset % Must be (±x,±y)
    end

    enumeration
        Left([0,1])
        Right([0,-1])
        Up([1,0])
        Down([-1,0])
        LeftUp([1,1])
        LeftDown([-1,1])
        RightUp([1,-1])
        RightDown([-1,-1])
        NA([0,0])
    end

    methods
        function obj = Direction(Offset)
            obj.Offset = Offset;
        end

        % "Apply scalar"
        % Scales offset by the scalar. This doesn't affect the Direction
        % itself and instead returns the new vector.
        function offset = scl(obj, mag)
            offset = obj.Offset * mag;
        end
    end

    methods (Static)
        % "Get all directions"
        % Handy for checking in all directions in a succinct manner.
        % 1-4 are TRBL, 5-8 are those skewed 45deg rightward.
        function arr = dirs(varargin)
            alldirs = [ Direction.Up, Direction.Right, Direction.Down, Direction.Left, Direction.RightUp, Direction.RightDown, Direction.LeftDown, Direction.LeftUp ];

            if nargin > 0
                abuffer = Buffer(8);

                for i = varargin
                    abuffer.a(alldirs(i{1}));
                end

                arr = unwrap(abuffer.flush(), 1);
            else
                arr = alldirs;
            end
        end

        % "Normalise offset"
        % @requires offset is unit-straight and 2-len
        % Gets corresponding normalised Direction for a particular offset!
        function dir = normalise(offset)
            if ~isunst(offset) || length(offset) ~= 2
                error("Direction.normalise can only be called on 2-len unit-straight offsets!");
            end
                    
            % Rather than normalising the vector (@(a) a ./ norm(a))
            % manually divide each dim to either 0 or 1, as normalising
            % can't produce [1,1] but instead [0.7071, 0.7071].

            % Also instead of a generic solution this is just hardcoded bc
            % soz luls :>

            % Comparison uses strings as switch statement cannot accept
            % vectors.
            switch mat2str(dnorm(offset))
                case '[0 1]'
                    dir = Direction.Left;
                case '[0 -1]'
                    dir = Direction.Right;
                case '[1 0]'
                    dir = Direction.Up;
                case '[-1 0]'
                    dir = Direction.Down;
                case '[1 1]'
                    dir = Direction.LeftUp;
                case '[-1 1]'
                    dir = Direction.LeftDown;
                case '[1 -1]'
                    dir = Direction.RightUp;
                case '[-1 -1]'
                    dir = Direction.RightDown;
            end
        end
    end
end