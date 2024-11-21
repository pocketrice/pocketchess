classdef ChessBot < handle
    properties
        Board
        Turns
    end

    methods
        function obj = ChessBot(Board)
            obj.Board = Board;
            obj.Turns = 1;
        end

        % Do not call this if the bot is checkmated.
        function [oldpos, newpos] = nextmove(obj, ischecked)
            cb = obj.Board;

            % If checked (not checkmate — this is a precondition), short-circuit and pick move that resolves
            % check.
            if ischecked
                % Get all resolving moves
                rmoves = cb.rpmoves(2);

                % Get random resolving move
                rmove = randget(rmoves);

                oldpos = rmove{1};
                newpos = rmove{2};
            else
                global BlackPawn BlackKnight BlackBishop BlackQueen BlackRook BlackKing;


                piecetv = [ BlackPawn, BlackKnight, BlackBishop, BlackQueen, BlackRook, BlackKing ];


                % Get PDF based on game phase.
                % [ pawn, knight, bishop, queen, rook, king ]
                if obj.Turns < 2
                    piecepv = [ 0.8, 0.2, 0, 0, 0, 0 ];
                elseif obj.Turns < 8
                    piecepv = [ 0.2, 0.3, 0.2, 0.1, 0.1, 0.1 ];
                else
                    piecepv = [ 0.1, 0.1, 0.3, 0.3, 0.1, 0.1 ];
                end

                % Roll which piece to use or use consuming move if present; if no qvp for that piece, try the
                % next piece type with highest probability. If none, then throw
                % error.

                isfound = 0;

                % If any checking moves, prioritize.
                chmoves = cb.chpmoves(2);

                % If any consuming moves, prioritize.
                cmoves = cb.cpmoves(2);

                if ~isempty(unwrap(chmoves)) && ~randp(3) % 2/3 chance
                    chmove = chmoves{1};
                    oldpos = chmove{1};
                    newpos = chmove{2};
                elseif ~isempty(unwrap(cmoves)) && ~randp(4) % 3/4 chance
                    cmove = cmoves{1};
                    oldpos = cmove{1};
                    newpos = cmove{2};
                else
                    while ~isfound
                        % If no choices, throw error.
                        if isempty(piecetv)
                            error("There were no possible moves for opponent!");
                        end

                        % Piece choice index (e.g. 3)
                        pc_ind = vrandp(piecepv);

                        % Piece choice type (e.g. BlackPawn)
                        pc_type = piecetv(pc_ind);

                        % Piece type query (e.g. {[2,1], [2,2]...})
                        pc_query = cb.pquery(pc_type);

                        % Valid-move pieces for that type
                        pc_vpieces = cb.qvp(pc_query);

                        % If has valid move, pick a random one
                        if ~isempty(pc_vpieces)
                            % Get pair of piece and pos, then extract pos.
                            oldpos = pc_query{randget(pc_vpieces)};
                            oldpos = oldpos{2};

                            newpos = randget(cb.vmoves(oldpos));

                            isfound = 1;

                            % Otherwise, remove that choice and spread removed probability evenly.
                        else
                            % Remove index from piece type and probability vectors
                            piecetv(pc_ind) = [];
                            piecepv(pc_ind) = [];

                            % Normalize PDF to 1 again
                            psum = sum(piecepv);
                            piecepv = arrayfun(@(p) p / psum, piecepv);
                        end
                    end
                end
            end
            % Increment turn count
            obj.Turns = obj.Turns + 1;
        end
    end
end




