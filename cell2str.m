% "Cell to string"
% Converts cell array to string by concatenating each stringified item.
% Take note! This preserves rows.
%
% Pass in a delimiter (optional).
function post = cell2str(pre, dlr)
    if nargin < 2
        dlr = '';
    end

    csize = size(pre);
    post = strings(csize(1), 1);

    for i = 1:csize(1)
        for j = 1:csize(2)
            post(i) = post(i) + string(pre{i,j}) + dlr;
        end
    end
end