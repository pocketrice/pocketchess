classdef BoardPreset
    enumeration
        Standard
        Chaos
        Duel
        CheckTest
    end

    methods (Static)
        function preset = apply(obj)
            global WhitePawn WhiteRook WhiteKnight WhiteBishop WhiteQueen WhiteKing BlackPawn BlackRook BlackKnight BlackBishop BlackQueen BlackKing;

            % This is defining the chess pieces we'll need to first set up
            % the board. You can see how to create a ChessPiece (just pass
            % it a PieceType and 1 for white or 2 for black).

            % HANDLE WITH CAUTION! Please only use these for equality checking! Use BoardPreset
            % and ChessBoard.bset instead of manually making a board
            % matrix with these handles!
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

            switch obj
                case BoardPreset.Standard
                    preset = { BlackRook, BlackKnight, BlackBishop, BlackQueen, BlackKing, BlackBishop, BlackKnight, BlackRook;
                        BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn;
                        0, 0, 0, 0, 0, 0, 0, 0;
                        0, 0, 0, 0, 0, 0, 0, 0;
                        0, 0, 0, 0, 0, 0, 0, 0;
                        0, 0, 0, 0, 0, 0, 0, 0;
                        WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn;
                        WhiteRook, WhiteKnight, WhiteBishop, WhiteQueen, WhiteKing, WhiteBishop, WhiteKnight, WhiteRook };
                
                case BoardPreset.Chaos
                    preset = { BlackRook, BlackKnight, BlackBishop, BlackRook, BlackKing, BlackBishop, BlackKnight, BlackRook;
                        BlackQueen, BlackQueen, BlackQueen, BlackQueen, BlackQueen, BlackQueen, BlackQueen, BlackQueen;
                        0, 0, 0, 0, 0, 0, 0, 0;
                        0, 0, 0, 0, 0, 0, 0, 0;
                        0, 0, 0, 0, 0, 0, 0, 0;
                        0, 0, 0, 0, 0, 0, 0, 0;
                        WhiteQueen, WhiteQueen, WhiteQueen, WhiteQueen, WhiteQueen, WhiteQueen, WhiteQueen, WhiteQueen;
                        WhiteRook, WhiteKnight, WhiteBishop, WhiteKing,  WhiteRook, WhiteBishop, WhiteKnight, WhiteRook };

                case BoardPreset.Duel
                    preset = { BlackRook, BlackKnight, BlackBishop, 0, BlackKing, BlackBishop, BlackKnight, BlackRook;
                        BlackKnight, 0, 0, BlackQueen, BlackQueen, 0, 0, BlackKnight;
                        0, 0, 0, 0, 0, 0, 0, 0;
                        BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn, BlackPawn;
                        WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn, WhitePawn;
                        0, 0, 0, 0, 0, 0, 0, 0;
                        WhiteKnight, 0, 0, WhiteQueen, WhiteQueen, 0, 0, WhiteKnight;
                        WhiteRook, WhiteKnight, WhiteBishop, WhiteKing, 0, WhiteBishop, WhiteKnight, WhiteRook };

                case BoardPreset.CheckTest
                    % Since this emulates end-game state, unflag both
                    % kings' castles.
                    bk_emu = BlackKing.cpy();
                    wk_emu = WhiteKing.cpy();
                    
                    bk_emu.FlagPure = 0;
                    wk_emu.FlagPure = 0;

                    preset = { 0, 0, 0, 0, 0, 0, 0, bk_emu;
                        WhiteRook, 0, 0, 0, 0, 0, 0, 0;
                        0, WhiteRook, 0, 0, 0, 0, 0, 0;
                        0, 0, 0, 0, 0, 0, 0, 0;
                        0, 0, 0, 0, 0, 0, 0, wk_emu;
                        0, 0, 0, 0, 0, 0, 0, 0
                        0, 0, 0, 0, 0, 0, 0, 0;
                        0, 0, 0, 0, 0, 0, 0, 0; };
            end
        end

    end
end