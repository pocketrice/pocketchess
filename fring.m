% "Filled ring"
% Gets a ring of radius n+1 with center filled (basically (2n+1)-long square)
% n stands for # of spaces from center pos, hence n+1 and it always being odd.
function inds = fring(n, pos)
  inds = cell(2 * n + 1);

  for i = pos(1)-n:pos(1)+n
      for j = pos(2)-n:pos(2)+n
          inds{i-(pos(1)-n) + 1, j-(pos(2)-n) + 1} = [i,j];
      end
  end
end
