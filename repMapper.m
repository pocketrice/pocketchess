function post = repMapper(pre)
  if (~iseabs(pre))
    post = (pre.Player - 1) * 10 + abs(pre.rank());
  else
    post = 100;
  end
end


