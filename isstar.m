% This is a handy check for pawn 2-hop and king castling.
        function result = isstar(type, pos, player)
            if (player == 1)
                result = xor(type == PieceType.Pawn && pos(1) == 2, pos(1) == 1);
            else
                result = xor(type == PieceType.Pawn && pos(1) == 7, pos(1) == 8);
            end
        end
