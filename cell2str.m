% "Matrix to raw string"
% Converts an array to (raw) string by concatenating each stringified item.
% This is different from mat2str as this removes any unnecessary spaces and
% delimiters.
%
% Take note! This preserves rows. Recursive!
%
% Pass in a delimiter (optional).
%
function post = mat2raw(pre, dlr)
    if nargin < 2
        dlr = '';
    end

    % Unwrap pre.
    pre = unwrap(pre, 1);

    if isscalar(pre)
        post = string(unwrap(pre,1));
    else
        csize = size(pre);
        post = strings(csize(1), 1);

        for i = 1:csize(1)
            for j = 1:csize(2)
                post(i) = post(i) + mat2raw(pre(i,j), dlr) + dlr;
            end
        end
    end
end