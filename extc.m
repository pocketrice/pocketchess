% "Extract from cell"
% This function extracts the data from a cell. It is the same as
% cell{1}; this is in case you are chaining indexing together such
% as for intermediate operations.
%
% Normally you can (and should!) just use cells{1}.
%
% cells = {1,2,3,4,5}
%
% cells(1){1}
%         = ERROR
% extc(cells(1))
%         = 1
% cells{1}
%         = 1
% 
function item = extc(cell)
  item = cell{1};
end
