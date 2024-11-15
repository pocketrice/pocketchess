function result = valrel(pos, offset, player)
    % pos = (x,y)
    % offset = (±x, ±y)
    % player = 1 or 2

    if (player == 1)
        offset = -offset;
    end

    newPos = pos + offset;
    result = (all(newPos >= 1) && all(newPos <= 8));
end
    
