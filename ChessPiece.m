classdef ChessPiece
    properties
        Type % Must be PieceType
        Player % Must be 1 or 2
        Enigmas % Must be [EnigmaType, EnigmaType...]
        Flag1 % Must be boolean; only used for King for castling (has castled?) and Pawn for 2-hop (has done 2-hop?)
        %Flag2 % Must be boolean; only used by opposing Pawn for en passant (has this pawn just 2-hopped?)
    end

    methods
        function obj = ChessPiece(Type, Player)
            obj.Type = Type;
            obj.Player = Player;
            obj.Enigmas = [];
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

        % "Can add that enigma?"
        % Checks if you can still add that enigma to this piece.
        function result = cane(obj, enigmatype)
            % If no enigmas, then assume yes.
            if isempty(obj.Enigmas)
                result = 1;
            else
                % Decompile enigmas.
                edecomp = vdecomp(obj.Enigmas);

                % Compare counts and set result whether over max or not.
                epair = unwrap(avfilt(edecomp, enigmatype));
                result = (epair{2} < enigmatype.Max);
            end
        end

        % "Can add any enigmas?"
        % Checks if you can still add ANY enigmas to this piece.
        % "pes" = potential enigmas.
        function [pes] = canae(obj)
            % Decompose into counts for each item for filter (to remove)
            edecomp = vdecomp(obj.Enigmas);

            % Get all possible enigmas.
            pen = EnigmaType.types(obj.Type);

            for i = length(edecomp):-1:1
                % Extract cell
                edi = edecomp{i};

                % If is not permanent (-1) and not at max, remove from edecomp
                % filter.
                if edi{2} ~= -1 && edi{2} < edi{1}.Max
                    edecomp(i) = [];
                end
            end

            % Check if any potential enigmas remain. We only need the first
            % column as counts are irrelevant, and remove these.
            pes = vfilt(pen, exti(edecomp, 1));
        end
        

        % Equals method
        function result = eq(obj, other)
            result = obj.Type == other.Type && obj.Player == other.Player;
        end

        % "Full" equals method
        function result = feq(obj, other)
            result = obj.Type == other.Type && obj.Player == other.Player && obj.Flag1 == other.Flag2 && length(obj.Enigmas) == length(other.Enigmas) && all(obj.Enigmas == other.Enigmas);
        end
    end
end

