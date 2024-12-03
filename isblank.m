% "Is string blank"
% See Java. This works for both '' and "".
function result = isblank(str)
  result = (strlength(str) == 0);
end
