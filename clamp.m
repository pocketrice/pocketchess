% "Clamp value"
% Clamps the value based on the two bounds. For single bounds due to
% limitations you must use min and max. sad sad ik
function post = clamp(val, l, u)
  post = max(min(val, u), l);
end
