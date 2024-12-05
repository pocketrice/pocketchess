classdef PieceType
    properties
        Rank
    end

    enumeration
        Pawn(1)
        Knight(2)
        Bishop(3)
        Rook(4)
        Queen(5)
        King(6)
    end

    methods
        function obj = PieceType(rank)
            obj.Rank = rank;
        end
    end
end
