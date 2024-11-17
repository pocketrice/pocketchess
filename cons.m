% "Consecutive sequence"
% Creates a vector as a consecutive sequence from i1 to i2.
% Note just using [i1:i2] doesn't work for negative consecutive,
% since it increments by 1 instead of -1 by default. cons() makes it easier.
%
% cons(1,5)
%       = [1,2,3,4,5]
%
% cons(3,0)
%       = [3,2,1,0]
%
function vector = cons(i1, i2)
            if (i1 > i2)
                vector = fliplr(i2:i1);
            else
                vector = i1:i2;
            end
        end
