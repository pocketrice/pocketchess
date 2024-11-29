function post = sanMapper(pre)
  if iseabs(pre)
    error("Cannot use SAN mapper with empty spaces — please use ChessBoard.query rather than looping through all.");
    end

    switch pre.Type
      case PieceType.Pawn
        post = '';
      case PieceType.Knight
        post = 'N';
      case PieceType.Bishop
        post = 'B';
      case PieceType.Rook
        post = 'R';
      case PieceType.Queen
        post = 'Q';
      case PieceType.King
        post = 'K';
    end
end


