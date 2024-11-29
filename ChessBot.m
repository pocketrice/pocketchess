classdef ChessBot < handle
    properties
        Board % ChessBoard
        Tensile % double [0-1]
        Turns % int16 [0-n]
        IsVerbose % boolean
    end

    methods
        function obj = ChessBot(Board, Tensile, IsVerbose)
            obj.Board = Board;
            obj.Tensile = Tensile;
            obj.Turns = 1;
            
            switch nargin
                case 1
                    obj.Tensile = 0.5;
                    obj.IsVerbose = false;
                case 2
                    obj.Tensile = Tensile;
                    obj.IsVerbose = false;
                case 3
                    obj.Tensile = Tensile;
                    obj.IsVerbose = IsVerbose;
            end
        end

        % Do not call this if the bot is checkmated.
        function [oldpos, newpos] = nextmove(obj, enigspace)
            cb = obj.Board;

            % Get all resolving moves
            rmoves = cb.rpmoves(2);
          
            % Sort moves by mscore (h -> l)
            [~, minds] = insort(cellfun(@(m) cb.mscore(unwrap(m(1), 1), unwrap(m(2), 1), enigspace), rmoves));

            % Get entropic index (and item)
            erange = clamp(ceil(obj.Tensile * 3 * (1 - cb.bscore / 25)), 1, 3);
            eimove = unwrap(rmoves(minds(randi(erange))), 1);
            [oldpos, newpos] = eimove{:};

            % Increment turn count
            obj.Turns = obj.Turns + 1;
        end
    end
end




