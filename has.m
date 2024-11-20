% Result if nonzero is first index of item.
function result = has(vec, item)
  % Due to how arrays work if item is [] then it will be nonzero; hence
  % shortcircuit if so.
  if ~isempty(item)
    isc = iscell(vec);
    result = 0;
    vind = 1;

    while ~result && vind <= length(vec)
        if (isc)
            vitem = vec{vind};
        else
            vitem = vec(vind);
        end

        % Rather than using lens equal && all(vitem == item) (naive), since
        % cells can't be checked using == other than a manual loop this is
        % best approach.
        if isequal(vitem, item)
            result = vind;
        else 
            vind = vind + 1;
        end
    end
  else
    result = 0;
  end
end
