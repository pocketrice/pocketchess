% "Matrix to digits"
% Takes matrix elements and appends each as a digit.
% Goes from top left to bottom right of matrix R2L.
function dig = mat2dig(mat)
  dig = "";

  msize = size(mat);

  for i = 1:msize(1)
    for j = 1:msize(2)
      dig = dig + mat(i,j);
    end
  end
end
