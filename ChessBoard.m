classdef ChessBoard < handle
    properties
        Board
        % This is an 8x8 matrix that can either have 0 (empty) or ChessPieces.
        % It is something called a cell array, which looks something like
        % this: {0, 0, ChessPiece, 0, ChessPiece}.

        % You can access an item in a cell array like regular arrays, just
        % use {} instead of (). So something like "board{3,5}" to get 5th
        % piece on 3rd row.

        % If you try to use "board(3,5)" to get an item it will give you a
        % cell array of just that item instead ({ChessPiece} or {0}), which you can't really do anything with.
    end

    methods
        function obj = ChessBoard()
            global WhitePawn WhiteRook WhiteKnight WhiteBishop WhiteQueen WhiteKing BlackPawn BlackRook BlackKnight BlackBishop BlackQueen BlackKing;

            % This is defining the chess pieces we'll need to first set up
            % the board. You can see how to create a ChessPiece (just pass
            % it a PieceType and 1 for white or 2 for black).
            WhitePawn = ChessPiece(PieceType.Pawn, 1);
            WhiteRook = ChessPiece(PieceType.Rook, 1);
            WhiteKnight = ChessPiece(PieceType.Knight, 1);
            WhiteBishop = ChessPiece(PieceType.Bishop, 1);
            WhiteQueen = ChessPiece(PieceType.Queen, 1);
            WhiteKing = ChessPiece(PieceType.King, 1);
            BlackPawn = ChessPiece(PieceType.Pawn, 2);
            BlackRook = ChessPiece(PieceType.Rook, 2);
            BlackKnight = ChessPiece(PieceType.Knight, 2);
            BlackBishop = ChessPiece(PieceType.Bishop, 2);
            BlackQueen = ChessPiece(PieceType.Queen, 2);
            BlackKing = ChessPiece(PieceType.King, 2);

            % Below, the board is organized like so:
            % _________________
            % |_|_|_|_|_|_|_|_|  1
            % |_|_|_|_|_|_|_|_|  2
            % |_|_|_|_|_|_|_|_|  3
            % |_|_|_|_|_|_|_|_|  4
            % |_|_|_|_|_|_|_|_|  5
            % |_|_|_|_|_|_|_|_|  6
            % |_|_|_|_|_|_|_|_|  7
            % |_|_|_|_|_|_|_|_|  8
            %  1 2 3 4 5 6 7 8
            %
            % ...where the black pieces are in rows 1-2 and white in rows
            % 7-8.
            %
            % This is also why it's a cell array; with regular array you
            % can't use both ChessPiece and numbers — so [0, ChessPiece, 0]
            % won't work.
            %
            % You can access this matrix directly using something like
            % "board = cb.Board"

            

             % REGULAR PRESET
              obj.Board = { BlackRook, BlackKnight, BlackBishop, BlackQueen, BlackKing, BlackBishop, BlackKnight, BlackRook;
                 BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn;
                 0, 0, 0, 0, 0, 0, 0, 0;
                 0, 0, 0, 0, 0, 0, 0, 0;
                 0, 0, 0, 0, 0, 0, 0, 0;
                 0, 0, 0, 0, 0, 0, 0, 0;
                 WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn;
                 WhiteRook, WhiteKnight, WhiteBishop, WhiteKing, WhiteQueen, WhiteBishop, WhiteKnight, WhiteRook };

             % CHAOS PRESET
              % obj.Board = { BlackRook, BlackKnight, BlackBishop, BlackRook, BlackKing, BlackBishop, BlackKnight, BlackRook;
              %    BlackQueen, BlackQueen, BlackQueen, BlackQueen, BlackQueen, BlackQueen, BlackQueen, BlackQueen;
              %    0, 0, 0, 0, 0, 0, 0, 0;
              %    0, 0, 0, 0, 0, 0, 0, 0;
              %    0, 0, 0, 0, 0, 0, 0, 0;
              %    0, 0, 0, 0, 0, 0, 0, 0;
              %    WhiteQueen, WhiteQueen, WhiteQueen, WhiteQueen, WhiteQueen, WhiteQueen, WhiteQueen, WhiteQueen;
              %    WhiteRook, WhiteKnight, WhiteBishop, WhiteKing, WhiteRook, WhiteBishop, WhiteKnight, WhiteRook };

               % DUEL PRESET
               % obj.Board = { BlackRook, BlackKnight, BlackBishop, 0, BlackKing, BlackBishop, BlackKnight, BlackRook;
               %    BlackKnight, 0, 0, BlackQueen, BlackQueen, 0, 0, BlackKnight;
               %    0, 0, 0, 0, 0, 0, 0, 0;
               %    BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn;
               %    WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn;
               %    0, 0, 0, 0, 0, 0, 0, 0;
               %    WhiteKnight, 0, 0, WhiteQueen, WhiteQueen, 0, 0, WhiteKnight;
               %    WhiteRook, WhiteKnight, WhiteBishop, WhiteKing, 0, WhiteBishop, WhiteKnight, WhiteRook };
        end

        % "Position of piece"
        % Gets the positions of the given piece.
        % There might be more than 1 of that piece (such as white rook) so
        % it will usually be an array.
        %
        % cb.getpos(WhiteRook)
        %
        function pos = getpos(obj, piece)
            pos = obj.pquery(piece.Type, piece.Player);
        end

        %
        % "Query pieces"
        % This function gives you a cell array with all the pieces
        % currently on the board (handy if you need to loop through all the
        % pieces).
        %
        % This includes their position as well.
        %
        % cb.query()
        %           = {{ChessPiece, [3,4]}, {ChessPiece, [2,4]}, {ChessPiece, [1,3]}...}
        %
        function pieces = query(obj)
            indices = find(cellfun(@(p) ~iseabs(p), obj.Board));

            pieces = arrayfun(@(ind) {obj.get(unflat(ind, 8)), unflat(ind, 8)}, indices, 'UniformOutput', false);

            % lame readable approach :c
            % pieces = cell(length(indices));

            % for i = 1:length(indices)
            %     pieces(i) = {obj.Board(indices(i), indices(i))};
            % end
        end

        % "Antiquery"
        %
        % Gets all empty spaces.
        %
        function pieces = aquery(obj)
            indices = find(cellfun(@(p) iseabs(p), obj.Board));

            pieces = arrayfun(@(ind) {obj.get(unflat(ind, 8)), unflat(ind, 8)}, indices, 'UniformOutput', false);
        end

        % "Enigma query"
        %
        % Gets all enigma pieces.
        function pieces = equery(obj)
            indices = find(cellfun(@(p) ~iseabs(p) && ~isempty(p.Enigmas), obj.Board));

            pieces = arrayfun(@(ind) {obj.get(unflat(ind, 8)), unflat(ind, 8)}, indices, 'UniformOutput', false);
        end

        % "Piece query"
        %
        % Gets pieces of player {[piece, pos]...}
        % You can either pass in 1 parameter (ChessPiece)
        %                     or 2 parameters (type, player)
        %
        function pieces = pquery(obj, varargin)
            if nargin == 3
                jp = ChessPiece(varargin{1}, varargin{2});
            else
                jp = varargin{1};
            end

            pieces = {};

            for i = 1:8
                for j = 1:8
                    cp = obj.get([i,j]);

                    if (~iseabs(cp) && cp == jp)
                        pieces{end + 1} = {cp, [i,j]};
                    end
                end
            end
        end

        % "King query"
        % Queries both kings, only position. 0 if non-existent; [white, black]
        function kings = kquery(obj)
            whitepq = obj.pquery(PieceType.King, 1);
            blackpq = obj.pquery(PieceType.King, 2);

            if isempty(whitepq)
                kings{1} = 0;
            else
                wk = whitepq{1};
                kings{1} = wk{2};
            end

            if isempty(blackpq)
                kings{2} = 0;
            else
                bk = blackpq{1};
                kings{2} = bk{2};
            end
        end

        % "Query's valid pieces"
        % Gets indices of query array that have any valid moves.
        % ...this doesn't mean they will be good moves.
        function inds = qvp(obj, query)
            % Extract position vector
            qpos = exti(query, 2);

            % Get indices
            % inds = find(~isempty(obj.vmoves(qpos)));
            inds = [];

            for i = 1:length(qpos)
                if ~isempty(obj.vmoves(qpos{i}))
                    inds(end + 1) = i;
                end
            end
        end


        % "Add enigma"
        % Pieces are not handles and thus we need to manually overwrite on
        % the board.
        %
        function eniga(obj, pos, enig)
            piece = obj.get(pos);
            piece.Enigmas = [ piece.Enigmas, enig ];
            obj.pow(pos, piece);
        end


        % "Correspondence"
        % Creates the abstract correspondence (sprite index array) for the concrete
        % representation (board cell array) based on OSU Components
        % conventions.
        %
        % Tip: chain this with mow() on Layer 2 for easy updating.
        %
        % The example below uses the pieceExistsMapper function (you can
        % pass functions instead of vars by putting @), which is
        % what it says on the tin — if it exists, then abstract it as 1,
        % otherwise 0. Thus the correspondence reflects that.
        %
        % cb.correspond(@pieceExistsMapper)
        %                   = [1, 1, 1, 1, 1, 1, 1, 1;
        %                      1, 1, 1, 1, 1, 1, 1, 1;
        %                      0, 0, 0, 0, 0, 0, 0, 0;
        %                      0, 0, 0, 0, 0, 0, 0, 0;
        %                      0, 0, 0, 0, 0, 0, 0, 0;
        %                      0, 0, 0, 0, 0, 0, 0, 0;
        %                      1, 1, 1, 1, 1, 1, 1, 1;
        %                      1, 1, 1, 1, 1, 1, 1, 1]
        %
        %
        % The example below uses the intended mapper @pieceMapper, which
        % converts each ChessPiece (or 0) to its intended sprite index.
        % This also means any sprite indices are hard-coded, so any changes
        % to the spritesheet should be manually reflected in the mapper.
        %
        % This means you can directly slot this onto the Layer 2 matrix via
        % the "matrix overwrite" function or mow()!
        %
        % corr = cb.correspond(@pieceMapper)
        %                   = [15, 16, 14, 13, 12, 14, 16, 15;
        %                      11, 11, 11, 11, 11, 11, 11, 11;
        %                      100, 100, 100, 100, 100, 100, 100, 100;
        %                      100, 100, 100, 100, 100, 100, 100, 100;
        %                      100, 100, 100, 100, 100, 100, 100, 100;
        %                      100, 100, 100, 100, 100, 100, 100, 100;
        %                      1, 1, 1, 1, 1, 1, 1, 1;
        %                      5, 6, 4, 2, 3, 4, 6, 5]
        %
        % layer2 = mow(layer2, corr, [3,1])
        %
        function abscorr = correspond(obj, mapper)
            abscorr = cellfun(mapper, obj.Board);
        end


        %
        % "Is unobstructed"
        % This function, given a start (oldPos) and end position (newPos)
        % tells you if there are any pieces between them ("obstructing" the
        % path).
        %
        % REQUIRED: oldPos and newPos are on the board and path is
        % vertical/horizontal/diagonal.
        %
        % cb.isuno([1,1], [5,5])
        %           = 0 <-- the diagonal path is clear
        %

        function result = isuno(obj, oldPos, newPos)
            oldPos = unflat(oldPos, 8);
            newPos = unflat(newPos, 8);

            indices = indmat(oldPos, newPos);

            % Remove piece itself
            indices = indices(2:length(indices));

            result = all(cellfun(@(p) obj.iserel(p), indices));
        end

        %
        % "Get piece from position"
        % This function extracts the item at the board position.
        % You can pass it either an flat index or index pair.
        %
        % cb.get(13) <-- 8 + 5, so row 2 item 5
        %           = ChessPiece
        %
        % cb.get([2,5]) <-- same as above
        %           = ChessPiece

        function item = get(obj, pos)
            pos = unflat(pos, 8);

            item = obj.Board{pos(1), pos(2)};
        end

        %
        % "Is empty relative"
        % This function tells you if the board position is empty or not.
        %
        % Similar to iseabs(piece), which tells you if the extracted
        % "piece" is 0 or actually a piece.
        %
        % cb.iserel([1,1])
        %           = 1 <-- the space is empty
        %

        function result = iserel(obj, pos)
            piece = obj.get(unflat(pos, 8));

            result = (isa(piece, "double"));
        end

        %
        % "Is opponent"
        % This function tells you if the piece at the board position is an
        % opponent or not.
        %
        % The player parameter is the current player, so either 1 or 2.
        %
        % cb.isoppo([3,3], 1)
        %           = 1 <-- given we are white, the piece at [3,3] is an opponent (black)
        %

        function result = isoppo(obj, pos, player)
            piece = obj.get(unflat(pos, 8));

            result = (~iseabs(piece) && piece.Player ~= player);
        end

        % "Indices until obstacle"
        % This function gives you an array of spaces from your starting
        % position until it either reaches edge of the board or a piece in
        % the way. It doesn't take into account what kind of piece it is,
        % just that it can move in that direction (same output whether pawn or
        % bishop, for example).
        %
        % The dir parameter is in the form Direction.[something], so
        % Direction.Left, Direction.Right, etc. This is which way you are
        % checking. Open the "Direction.m" file to see all options. The
        % directions are all relative (it takes into account which way each
        % player is facing) so down doesn't necessarily mean always going
        % down rows of the matrix.
        %
        % The oppoAware parameter stands for "is aware of opponents", and
        % instead of stopping before any piece will include that occupied
        % space if it has an opponent piece (useful for capturing pieces).
        % Set it to 0 to disable, 1 for enable and current player is white,
        % 2 for enable and current player is black.
        %
        % ~~Note what is returned are flat indices, so instead of [row,
        % column] it is the # of spaces from the top-left corner. You can
        % still index an array with it. array(10) is the same as
        % array([1,2])!~~
        %
        % 2D indices are returned now!
        %
        % cb.iuntil([2,2], Direction.LeftUp, 0)
        %           = [18, 25, 33] <-- the pawn at [2,2] can go diagonally
        %                              left and up for these 3 spaces until
        %                              reaching the board edge or an
        %                              obstacle
        %
        % cb.iuntil([4,4], Direction.Down, 2)
        %           = [8, 16, 24, 32] <-- the black rook at [4,4] can go
        %                                 downwards for these four spaces
        %                                 until reaching board edge or
        %                                 obstacle (obstacle is a white
        %                                 bishop so it is included in
        %                                 possible moves)
        %

        function indices = iuntil(obj, pos, dir, oppoAware)
            indices = obj.iuntilmax(pos, dir, 8, oppoAware);
        end

        % "Indices until obstacle or max spaces"
        % This function is the same as iuntil() but you can give it a max #
        % of spaces it can move too — for the king you would use max = 1.
        %
        % cb.iuntil([1,5], Direction.Up, 0)
        %                   = [13, 21, 29] <-- the black king has three
        %                                      open spaces in front of it
        %
        % cb.iuntilmax([1,5], Direction.Up, 1, 0)
        %                   = [13]         <-- the black king can only move
        %                                      1 space, so limit to max of
        %                                      1.
        %
        function indices = iuntilmax(obj, pos, dir, max, oppoAware)
            % Unflat pos
            pos = unflat(pos, 8);

            % Get offset from direction, and relative fix based on player
            offset = dir.Offset;
            if (obj.get(pos).Player == 1)
                offset = -offset;
            end

            % Last valid position until obstruction/off-board
            lastValidPos = pos;

            % # of spaces checked.
            numSpaces = 0;

            % Run condition.
            isFinding = 1;

            % Keep searching in direction until BEFORE invalid index hit or
            % checked spaces = max.
            while (isFinding)
                % Look-ahead at next hit.
                nextPos = lastValidPos + offset;
                isFinding = valabs(nextPos) && obj.iserel(nextPos) && numSpaces + 1 <= max;

                % Apply (confirmed) offset; if oppo aware and is opposing player then add and
                % stop.
                if (isFinding || (numSpaces + 1 <= max && valabs(nextPos) && oppoAware && obj.isoppo(nextPos, oppoAware)))
                    lastValidPos = nextPos;
                    numSpaces = numSpaces + 1;
                end
            end

            % Add all indices
            indices = indmat(pos, lastValidPos);

            % Remove current position (1st item).
            indices = indices(2:length(indices));
        end

        % "Get consuming moves for player"
        % Gets all consuming moves for particular player.
        % Stored as pair of coords (old and new) since this targets all
        % rather than just 1 piece.
        function movepairs = cpmoves(obj, player)
            types = [ PieceType.Pawn, PieceType.Knight, PieceType.King, PieceType.Bishop, PieceType.Queen, PieceType.Rook ];
            movepairs = {};

            % For every piece type...
            for type = types
                % Get all positions for pieces of that type...
                typepos = exti(obj.pquery(type, player), 2);

                % For every position get every cmoves...
                for tpcell = typepos
                    tp = tpcell{1};
                    cmoves = obj.cmoves(tp);

                    % For every cmoves, add to movepairs.
                    if ~isempty(cmoves)
                        for ccell = cmoves
                            c = ccell{1};
                            movepairs{end+1} = {tp, c};
                        end
                    end
                end
            end
        end

        % "Get checking moves"
        function moves = chmoves(obj, pos) 
            % Get position's player
            player = obj.get(pos).Player;
            
            % Get position's opponent
            opponent = circ(player + 1, 1, 2);

            % Get all valid moves for piece
            moves = obj.vmoves(pos);

            % Keep only the moves that put other opponent in check
            for i = length(moves):-1:1
                % Get move
                move = moves{i};
                
                % Check if that move puts opponent in check
                if obj.checkresmove(pos, move, opponent)
                    moves(i) = [];
                end
            end
        end

        % "Get checking moves for player"
        % Gets all moves that check the other player for particular player.
        % See instructions for cpmoves.
        function movepairs = chpmoves(obj, player)
             types = [ PieceType.Pawn, PieceType.Knight, PieceType.King, PieceType.Bishop, PieceType.Queen, PieceType.Rook ];
            movepairs = {};

            % For every piece type...
            for type = types
                % Get all positions for pieces of that type...
                typepos = exti(obj.pquery(type, player), 2);

                % For every position get every chmoves...
                for tpcell = typepos
                    tp = tpcell{1};
                    cmoves = obj.chmoves(tp);

                    % For every cmoves, add to movepairs.
                    if ~isempty(cmoves)
                        for ccell = cmoves
                            c = ccell{1};
                            movepairs{end+1} = {tp, c};
                        end
                    end
                end
            end
        end


        % "Get consuming moves for piece"
        % Gets indices of vmoves that are moves that consume a piece.
        % Handy for check checking or ChessBot move priority.
        function moves = cmoves(obj, pos)
            moves = {};

            % Check if not empty.
            if ~iseabs(obj.get(pos))
                player = obj.get(pos).Player;
                allmoves = horzcat(obj.vmoves(pos), obj.evmoves(pos));

                for i = 1:length(allmoves)
                    move = allmoves{i};

                    if obj.isoppo(move, player)
                        moves{end + 1} = move;
                    end
                end
            end
        end

        % "Get valid moves for player"
        % Gets all valid moves for a player in a cell array in {{oldpos,
        % newpos}...} format.
        function movepairs = vpmoves(obj, player)
            types = [ PieceType.Pawn, PieceType.Knight, PieceType.Bishop, PieceType.Rook, PieceType.Queen, PieceType.King ];
            movepairs = {};

            % For every piece type...
            for type = types
                % Get all positions for pieces of that type...
                typepos = exti(obj.pquery(type, player), 2);

                % For every position get every vmoves...
                for tpcell = typepos
                    tp = tpcell{1};
                    vmoves = obj.vmoves(tp);

                    % For every cmoves, add to movepairs.
                    if ~isempty(vmoves)
                        for vcell = vmoves
                            v = vcell{1};
                            movepairs{end+1} = {tp, v};
                        end
                    end
                end
            end
        end

        % "Filter resolving moves for piece"
        % Get subset of moves from a given set of moves from a static position (such as vmoves)
        % that are resolving (or don't put the player in check).
        function submoves = frmoves(obj, pos, moves)
            % Get the player!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            player = obj.get(pos).Player;

            % Loop through all the moves.
            submoves = moves;

            for i = length(submoves):-1:1
                % Remove if not resolving (puts in check).
                if ~obj.checkresmove(pos, submoves{i}, player)
                    submoves(i) = [];
                end
            end
        end

        % "Filter resolving moves for player"
        % Get subset of moves from a given set of  (use player moves
        % functions such as vpmoves or cpmoves)
        % that are resolving (see frmoves for details)
        function submovepairs = frpmoves(obj, movepairs, player)
            % Loop through all the movepairs.
            submovepairs = movepairs;

            for i = length(submovepairs):-1:1
                % Get the start and end of movepair
                submovepair = submovepairs{i};
                submstart = submovepair{1};
                submend = submovepair{2};

                % Remove if not resolving (puts in check)
                if ~obj.checkresmove(submstart, submend, player)
                    submovepairs(i) = [];
                end
            end
        end

        % "Get resolving moves for piece"
        % Integrates checkresmove to ensure the moves passed in resolve check.
        % You should only pass either vmoves and/or emoves into this!
        function submoves = rmoves(obj, pos)
            % If empty, return.
            if obj.iserel(pos)
                submoves = [];
            else
                % Get all valid moves
                submoves = obj.vmoves(pos);

                % Get player of piece @ position
                player = obj.get(pos).Player;


                % Remove any moves that won't resolve check
                for i = length(submoves):-1:1
                    rm = submoves{i};

                    if ~obj.checkresmove(pos, rm, player)
                        submoves(i) = [];
                    end
                end
            end
        end

        % "Get resolving enigma moves for piece"
        % Same as rmoves. Please don't confuse this with removing a piece.
        function submoves = removes(obj, pos)
            % If empty, return.
            if obj.iserel(pos)
                submoves = [];
            else
                % Get all valid moves
                submoves = obj.evmoves(pos);

                % Get player of piece @ position
                player = obj.get(pos).Player;


                % Remove any moves that won't resolve check
                for i = length(submoves):-1:1
                    rm = submoves{i};

                    if ~obj.checkresmove(pos, rm, player)
                        submoves(i) = [];
                    end
                end
            end
        end

        % "Get resolving moves for player"
        function movepairs = rpmoves(obj, player)
            types = [ PieceType.Pawn, PieceType.Knight, PieceType.Bishop, PieceType.Rook, PieceType.Queen, PieceType.King ];
            movepairs = {};

            % For every piece type...
            for type = types
                % Get all positions for pieces of that type...
                typepos = exti(obj.pquery(type, player), 2);

                % For every position get all rmoves
                for tpcell = typepos
                    tp = tpcell{1};
                    rmoves = obj.rmoves(tp);

                    % For every rmoves, add to movepairs.
                    if ~isempty(rmoves)
                        for rcell = rmoves
                            movepairs{end+1} = {tp, unwrap(rcell)};
                        end
                    end
                end
            end
        end

        %
        % "Get valid moves for piece"
        % This function returns a cell array of all the valid moves for a
        % piece at the given position.
        %
        % Note that "moves" represents absolute indices (rather than
        % relative to the given position), so you can directly use these to
        % change the sprites on the board where the user can move the
        % piece.
        %
        % UPDATE: This also takes into account checking!!
        %
        % To iterate through a cell array, you can use foreach loop and extract
        % each from cells like so:
        %
        % for cell in moves
        %   index = cell{1};
        %   ...
        % end
        %
        % ...or, you can use a regular forloop and use the extract
        % function.
        %
        % for i = 1:length(moves)
        %   index = moves{i};
        %   ...
        % end
        %
        %
        % cb.vmoves([7,6])
        %           = { }                    <-- there are no possible moves for this pawn
        %
        % cb.vmoves([1,8])
        %           = { [2,8], [2,9] }       <-- the pawn can go diagonally to
        %                                        the left or forward 1.
        %
        % cb.vmoves([5,7])
        %           = { 13, 15, 16, 19, 54 } <-- the bishop is implemented
        %                                        using iuntil() and gives
        %                                        absolute indices. You can
        %                                        still loop through and use
        %                                        them!

        function moves = vmoves(obj, pos)
            % Get chess piece object
            piece = obj.get(unflat(pos, 8));

            % This is a queue, which stores items dynamically. A regular
            % array can't change size so this makes things faster. All you
            % have to know is to add an item use q.enq(x) and to remove an
            % item use q.deq(x).
            %
            % q.enqa(x), or "enqueue all" lets you pass in an array of
            % items to be added.
            %
            % The queue removes the oldest items first.
            %
            % To turn it back into an array just use q.vec().
            %
            % q = Queue(0);      <-- when creating the queue tell it what
            %                        type of item you are storing (in this
            %                        case just single #s)
            %
            % q.enq(5);          <-- the queue is now [5]
            % q.enq(4);          <-- the queue is now [4, 5]
            % q.enq(3);          <-- the queue is now [3, 4, 5]
            % q.enqa([2,1,0]);   <-- the queue is now [0, 1, 2, 3, 4, 5]
            %
            % item1 = q.deq();   <-- the queue is now [0, 1, 2, 3, 4]; item1 is 5
            % item2 = q.deq();   <-- the queue is now [0, 1, 2, 3]; item2 is 4
            %
            % moves = q.vec();   <-- moves = [0,1,2,3] in array form
            % q.clear();         <-- the queue is now []
            %

            %
            % In this case the queue stores index pairs (so something like
            % [x,y]) so I tell the queue that using [0,0].
            %
            vq = Queue([0,0]);

            % If no piece present, skip all checks.
            if (~iseabs(piece))
                player = piece.Player; % 1 for white, 2 for black

                % Check all potential moves based on piece type.
                switch (piece.Type)
                    case PieceType.Pawn
                        % Move forward 1 space (## target is empty)
                        move_fw1 = rel2abs(pos, [1,0], player);

                        if (valabs(move_fw1) && obj.iserel(move_fw1))
                            vq.enq(move_fw1);
                        end

                        % Move forward 2 spaces (## on start row, target is empty and path unobstructed)
                        move_fw2 = rel2abs(pos, [2,0], player);

                        if (valabs(move_fw2) && isstar(PieceType.Pawn, pos, player) && obj.isuno(pos, move_fw2))
                            vq.enq(move_fw2);
                        end

                        % Diagonal 1 space (## target occupied by opponent)
                        move_diag_l = rel2abs(pos, [1,1], player);
                        move_diag_r = rel2abs(pos, [1,-1], player);

                        if (valabs(move_diag_l) && obj.isoppo(move_diag_l, player))
                            vq.enq(move_diag_l);
                        end

                        if (valabs(move_diag_r) && obj.isoppo(move_diag_r, player))
                            vq.enq(move_diag_r);
                        end

                        % En passant (## pawn on player's 4th rank, prior
                        % turn opponent 2-hopped to horizontal adjacent)

                        % TODO
                    case PieceType.King
                        % All spaces in 1-space radius (## target
                        % unoccupied or is opponent)
                        vq.enqa(obj.iuntilmax(pos, Direction.Left, 1, player));
                        vq.enqa(obj.iuntilmax(pos, Direction.Right, 1, player));
                        vq.enqa(obj.iuntilmax(pos, Direction.Up, 1, player));
                        vq.enqa(obj.iuntilmax(pos, Direction.Down, 1, player));
                        vq.enqa(obj.iuntilmax(pos, Direction.LeftUp, 1, player));
                        vq.enqa(obj.iuntilmax(pos, Direction.LeftDown, 1, player));
                        vq.enqa(obj.iuntilmax(pos, Direction.RightUp, 1, player));
                        vq.enqa(obj.iuntilmax(pos, Direction.RightDown, 1, player));

                    case PieceType.Rook
                        % All spaces on horizontal/vertical until
                        % obstructed
                        vq.enqa(obj.iuntil(pos, Direction.Left, player));
                        vq.enqa(obj.iuntil(pos, Direction.Right, player));
                        vq.enqa(obj.iuntil(pos, Direction.Up, player));
                        vq.enqa(obj.iuntil(pos, Direction.Down, player));

                    case PieceType.Bishop
                        % All spaces on diagonals until obstructed
                        vq.enqa(obj.iuntil(pos, Direction.LeftUp, player));
                        vq.enqa(obj.iuntil(pos, Direction.LeftDown, player));
                        vq.enqa(obj.iuntil(pos, Direction.RightUp, player));
                        vq.enqa(obj.iuntil(pos, Direction.RightDown, player));

                    case PieceType.Queen
                        % All spaces on hor/vert/diagonals until obstructed
                        vq.enqa(obj.iuntil(pos, Direction.Left, player));
                        vq.enqa(obj.iuntil(pos, Direction.Right, player));
                        vq.enqa(obj.iuntil(pos, Direction.Up, player));
                        vq.enqa(obj.iuntil(pos, Direction.Down, player));
                        vq.enqa(obj.iuntil(pos, Direction.LeftUp, player));
                        vq.enqa(obj.iuntil(pos, Direction.LeftDown, player));
                        vq.enqa(obj.iuntil(pos, Direction.RightUp, player));
                        vq.enqa(obj.iuntil(pos, Direction.RightDown, player));

                    case PieceType.Knight
                        % This is the 8 potential indices in relative form.
                        relMoves = { [1,-2], [1,2], [2,-1], [2,1], [-2,-1], [-2,1], [-1,-2], [-1,2] };

                        % Filter out off-board moves
                        relMoves = relMoves(cellfun(@(p) valrel(pos,p,player), relMoves));

                        % Convert to absolute indices
                        absMoves = cellfun(@(p) rel2abs(pos,p,player), relMoves, 'UniformOutput', false);

                        % Add if unoccupied or is opponent
                        for move = absMoves
                            emove = unwrap(move);
                            if (obj.iserel(emove) || obj.isoppo(emove, player))
                                vq.enq(emove);
                            end
                        end
                end
            end

            % Convert queue to vector.
            moves = vq.vec();
        end

        % "Enigma valid moves"
        % Separated for ease of coloring.
        function moves = evmoves(obj, pos)
            piece = obj.get(pos);
            player = piece.Player;

            if ~iseabs(piece)
                enigmas = vdecomp(piece.Enigmas);
                vq = Queue([0,0]);

                for i = 1:length(enigmas)
                    e = enigmas{i};
                    etype = e{1};
                    ecount = e{2};

                    % Note: you can be guaranteed at least 1 of the type
                    % exists, hence a few assumptions below (see Sidewind)
                    switch etype
                        case EnigmaType.Backtrot % ## unoccupied [-1]
                            move_bt = rel2abs(pos, [-1,0], player);

                            if valabs(move_bt) && obj.iserel(move_bt)
                                vq.enq(move_bt);
                            end
                        case EnigmaType.Sidewind % ## unoccupied [2]
                            % All possible moves
                            potens = {[0,-1], [0,1]};

                            % Get corresponding amount of moves based on
                            % ecount
                            potens = potens(1:ecount);

                            for p = potens
                                move = rel2abs(pos, p{1}, player);

                                if valabs(move) && obj.iserel(move)
                                    vq.enq(move);
                                end
                            end
                        case EnigmaType.Protractor % ## unoccupied or opponent [4]
                            potens = {[2,-2], [-2,2], [2,2], [-2,-2]};
                            potens = potens(1:ecount);

                            for p = potens
                                move = rel2abs(pos, p{1}, player);

                                if valabs(move) && (obj.iserel(move) || obj.isoppo(move, player))
                                    vq.enq(move);
                                end
                            end
                        case EnigmaType.Missile % ## has opponent in n radius [3]
                            radius = ecount; % 1x1, 2x2, 3x3
                            rspaces = frring(radius, pos);

                            for rscell = rspaces
                                rs = rscell{1};

                                if obj.isoppo(rs, player)
                                    vq.enq(rs);
                                end
                            end
                        case EnigmaType.Panick % ## is checked, unoccupied or opponent [3]
                        case EnigmaType.Magnesis % ## nothing to do [3]
                        case EnigmaType.Chakra % ## nothing to do [1]
                    end
                end

                moves = vq.vec();
            else
                moves = [];
            end
        end


        % "Move piece"
        % Moves the piece at old position to new position.
        % If there was a piece there, it is replaced (the removed piece
        % is set to the variable "capture")
        %
        % REQUIRES oldPos to have a piece, newPos to not have same colored
        % piece
        %
        % cb.pmove([1,1], [3,3])
        %           = 0           <-- moved piece from [1,1] to [3,3]. No
        %                             piece was there so capture = 0.
        %
        % cb.pmove([1,2], [3,3])
        %           = ChessPiece  <-- moved white knight from [1,2] to [3,3].
        %                             There was a black rook so it is
        %                             replaced and set to "capture"
        %                             variable.
        %
        function capture = pmove(obj, oldPos, newPos)
            if (~all(oldPos == newPos))
                piece = obj.get(oldPos);
                capture = obj.get(newPos);

                obj.Board{newPos(1), newPos(2)} = piece;
                obj.Board{oldPos(1), oldPos(2)} = 0;
            end
        end


        % "Swap pieces"
        % Swaps the pieces at position A and B.
        %
        % REQUIRES posA and posB to have pieces on them
        %
        % cb.pswap([1,1], [8,8]) <-- the white rook and black rook
        %                            swap places on the board
        %
        function pswap(obj, posA, posB)
            if (~all(oldPos == newPos))
                pieceA = obj.get(posA);
                pieceB = obj.get(posB);

                obj.Board{posA(1), posA(2)} = pieceB;
                obj.Board{posB(1), posB(2)} = pieceA;
            end
        end

        % "Remove piece"
        % Removes the piece at the position.
        % The piece removed is set to "piece" variable.
        %
        % cb.prem([5,5])
        %           = 0            <-- there was no piece to remove at [5,5]
        %
        % cb.prem([3,3])
        %           = ChessPiece   <-- a white rook at [3,3] was removed
        %
        function piece = prem(obj, pos)
            piece = obj.get(pos);

            obj.Board{pos(1), pos(2)} = 0;
        end

        % "Overwrite piece"
        % Overwrites the piece at the location (can be empty or have
        % a piece there).
        % The "piece" variable is a ChessPiece (see top of file for how to
        % make a ChessPiece)
        %
        % If there was a piece replaced, then it is set to "ow" variable.
        %
        % cb.pow([2,2], ChessPiece(PieceType.Pawn, 1))
        %           = 0              <-- a white pawn is placed at [2,2]. There
        %                          was nothing there so ow = 0.
        %
        % cb.pow([2,4], ChessPiece(PieceType.Rook, 2))
        %           = ChessPiece      <-- a black rook is placed at [2,4].
        %                                 There was a white queen so it was
        %                                 set to "ow" variable.
        %
        function ow = pow(obj, pos, piece)
            ow = obj.get(pos);

            obj.Board{pos(1), pos(2)} = piece;
        end

        function result = checkcheck(obj, player)
            result = false;
            kq = obj.kquery();

            for r=(1:8)
                for c=(1:8)
                    %this will ensure that only valid chess pieces are considered (no
                    %empty spaces or invalid moves) and wasn't found yet
                    if ~obj.iserel([r,c]) && ~result
                        % list of valid moves for the piece at position.vmoves returns
                        % the possible moves for a given piece from its current pos
                        cmoves=obj.cmoves([r,c]);

                        for i = 1:length(cmoves)
                            cmove=cmoves{i};
                            %If any move in (cmoves) matches the king's position, it means
                            % that the king is in check. We check by ensuring
                            % both are permutations of each other.
                            if psame(cmove, kq{player})
                                result = true;
                            end
                        end
                    end
                end
            end
        end

        %this function is going to tell if a move made by a certain player resolves
        %check or not
        %or not
        function result = checkresmove(obj, oldPos, newPos, player)
            % cb.board will show the current position of each of the pieces, the
            % backup of this is so that any moves of pieces can be reverted
            %then we will simulate the move of a piece, by using the pmove
            %function, as long as there is a piece there
            backup = obj.Board;
            obj.pmove(oldPos, newPos);

            %check if the king is in check from the move
            result = ~checkcheck(obj, player);

            %this line restores the chessboard to its previous state
            %this makes sure the move made doesn't change the chessboard
            % permanently, because we were just checking the move before moving
            obj.Board = backup;
        end


        % Checks if the king is in checkmate or not
        function result = ischeckmate(obj, player)
            result = false;

            % Not in checkmate if not in check!
            if obj.checkcheck(player)
                % Get all valid moves for the player
                vmoves = obj.vpmoves(player);

                % Filter for only moves that resolve check
                for i = length(vmoves):-1:1
                    vmove = vmoves{i};
                    if ~obj.checkresmove(vmove{1}, vmove{2}, player)
                        vmoves(i) = [];
                    end
                end

                % If no moves that resolve check, then we are in checkmate.
                result = isempty(unwrap(vmoves));
            end
        end
    end
end