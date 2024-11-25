% "Is absolute piece player type?"
% Or, in layman's terms, reports true if the acquired piece candidate is a [PLAYER] piece and false if empty or opponent. funnnn

% Please see isprel if you are just using a position.
function result = ispabs(piece, player)
  result = ~iseabs(piece) && piece.Player == player;
end
