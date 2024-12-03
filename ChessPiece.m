classdef ChessPiece < handle
    properties
        Type % Must be PieceType
        Player % Must be 1 or 2
        Enigmas % Must be [EnigmaType, EnigmaType...]
    
        FlagPure % Must be boolean; only used for if the piece hasn't moved yet — this actually neatly takes care of King castling and Pawn 2-hop.
        FlagTemp % Must be boolean; only used for "just occurred flags" — all piece's flag2 are reset at the END of the entire turn (both black and white have moved)
    end

    methods
        function obj = ChessPiece(Type, Player)
            obj.Type = Type;
            obj.Player = Player;
            obj.Enigmas = [];
            obj.FlagPure = 1;
            obj.FlagTemp = 0;
        end

        % "Copy"
        % Makes a copy of this object (just type and player).
        function piece = cpy(obj)
            piece = ChessPiece(obj.Type, obj.Player);
        end

        % "Full copy"
        % Makes a full copy of this object (all attributes).
        function piece = fcpy(obj)
            piece = obj.cpy();
            piece.Enigmas = obj.Enigmas;
            piece.FlagPure = obj.FlagPure;
            piece.FlagTemp = obj.FlagTemp;
        end

        % "Get rank"
        % Gets the relative rank of this piece including +/- for player.
        function r = rank(obj)
            r = 0;

            switch obj.Type
                case PieceType.Pawn
                    r = 1;
                case PieceType.Knight
                    r = 2;
                case PieceType.Bishop
                    r = 3;
                case PieceType.Rook
                    r = 4;
                case PieceType.Queen
                    r = 5;
                case PieceType.King
                    r = 6;
            end

            % Flip polarity if black
            if obj.Player == 2
                r = -r;
            end
        end

        % "Can add that enigma?"
        % Checks if you can still add that enigma to this piece.
        function result = cane(obj, enigmatype)
            % If invalid enigma type, shortcircuit.
            if ~has(EnigmaType.types(obj.Type), enigmatype)
                result = 0;
            else
                if isempty(obj.Enigmas)
                    result = 1;
                else
                    % Decompile enigmas.
                    edecomp = vdecomp(obj.Enigmas);
                    
                    % Decomp index for enigma type.
                    eind = has(exti(edecomp, 1), enigmatype);

                    if enigmatype.Max == -1
                        result = ~has(obj.Enigmas, enigmatype);
                    elseif eind ~= 0
                        % Compare counts and set result whether over max or not
                        epair = edecomp{eind};
                        result = epair{2} < enigmatype.Max;
                    else
                        result = 1;
                    end
                end
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

        % Add enigma
        % Throws error if invalid enigma added.
        function egadd(obj, enigma)
            if ~obj.cane(enigma)
                error("Enigma %s cannot be added to a %s!", string(enigma), string(obj.Type));
            end

            obj.Enigmas = [ obj.Enigmas, enigma ];
        end

        % Remove enigma
        % Returns nothing if no enigmas/that enigma not present.
        function eg = egrem(obj, enigma)
            eind = has(obj.Enigmas, enigma);
            if ~eind
                fprintf("Warning: a %s piece (enigmas %s) could not remove %s; returning empty.", string(obj.Type), mat2str(obj.Enigmas), string(enigma));
                eg = [];
            else
                eg = obj.Enigmas(eind);
                obj.Enigmas(eind) = [];
            end
        end

       
        % Equals method
        function result = eq(obj, other)
            result = obj.Type == other.Type && obj.Player == other.Player;
        end

        % "Full" equals method
        function result = feq(obj, other)
            result = obj.Type == other.Type && obj.Player == other.Player && obj.FlagTemp == other.FlagTemp && obj.FlagPure == other.FlagPure && length(obj.Enigmas) == length(other.Enigmas) && all(obj.Enigmas == other.Enigmas);
        end
    end
end

