% "Matrix to raw string"
% Converts cell array to string by concatenating each stringified item.
% Take note! This preserves rows and respects single-layer delimiting (e.g.
% for {3,4,{5,6}} you would get "3 4 56" and not "3 4 5 6". Pass in true
% for isdeepdlr for latter behaviour.
%
% Pass in a delimiter (optional).
function post = mat2raw(pre, dlr, isdeepdlr)
    if nargin < 2
        dlr = '';
    end

    if nargin < 3
        isdeepdlr = false;
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
                if isdeepdlr
                    idlr = dlr;
                else
                    idlr = '';
                end

                post(i) = post(i) + mat2raw(pre(i,j), idlr);

                if j ~= csize(2)
                    post(i) = post(i) + dlr;
                end
            end
        end
    end
end