% "Restricted ring"
% See frring() for documentation; this is that but unfilled.
function inds = rring(n, pos)
  inds = ring(n, pos);
  inds = reshape(inds, 1, []);
  
  for i = 1:length(inds)
      ind = inds{i};
      if ~valabs(ind)
          inds{i} = 0;
      end
  end 

  inds = vfilt(inds, 0);
end
