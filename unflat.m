function unf = unflat(f, ylen)
rows = 1;
cols = f;

    while cols > ylen
        cols = cols - ylen;
        rows = rows + 1;
    end

    unf = [rows, cols];
end
