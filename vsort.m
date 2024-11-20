% "Vector sort"
% Sorts a vector based on array with indices to order the vector by.
function post = vsort(pre, sortinds)
  if length(pre) ~= length(sortinds)
    error("vsort lens don't match!");
  end

  if iscell(pre)
    post = {};
    
    for ind = sortinds
      post{end + 1} = pre{ind};
    end
  else
    post = {};

    for ind = sortinds
      post{end + 1} = pre(ind);
    end
    
    % Expand the cell array out to make a new array of that type
    post = [post{:}];
  end
end

  
