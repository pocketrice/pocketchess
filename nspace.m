% "Normal spacer"
% Creates a horizontal vector with [len] amount of [item].
% This is similar to the cell spacer cspace(), but for arrays instead.
% It works for any type of object (numbers, chess pieces, etc)
% 
% Remember that you can combine them when making an array!
%
% nspace('aaa', 3)
%           = ['aaa', 'aaa', 'aaa']
%
% nspace(BlackPawn, 8)
%           = [BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn]
%
% [BlackKing, BlackRook, BlackBishop; nspace(BlackPawn, 3)]
%           = [BlackKing, BlackRook, BlackBishop;
%              BlackPawn, BlackPawn, BlackPawn]
%
function spacer = nspace(item, len)
    spacer = repmat(item, 1, len);
end
