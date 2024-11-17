% "Is in start row"
% This is a handy check for pawn 2-hop and king castling.
% Both require them to be in their starting rows; if isstar() is 1
% then you can allow the move.
%
% The "type" parameter is just one of the piece types (PieceType.Pawn, PieceType.Rook, etc).
%
% The start row for pawns is 2nd row and everything else 1st row from player's side.
%
% isstar(PieceType.Rook, [1,1], 2)
%              = 1       <-- a black rook's starting row is row 1, so true
%
% isstar(PieceType.Pawn, [2,1], 2)
%               = 1       <-- a black pawn starting row is row 2, so true
%
% isstar(PieceType.Pawn, [2.1], 1)
%                = 0      <-- a white pawn is the second row but from the white side (row 7), so false
%
function result = isstar(type, pos, player)
            if (player == 2)
                result = xor(type == PieceType.Pawn && pos(1) == 2, pos(1) == 1);
            else
                result = xor(type == PieceType.Pawn && pos(1) == 7, pos(1) == 8);
            end
        end
