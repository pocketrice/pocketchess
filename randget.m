% "Random get"
% Gets a random entry from the vector. Returns [] if empty vec for avoiding
% branching check.
function item = randget(vec)
  len = length(vec);
  if ~isempty(vec)
    if iscell(vec)
        item = vec{randi(len)};
    else
        item = vec(randi(len));
    end
  else
      item = [];
  end
end
