% "Numeric sort"
% Sorts a numeric array from highest to lowest. Flip the vector for L -> H. This uses quicksort.
function post = nsort(pre)
post = pre;

if length(post) > 1
    if ~isnumeric(post)
        error("Cannot nsort a non-numeric array!");
    end

    parti = post(1);
    post = post(2:length(post));

    [front, back] = nparti(post, parti);

    front = nsort(front);
    back = nsort(back);

    post = [ front, parti, back ];
end
end
