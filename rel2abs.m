function absPos = rel2abs(relPos, offset, player)
    % pos = (x,y)
    % offset = (±x, ±y)
    % player = 1 (white) or 2 (black)
    
    % If P2, invert offset.
    if (player == 1)
        offset = -offset;
    end

    % Calculate and extract new position.
    absPos = relPos + offset;
   end
