% "Is empty absolute"
% The absolute counterpart to "is empty relative" (iserel()), which checks the piece at a position.
% This function instead takes the actual piece object you extract from the matrix and checks if it is
% an empty space (0) or not (ChessPiece).
%
% The "piece" variable is what you get from using something like cb.get([5,5]).
%
%
% iseabs(cb.get([5,5]))
%               = 1      <-- the piece at [5,5] is extracted and checked; it is empty.
%
% iseabs(0)
%               = 1      <-- you can also directly pass it the contents. In this case 1 means empty
%
% iseabs(ChessPiece)
%               = 0       <-- see above.
%
        function result = iseabs(piece)
          
            result = isa(piece, "double") && isscalar(piece);
        end
