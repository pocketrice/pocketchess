% "Extract cell index/item"
% Nabs a cell array with just specified index of any query (query, equery, aquery, pquery, kquery).
%
% This is just a fancier-named version for a generic method to get individual element from cell array from >2-tuples (which is another fancy way of saying a cell array of >2-length cell arrays) that is needlessly and arbitrarilymade exclusive to ChessBoard queries. So there's that!
%
% { chesspiece, coords }, so type = 1 or 2
%
% nvm ignore all above, it is fixed and i am sad
%
function ext = exti(cellarr, col) 
  ext = cell(1, length(cellarr));

  for i = 1:length(cellarr)
    item = cellarr{i};
    
    if iscell(item)
      ext{i} = item{col};
    else
      ext{i} = item(col);
    end
  end
end
