% "Check: Lite Edition"
% Similar to ChessBoard's checkcheck(), just decoupled and
% does not do checkmate; this is not present in ChessBoard to
% ensure no arbitrary check querying. To avoid a nasty recursion issue 
% with vmoves (see king castling @(p)...), this uses a manual check for
% king.
function result = ischeck(board, player)
result = false;
kq = board.kquery();

for r = 1:8
    for c = 1:8
        pos = [r,c];

        % If the space at [r,c] isn't empty and we haven't
        % confirmed check yet, keep looking for check.
        if ~board.iserel(pos)

            % Get all the moves of the piece at [r,c] that
            % consumes a piece. This is a DECOUPLED ChessBoard.cmoves.
           mbuffer = Buffer(30);
           
           
           piece = board.get(pos);

            % Check if not empty.
            if ~iseabs(piece)
                pplayer = piece.Player;
                ptype = piece.Type;
                
                if ptype ~= PieceType.King
                    allmoves = [ board.vmoves(pos), board.evmoves(pos) ];
                else
                    abuffer = Buffer(9);
                    
                    for dir = Direction.dirs
                        abuffer.aa(board.iuntilmax(pos, dir, 1, pplayer));
                    end

                    abuffer.aa(board.evmoves(pos));

                    allmoves = abuffer.flush();
                end

                for i = 1:length(allmoves)
                    move = unwrap(allmoves(i), 1);

                    if board.isoppo(move, pplayer)
                        mbuffer.a(move);
                    end
                end
            end

            cmoves = mbuffer.flush();

            % Loop through all the cmoves.
            for j = 1:length(cmoves)
                cmove = cmoves{j};
                %If any move in (cmoves) matches the king's position, it means
                % that the king is in check. We check by ensuring
                % both are permutations of each other.
                if psame(cmove, kq{player})
                    result = true;
                    return;
                end
            end

        end
    end

end
end
