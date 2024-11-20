% "Anti vector filter"
% Just the opposite of vfilt(); you pass in items you want to keep instead of items to remove.
function post = avfilt(pre, af)
  % Get all unique items
  uitems = puniq(pre);

  % Filter out items to keep for reverse filter
  f = vfilt(uitems, af);

  % Apply reversed filter
  post = vfilt(pre, f);
end
