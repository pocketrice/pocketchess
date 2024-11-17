% "Validate result"
% This function determines whether a relative offset from
% a position is on the board or not.
% 
% Note that the "player" variable is needed as offsets
% are based on which way the player is facing.
%
% valrel([1,1], [4,5], 1)
%           = 0            <-- white offsets are flipped, so this goes to [-3,-4]
%
% valrel([1,1], [4,5], 2)
%           = 1            <-- goes to [5,6]
%
function result = valrel(pos, offset, player)

    if (player == 1)
        offset = -offset;
    end
    

    newPos = pos + offset;
    result = (all(newPos >= 1) && all(newPos <= 8));
end
    
