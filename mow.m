% "Matrix overwrite"
% This function overwrites the given indices in "pre" (pre-matrix)
% using "ow" (object with what to overwrite) at the given offset.
%
% pre = [0, 0, 0, 0, 0;
%        0, 0, 0, 0, 0;
%        0, 0, 0, 0, 0]
%
% ow = [9, 9, 9;
%       9, 9, 9]
%
% mow(pre, ow, [0,0])
%         = [9, 9, 9, 0, 0;
%            9, 9, 9, 0, 0;
%            0, 0, 0, 0, 0]
%
% mow(pre, ow, [1,2])
%         = [0, 0, 0, 0, 0;
%            0, 0, 9, 9, 9;
%            0, 0, 9, 9, 9]
%
function post = mow(pre, ow, offset)
  dims = size(ow);
  post = pre;

  for i = 1:dims(1)
    for j = 1:dims(2)
      o = ow(i,j);
      post(i + offset(1), j + offset(2)) = o;
    end
  end
end

