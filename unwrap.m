 % "Unwrap"
% Unwraps a cell array until no other unwraps are possible (an unwrap occurs when there is a cell array with length 1, so this may still return a cell array depending on the "bottom layer".)

% Also converts to regular array if possible and empties 0xn vectors when strictmode on. 
function post = unwrap(pre, isstrict)
  post = pre;

  while isscalar(post) && iscell(post)
       post = post{1};
  end

  if nargin == 2 && isstrict
       if iscell(post) && all(cellfun(@(i) isscalar(i), post)) && isstype(post)
         post = [post{:}]; % Don't use cell2mat b/c is intended for doubles instead; use cellarr expansion and array collection [{n:}].
       elseif isempty(post)
         post = [];
       end
  end
end

  
