% "Is move castle"
function result = iscastle(oldpos, newpos, piece)
  result = (piece.Type == PieceType.King && ~has(piece.Enigmas, EnigmaType.Panick) && psame(abs(newpos - oldpos), [0,2]));
end
