classdef ChessPiece
    properties
        Type % Must be PieceType
        Player % Must be 1 or 2
        %Enigmas % Must be <EnigmaType, EnigmaType...>
        Flag1 % Must be boolean; only used for King for castling (has castled?) and Pawn for 2-hop (has done 2-hop?)
        %Flag2 % Must be boolean; only used by opposing Pawn for en passant (has this pawn just 2-hopped?)
    end

    methods
        function obj = ChessPiece(Type, Player)
            obj.Type = Type;
            obj.Player = Player;
            obj.Flag1 = false;
            %obj.Flag2 = false;
        end

        % TODO: If using Flag2 you can somehow guarantee conditions using just 1
        % flag for each scenario, so you can use other flag as "triggered
        % once?" flag
        function obj = triggerFlag(obj)
            if (~obj.Flag1) 
                obj.Flag1 = true;
            end
        end


    end
end

