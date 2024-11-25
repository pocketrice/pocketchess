% "Is unit straight"
% Checks if a given offset is "unit straight", or
% is either horizontal, vertical, or unit-diagonal (abs(y len) == abs(x len)).
function result = isunst(offset)
  result = xor(offset(1) == 0, offset(2) == 0) || ~all(offset == 0) && abs(offset(1)) == abs(offset(2));
end
