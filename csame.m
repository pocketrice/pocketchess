% "Is same combo"
function result = csame(c1, c2)
  result = true;
  
  if length(c1) == length(c2)
    ind = 1;
    while result && ind <= length(c1) 
        if iscell(c1)
            i1 = c1{ind};
        else
            i1 = c1(ind);
        end

        result = (true && has(c2, i1));
        ind = ind + 1;
    end
  else
      result = false;
  end
end
