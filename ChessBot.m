classdef ChessBot < handle
    properties
        Board
        Turns
        IsVerbose
    end

    methods
        function obj = ChessBot(Board, IsVerbose)
            obj.Board = Board;
            obj.Turns = 1;
            
            if nargin > 1
                obj.IsVerbose = IsVerbose;
            else
                obj.IsVerbose = false;
            end
        end

        % Do not call this if the bot is checkmated.
        function [oldpos, newpos] = nextmove(obj, enigspace)
            cb = obj.Board;

            % Get all resolving moves
            rmoves = cb.rpmoves(2);
          
            % Sort moves by mscore (h -> l)
            [~, minds] = insort(cellfun(@(m) cb.mscore(m(1), m(2), enigspace), rmoves));

            % Get entropic index (and item)
            [oldpos, newpos] = rmoves(minds(ceil(3 * (1 - cb.bscore / 400))));

            % Increment turn count
            obj.Turns = obj.Turns + 1;
        end
    end
end




