% "Is valid absolute"
% This function checks if the given position is on the board or not.
% It works for both coordinates (e.g. [3,3]) and flat indices (e.g. 32)!
% This is a safety check before you call any function that accesses the board matrix.
%
% Counterpart to "is valid relative" (valrel), which checks if an offset from
% a position will be on the board or not.
%
% valabs([3,3])
%         = 1   <-- [3,3] is on the board
%
% valabs([100,30])
%         = 0    <-- [100,30] is not on the board
%
% valabs(50)
%         = 1    <-- 50 is the same as [6,2], which is on the board
%
% valabs(999999)
%         = 0     <-- 999999 exceeds 64 which is last spot on 8x8 board.
%
function result = valabs(pos)
    if (isscalar(pos))
        result = (pos >= 1 && pos <= 64);
    else
        result = (all(pos >= 1) && all(pos <= 8));
    end
end
    
