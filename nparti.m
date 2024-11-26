% "Numeric partition"
% Used recursively by quicksort (nsort).
function [front, back] = nparti(vec, parti)
  bs = round(length(vec) * 3/4);
  front = Buffer(bs);
  back = Buffer(bs);

  for item = unwrap(vec)
    if item >= parti
      front.a(item);
    else
      back.a(item);
    end
  end

  front = cell2mat(front.flush());
  back = cell2mat(back.flush());
end
