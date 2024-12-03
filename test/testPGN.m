cb = ChessBoard;
pgn = PGN(cb);
pgn.spopu;

cb.pgnmove([7,4], [5,4], pgn);
cb.pgnmove([2,5], [4,5], pgn, "interesting");
cb.pgnmove([5,4], [4,5], pgn, '', 4);
cb.pgnmove([1,2], [3,3], pgn);