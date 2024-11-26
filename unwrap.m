% "Unwrap"
% Unwraps a cell array until no other unwraps are possible (an unwrap occurs when there is a cell array with length 1, so this may still return a cell array depending on the "bottom layer".)

% Also converts to regular array if possible and empties 0xn vectors when strictmode on. 
function post = unwrap(pre, isstrict)
  post = pre;

  while length(post) == 1 && iscell(post)
       post = post{1};
  end

  if isstrict
       if iscell(post) && all(cellfun(@(i) isscalar(i), post))
         post = cell2mat(post);
       elseif length(post) == 0
         post = [];
       end
  end
end

  
