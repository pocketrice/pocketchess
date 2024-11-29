% "Is same type"
% Checks if all items in the matrix are the same datatype.
function result = isstype(vec)
  result = true;

  if ~isempty(vec)
    for item = vec
      if result && ((iscell(item) && ~strcmp(class(item{1}), class(vec{1}))) || ~strcmp(class(item), class(vec(1))))
        result = false;
      end
    end
  end
end
