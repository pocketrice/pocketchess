% "Indices matrix"
% Creates matrix of board indices in path from old to new position (path must be
% vertical/horizontal/diagonal).
%
% Note: [oldX:newX; oldY:newY] is naive approach but it doesn't work; the distance
% between X's and Y's are different if not diagonal (must have same length for both)
%
% ~~Note this returns flat index due to MATLAB restrictions. You can still use these just like [x,y] to index an
% matrix!~~
%
% UPDATE: 2D array now returned!!
%
% indmat([2,1], [2,5])
%           = [9,10,11,12,13]     <-- horizontal path from column 1-5 on row 2
%
% indmat([3,3], [8,3])
%           = [19,27,35,43,51,59] <-- vertical path from row 3-8 on column 3
%
% indmat([4,4], [1,1])
%           = [28,19,10,1]        <-- diagonal path from [4,4] up and left to [1,1]
%
        function indices = indmat(oldPos, newPos)
            oldY = oldPos(1);
            oldX = oldPos(2);
            newY = newPos(1);
            newX = newPos(2);

            % Horizontal
            if (oldX == newX)
                xRange = cons(oldY, newY);
                ind2d = [xRange; oldX * ones(1, length(xRange))];
            % Vertical
            elseif (oldY == newY)
                yRange = cons(oldX, newX);
                ind2d = [oldY * ones(1, length(yRange)); yRange];
            % Diagonal
            elseif (abs(newY - oldY) == abs(newX - oldX))
                ind2d = [cons(oldY, newY); cons(oldX, newX)];
            % Sanity check
            else
                error("Must use vert/hor/diag vector!");
            end

            % Flatten indices
            indices = sub2ind([8,8], ind2d(2,:), ind2d(1,:));

            % Unflatten into cells
            indices = arrayfun(@(i) unflat(i,8), indices, 'UniformOutput', false);
        end
