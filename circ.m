% "Circularize"
% This function takes a value and "mods" it
% back into a specified range. This is handy
% for restricting input to a certain area with
% looping.
%
% circ()
function post = circ(pre, low, up)
    post = pre;
    len = up - low;

    for i = 1:length(post)
        while (post(i) > up)
            post(i) = post(i) - len - 1;
        end

        while (post(i) < low)
            post(i) = post(i) + len + 1;
        end
    end
end
