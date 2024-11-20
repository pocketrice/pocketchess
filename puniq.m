% "Property object uniques"
% Same as unique(), just for enums/objects with properties too
function post = puniq(pre)
  post = pre;
  ind = 1;

  while ind <= length(post)
    pi = post(ind);

    % Note: dupe index has to be shifted back to account for hiding n
    % items.
    dupei = ind + has(post(ind+1:length(post)), pi);

    while dupei > ind
      post(dupei) = [];
      dupei = ind + has(post(ind+1:length(post)), pi);
    end

    ind = ind + 1;
  end
end
