% "Check: Lite Edition"
% Similar to ChessBoard's checkcheck(), just decoupled and
% does not do checkmate; this is not present in ChessBoard to
% ensure no arbitrary check querying.
function result = ischeck(board, player)
result = false;
kq = board.kquery();

for r = 1:8
    for c = 1:8
        % If the space at [r,c] isn't empty and we haven't
        % confirmed check yet, keep looking for check.
        if ~board.iserel([r,c])

            % Get all the moves of the piece at [r,c] that
            % consumes a piece.
            cmoves = board.cmoves([r,c]);

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
