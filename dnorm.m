% "Dimension normalise"
% Individually normalises each dimension of a vector (as in, 1, 0, or -1)
% rather than being based on entire vector.

% Only accepts regular (not celL) arrays.
function post = dnorm(pre)
  post = pre;
  for i = 1:length(post)
     item = post(i);
     
     if item ~= 0
         post(i) = item / abs(item);
     end
  end
end
       

