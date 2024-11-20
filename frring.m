% "Filled restricted ring"
% See fring() for details. This is effectively just fring() but (a)
% visually no longer a square and (b) non-valid positions are pruned.
function inds = frring(n, pos)
  inds = fring(n, pos);
  inds = reshape(inds, 1, []);
  
  for i = 1:length(inds)
      ind = inds{i};
      if ~valabs(ind)
          inds{i} = 0;
      end
  end 

  inds = vfilt(inds, 0);
end
