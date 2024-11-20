% "Ring"
% Gets a ring of radius n+1 (basically (2n+1)-long hollow square)
% n stands for # of spaces from center pos, hence n+1 and it always being odd.
function inds = ring(n, pos)
  % n ring (offsetted)
  inds = fring(n, pos);
  
  % n-1 ring (indexed)
  indsn = fring(n-1, [n+1,n+1]);
  indsn = reshape(indsn, 1, []);

  for i = 1:length(indsn)
    ind = indsn{i};
    inds{ind(1), ind(2)} = 0;
  end  
end
