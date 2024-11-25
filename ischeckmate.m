 % Checks if the king is in checkmate or not. This is a decoupled
        % form of the checkmate checker used in checkcheck, so avoid when
        % possible.
        function result = ischeckmate(board, player)
            result = false;

            % Not in checkmate if not in check!
            if board.Checks(player)                % Get all valid moves for the player
                vmoves = board.vpmoves(player);

                % Filter for only moves that resolve check
                for i = length(vmoves):-1:1
                    vmove = vmoves{i};
                    if ~board.isresmove(vmove{1}, vmove{2}, player)
                        vmoves(i) = [];
                    end
                end

                % If no moves that resolve check, then we are in checkmate.
                result = isempty(unwrap(vmoves));
            end
        end
