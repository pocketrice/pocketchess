% "Trim spaces"
% For a string array if it has more than 1 consecutive space, trim to 1 space.
function post = trimspace(pre)
  pbfr = Buffer(round(length(pre) * 3/4));

  for i = 1:strlength(pre)
    c = chat(pre, i);
    
    % DeMorgan? Nonsense...
    if ~(c == ' ' && (i == 1 || i == length(pre) || chat(pre, i-1) == ' '))
      pbfr.a(c);
    end
  end

  post = cell2str(pbfr.flush());
end
