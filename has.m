function result = has(vec, item)
if (isa(vec, 'cell'))
    vec = cell2mat(vec);
end

  result = 0;
  vind = 1;

  while ~result && vind <= length(vec)
    result = all(vec(vind) == item);
    vind = vind + 1;
  end
end
