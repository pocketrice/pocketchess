% Sorts an array-only vector of single numbers (no -1) in ascending order.
function [post, inds] = sortnums(pre)
  post = [];
  inds = [];

  while ~all(pre == -1)
    [item, ind] = max(pre);
    post(end + 1) = item;
    inds(end + 1) = ind;
    pre(ind) = -1;
  end
end
