classdef ChessBoard < handle
    properties
        Board % Must be 8x8 matrix of ChessPiece
    end

    methods
        function obj = ChessBoard()
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

            % Board is organized as such:
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

            % Since MATLAB is copy-by-value (unless you use handles)
            % "dupes" are fine.
            
            obj.Board = { BlackRook, BlackKnight, BlackBishop, BlackQueen, BlackKing, BlackBishop, BlackKnight, BlackRook;
                BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn;
                0, 0, 0, 0, 0, 0, 0, 0;
                0, 0, 0, 0, 0, 0, 0, 0;
                0, 0, 0, 0, 0, 0, 0, 0;
                0, 0, 0, 0, 0, 0, 0, 0;
                WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn;
                WhiteRook, WhiteKnight, WhiteBishop, WhiteKing, WhiteQueen, WhiteBishop, WhiteKnight, WhiteRook };
        end
        
        % Useful for internal logic (e.g. seeing what pieces are left to
        % check game state)
        function [pieces, indices] = query(obj)
            indices = find(cellfun(@(p) ~iseabs(p), obj.Board));
            pieces = obj.Board(indices);
        end

        % @requires all positions between are valid, path must be
        % vert/horizontal/diagonal. 
        % Checks (oldPos, newPos] and reports if unobstructed.
        function result = isuno(obj, oldPos, newPos)
            indices = indmat(oldPos, newPos);

            result = all(cellfun(@(p) iseabs(p), obj.Board(indices)));
        end

        % Extracts value from cell from board. Note: pos must be array so
        % you may have to call extabs (more general) on it.
        % Should be default accessor method for board items.
        function item = extrel(obj, pos)
            if (isscalar(pos))
                cell = obj.Board(pos);
            else
                cell = obj.Board(pos(1), pos(2));
            end
          
            item = extabs(cell);
        end 

        % Reports if space is empty.
        % Decent replacement for the simpler board(pos) == 0.
        function result = iserel(obj, pos)
            piece = obj.extrel(pos);

            result = (isa(piece, "double"));
        end

        % Reports if space contains an opposing piece.
        % Handy for avoiding having to do "piece exists?" checks.
        function result = isoppo(obj, pos, player)
            piece = obj.extrel(pos);
            
            result = (~iseabs(piece) && piece.Player ~= player);
        end

        % Get all indices in direction from position until obstruction.
        % ("Indices Until")
        % Note: we can just set a max of 8 to guarantee all checked.
        function indices = iuntil(obj, pos, dir, oppoAware)
            indices = obj.iuntilmax(pos, dir, 8, oppoAware);
        end

        % Get indices until or up to max ("Indices Until Or Max")
        % @requires position is valid index, dir must be Direction.*, isOppoAware is 0 if check for total
        % obstruction; otherwise (1 or 2) if space is opposing it is included and
        % stops.
        function indices = iuntilmax(obj, pos, dir, max, oppoAware)
            % Get offset from direction
            offset = dir.Offset;

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
                if (isFinding || (valabs(nextPos) && oppoAware && obj.isoppo(nextPos, oppoAware)))
                    lastValidPos = nextPos;
                    numSpaces = numSpaces + 1;
                end
            end

            % Add all indices
            indices = indmat(pos, lastValidPos);

            % Remove current position (1st item).
            indices = indices(2:length(indices));
        end

        % Gets all valid moves for a given index.
        % Note that ChessPiece doesn't store these moves because (a) many
        % are conditional (full length, en passant, obstacles), and (b) we
        % don't need to know what ALL possible moves are because we will
        % only display valid moves.
        
        % Hence, all movesets are hardcoded here.
        function moves = vmoves(obj, pos)
            % Get chess piece object
            piece = obj.extrel(pos);

            % Queue. Note: you should only add non-cell items ([a,b] not
            % {[a,b]}, so call extabs prior.
            vq = Queue([0,0]);

            % If no piece, skip all checks.
            if (~iseabs(piece)) 
                player = piece.Player; % 1 or 2
           
                % Get valid moves

                % ** NOTE: for every move you must check if indices are valid
                % using valrel() or valabs().
                switch (piece.Type)
                    case PieceType.Pawn
                        % Move forward 1 space (## not occupied)
                        move_fw1 = rel2abs(pos, [0,1], player);
                        
                        if (valabs(move_fw1) && iseabs(move_fw1))
                            vq.enq(move_fw1);
                        end

                        % Move forward 2 spaces (## @ start row, unoccupied, unobstructed)
                        move_fw2 = rel2abs(pos, [0,2], player);

                        if (valabs(move_fw2) && isstar(PieceType.Pawn, pos, player) && obj.isuno(pos, move_fw2))
                            vq.enq(move_fw2);
                        end

                        % Diagonal 1 space (## occupied by opponent)
                        move_diag_l = rel2abs(pos, [-1,1], player);
                        move_diag_r = rel2abs(pos, [1,1], player);

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
                        % All spaces in 1-space radius (## unoccupied or
                        % is opponent)
                        vq.enqa(obj.iuntilmax(pos, Direction.Left, 1, player));
                        vq.enqa(obj.iuntilmax(pos, Direction.Right, 1, player));
                        vq.enqa(obj.iuntilmax(pos, Direction.Up, 1, player));
                        vq.enqa(obj.iuntilmax(pos, Direction.Down, 1, player));
                        vq.enqa(obj.iuntilmax(pos, Direction.LeftUp, 1, player));
                        vq.enqa(obj.iuntilmax(pos, Direction.LeftDown, 1, player));
                        vq.enqa(obj.iuntilmax(pos, Direction.RightUp, 1, player));
                        vq.enqa(obj.iuntilmax(pos, Direction.RightDown, 1, player));

                    case PieceType.Rook
                        % All "until" indices on horizontal/vertical (## "until" condition)
                        vq.enqa(obj.iuntil(pos, Direction.Left, player));
                        vq.enqa(obj.iuntil(pos, Direction.Right, player));
                        vq.enqa(obj.iuntil(pos, Direction.Up, player));
                        vq.enqa(obj.iuntil(pos, Direction.Down, player));

                    case PieceType.Bishop
                        % All "until" indices on diagonals (## "until"
                        % condition)
                        vq.enqa(obj.iuntil(pos, Direction.LeftUp, player));
                        vq.enqa(obj.iuntil(pos, Direction.LeftDown, player));
                        vq.enqa(obj.iuntil(pos, Direction.RightUp, player));
                        vq.enqa(obj.iuntil(pos, Direction.RightDown, player));
                    
                    case PieceType.Queen
                        % All "until" indices on hor/vert/diags (## "until"
                        % condition)
                        vq.enqa(obj.iuntil(pos, Direction.Left, player));
                        vq.enqa(obj.iuntil(pos, Direction.Right, player));
                        vq.enqa(obj.iuntil(pos, Direction.Up, player));
                        vq.enqa(obj.iuntil(pos, Direction.Down, player));
                        vq.enqa(obj.iuntil(pos, Direction.LeftUp, player));
                        vq.enqa(obj.iuntil(pos, Direction.LeftDown, player));
                        vq.enqa(obj.iuntil(pos, Direction.RightUp, player));
                        vq.enqa(obj.iuntil(pos, Direction.RightDown, player));

                    case PieceType.Knight
                        % Check if all 8 potential L's are valid (##
                        % unoccupied or is opponent)
                        relMoves = { [1,-2], [1,2], [2,-1], [2,1], [-2,-1], [-2,1], [-1,-2], [-1,2] };

                        % Filter out off-board moves
                        relMoves = relMoves(cellfun(@(p) valrel(pos,p,player), relMoves));

                        % Convert to absolute indices
                        absMoves = cellfun(@(p) rel2abs(pos,p,player), relMoves, 'UniformOutput', false);
                       
                        % Enqueue if unoccupied or is opponent
                        for move = absMoves
                            emove = extabs(move);
                            if (obj.iserel(emove) || obj.isoppo(emove, player))
                                vq.enq(emove);
                            end
                        end
                end      
            end

             % Convert queue to vector.
             moves = vq.vec();
        end

        % Move chess piece at given pos to new pos, returning piece that
        % was replaced (if any). Moving a piece should solely be a move
        % from valid moves, as no validation occurs here.
        % @requires oldPos has piece, newPos valid
        function capture = pmove(obj, oldPos, newPos)
            piece = obj.extrel(oldPos);
            capture = obj.extrel(newPos);

            obj.Board{newPos(1), newPos(2)} = piece;
            obj.Board{oldPos(1), oldPos(2)} = 0;
        end

        % Helper method for swapping pieces. Same notes apply as movePiece.
        % @requires oldPos/newPos have pieces
        function pswap(obj, posA, posB)
            pieceA = obj.extrel(posA);
            pieceB = obj.extrel(posB);

            obj.Board{posA(1), posA(2)} = pieceB;
            obj.Board{posB(1), posB(2)} = pieceA;
        end

        % Remove piece from board.
        % @requires pos has piece
        function piece = prem(obj, pos)
            piece = obj.extrel(pos);
            
            obj.Board{pos(1), pos(2)} = 0;
        end

        % Overwrite piece (can be empty).
        function ow = pow(obj, pos, piece)
            ow = obj.extrel(pos);

            obj.Board{pos(1), pos(2)} = piece;
        end

        % Reports if player's king is in check.
        function result = ischeck(obj, player)
            result = 0;
        end
    end
end