 % Get consecutive sequence between i1 and i2 (standard a:b format
        % requires checking if i1 > i2 else empty vector is produced)
        function vector = cons(i1, i2)
            if (i1 > i2)
                vector = fliplr(i2:i1);
            else
                vector = i1:i2;
            end
        end
