% "Is same permutation"
function result = psame(c1, c2)
  result = true;
  
  if length(c1) == length(c2)
    ind = 1;
    while result && ind <= length(c1) 
      if iscell(c1)
        i1 = c1{ind};
      else
        i1 = c1(ind);
      end

      if iscell(c2)
        i2 = c2{ind};
      else
        i2 = c2(ind);
      end
      
      % Recursive (only allow arrays through)
      if iscell(i1) && iscell(i2)
         result = psame(i1, i2);
      elseif xor(iscell(i1), iscell(i2))
         result = false;
      else
         result = all(i1 == i2);
      end

        ind = ind + 1;
    end
  else
      result = false;
  end
end
