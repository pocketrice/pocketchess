% "Cell spacer"
% Creates a horizontal cell array with [len] amount of [item]. Use this in
% place of manually repeating a single element in an array.
%
% This is similar to "normal spacer" just putting each item in a cell instead for use with cell arrays.
% 
% cspace('bbb', 4)
%         = {'bbb', 'bbb', 'bbb', 'bbb'}
%
% You can use vertcat(a,b) to put same-length cell arrays in rows, such as 
% for the chessboard.
%
% vertcat(cspace('aaa', 3), cspace('bbb', 3))
%          = {'aaa', 'aaa', 'aaa';
%             'bbb', 'bbb', 'bbb'}
%
function spacer = cspace(item, len)
    spacer = repmat({item}, 1, len);
end
