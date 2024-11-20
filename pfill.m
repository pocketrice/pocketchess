% "Partial fill"
% Creates a vector of m length with m active and (m-n) inactive.
function vec = pfill(n, m, active, inactive)
  vec = repmat(active, 1, n);
  vec = [ vec, repmat(inactive, 1, m-n) ];
end
