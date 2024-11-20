function unf = unflat(f, ylen)
    if isscalar(f) 
        cols = 1;
        rows = f;

        while rows > ylen
            rows = rows - ylen;
            cols = cols + 1;
        end

        unf = [rows, cols];
    else
        unf = f;
    end
    
end
