function post = pieceMapper(pre)
  if (~iseabs(pre))
    player = pre.Player;
    type = pre.Type;

    switch type
      case PieceType.Rook
        id = 5;
      case PieceType.Bishop
        id = 4;
      case PieceType.Knight
        id = 6;
      case PieceType.Queen
        id = 3;
      case PieceType.King
        id = 2;
      case PieceType.Pawn
        id = 1;
    end

    post = (player - 1) * 10 + id;
  else
    post = 100;
  end
end


