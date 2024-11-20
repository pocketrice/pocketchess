% "Compose vector"
% Use a decomposition and convert back to regular vector.
% Note: order is not preserved.
function cv = vcomp(dv)
  cv = [];

  for dvi = dv
      % Extract decomp vector item's array
      dvarr = dvi{1};

      % Add to comp vector
      cv = [cv nspace(dvarr{1}, dvarr{2})];
  end
end

    
