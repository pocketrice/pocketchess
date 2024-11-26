% "Indexed numeric sort"
% Gets indices for an nsort. Note this is very difficult integrated into the recursive nsort% and is hugely easier in an iterative form.
function [post, inds] = insort(pre)
  post = nsort(pre);
  inds = zeros(1, length(post));
  
  % Make a copy to remove from (in case several identicals)
  pre2 = pre;

  % Get item that is one higher than max (placeholder).
  nulli = post(1) + 1;

  % Loop through and get indices; replace with null after found.
  for i = 1:length(post)
    inds(i) = has(pre2, post(i));
    pre2(inds(i)) = nulli;
  end
end


