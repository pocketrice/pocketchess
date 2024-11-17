% "Relative to absolute"
% Converts a relative offset (such as the different moves for a piece)
% with old position to an absolute position (can be used to index the board)
%
% You need to pass the "player" parameter in so the offset is done from that player's side!
%
% rel2abs([3,3], [2,4], 1)
%             = [1,-1]     <-- from the white side, moves 2 up and 4 right from [3,3].
%
% rel2abs([3,3], [2,4], 2)
%             = [5,7]       <-- from the black sie, moves 2 up, and 4 right from [3,3].
%
% 
function absPos = rel2abs(relPos, offset, player)
    % pos = (x,y)
    % offset = (±x, ±y)
    % player = 1 (white) or 2 (black)
    
    % If P2, invert offset.
    if (player == 1)
        offset = -offset;
    end

    % Calculate and extract new position.
    absPos = relPos + offset;
   end
