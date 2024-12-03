function post = unicodeMapper(pre)
  uc = ['♙', '♘', '♗', '♖', '♕', '♔'; '♟', '♞', '♝', '♜', '♛', '♚']; 

  if ~iseabs(pre)
    post = uc(pre.Player, abs(pre.rank()));

    else
    post = ' ';
  end
end


