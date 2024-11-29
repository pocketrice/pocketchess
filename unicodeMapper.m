function post = unicodeMapper(pre)
  uc = ['♙', '♘', '♗', '♖', '♕', '♔'; '♟', '♞', '♝', '♜', '♛', '♚']; 

  if ~iseabs(pre)
    player = pre.Player;
    type = pre.Type;

    post = uc(pre.Player, abs(pre.rank()));

    else
    post = ' ';
  end
end


