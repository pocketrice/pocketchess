% "Unwrap"
% Unwraps a cell array until no other unwraps are possible (an unwrap occurs when there is a cell array with length 1, so this may still return a cell array depending on the "bottom layer".)
function post = unwrap(pre)
  post = pre;

  while length(post) == 1 && iscell(post)
       post = post{1};
  end
 end

  
