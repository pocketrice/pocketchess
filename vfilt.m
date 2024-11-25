% "Filter vector"
% Filters items in the filter "f" from "pre".
% To be efficient, f should be unique.
% Works for both arrays and cells!
function post = vfilt(pre, f)
  post = pre;

  % For every filter item (fi) in filter (f), remove until post index (pi)
  % ~= 0. 
  for i = 1:length(f)
    fi = unwrap(f(i));
    pi = has(post, fi);

    while pi
      post(pi) = [];
      pi = has(post, fi);
    end
  end
end
      
