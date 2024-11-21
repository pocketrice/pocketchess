classdef EnigmaType
    properties
        Max; % # of uses; if -1 then permanent
    end

    enumeration
        Gimble(-1), Bubble(-1), Warp(-1),
        Backtrot(-1), Cornercutter(2), Sidewind(2),
        Magnesis(3), Wall(-1),
        Iridesce(-1), Protractor(4),
        Telepathy(-1), Purify(-1), Missile(3),
        Chakra(1), Dharma(1),
        Panick(3), Skjold(-1)
    end
    methods
        function obj = EnigmaType(Max)
            obj.Max = Max;
        end
    end

    methods (Static=true)
        function pen = types(ptype)
            % The following code will be crucial when several enigmas
            % present for each (not just pawn).
            switch ptype
                case PieceType.Pawn
                    pen = [EnigmaType.Backtrot, EnigmaType.Sidewind];
                case PieceType.Knight
                    pen = EnigmaType.Protractor;
                case PieceType.Bishop
                    pen = EnigmaType.Missile;
                case PieceType.Rook
                    pen = EnigmaType.Magnesis;
                case PieceType.King
                    pen = EnigmaType.Panick;
                case PieceType.Queen
                    pen = EnigmaType.Chakra;
            end
        end

        function e = roll(piece)
            ptype = piece.Type;
            
            % Create filter 'pfilt' (based on maxes from "enigmas decomp" edecomp).
            edecomp = vdecomp(piece.Enigmas);

            for i = 1:length(edecomp)
                % Extract cell
                edi = edecomp{i};

                % If not permanent (-1) and not at max, remove from filter
                if edi{2} ~= -1 && edi{2} < edi{1}.Max
                    edecomp{i} = 0;
                end
            end

            % Compose after filtering out all filter removals — this now is
            % items that shouldn't be added
            pfilt = vcomp(vfilt(edecomp, 0));
                    
            % Get all possible enigmas
            pen = EnigmaType.types(ptype);

            % Randomly pick from filtered-out potential enigmas (filter is
            % items that cannot be picked anymore)
            e = randget(vfilt(pen, pfilt));
        end
    end
end