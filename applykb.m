
function new = applykb(old, dir)
    % Apply offset
    new = old + dir.Offset;

    % Wrap values if exceeds board
    new = circ(new,1,8);
end
