% "Decompose vector"
% Decomposes a vector into a "map" of items and their
% counts.
function dv = vdecomp(cv)
  dv = {};
  uv = puniq(cv);

  for i = 1:length(uv)
      ui = uv(i);
    dv{end + 1} = {ui, length(find(cv == ui))};
  end
end
