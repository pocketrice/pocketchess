% "char at"
% chat is this real???
function ch = chat(str, i)
  if isa(str, "string")
    str = str{:};
  end

  ch = str(i);
end
