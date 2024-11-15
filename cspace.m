function spacer = cspace(obj, len)
    % Returns a horizontal cell array with [len] amount of [n].
    spacer = repmat({obj}, 1, len);
end
