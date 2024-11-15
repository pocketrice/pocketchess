% Create matrix for board indices using new X and Y; must be
        % vert/horizontal/diag. 

        % e.g. [oldX:newX; oldY:newY] if X is same fails b/c
        % the X vector is now 1; we need to extend it.

        % Note this returns flattened 1D indices due to MATLAB restrictions 
        function indices = indmat(oldPos, newPos)
            oldX = oldPos(1);
            oldY = oldPos(2);
            newX = newPos(1);
            newY = newPos(2);

            % Horizontal
            if (oldY == newY)
                xRange = cons(oldX, newX);
                ind2d = [xRange; oldY * ones(1, length(xRange))];
            % Vertical
            elseif (oldX == newX)
                yRange = cons(oldY, newY);
                ind2d = [oldX * ones(1, length(yRange)); yRange];
            % Diagonal
            elseif (abs(newX - oldX) == abs(newY - oldY))
                ind2d = [cons(oldX, newX); cons(oldY, newY)];
            % Sanity check
            else
                fprintf("indmat error; must use vert/hor/diag vector!\n");
            end

            indices = sub2ind([8,8], ind2d(2,:), ind2d(1,:));
        end
