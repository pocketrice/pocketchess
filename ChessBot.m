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

            % If checked (not checkmate — this is a precondition), short-circuit and pick move that resolves
            % check.
            if cb.Checks(2)
                % Get all resolving moves
                rmoves = cb.rpmoves(2);

                % Get random resolving move
                rmove = unwrap(randget(rmoves));

                oldpos = rmove{1};
                newpos = rmove{2};
            else
                global BlackPawn BlackKnight BlackBishop BlackQueen BlackRook BlackKing;


                piecetv = [ BlackPawn, BlackKnight, BlackBishop, BlackQueen, BlackRook, BlackKing ];


                % Get PDF based on game phase.
                % [ pawn, knight, bishop, queen, rook, king ]
                if obj.Turns < 2
                    piecepv = [ 0.8, 0.11, 0.03, 0.03, 0.03 ];
                elseif obj.Turns < 8
                    piecepv = [ 0.2, 0.3, 0.2, 0.1, 0.1, 0.1 ];
                else
                    piecepv = [ 0.1, 0.1, 0.3, 0.3, 0.1, 0.1 ];
                end

                % Roll which piece to use or use consuming move if present; if no qvp for that piece, try the
                % next piece type with highest probability. If none, then throw
                % error.

                isfound = 0;

                % If any moves that get to enigma, prioritize.
                iscane = 0;
                
                % If any checking moves, prioritize. Remove non-resolving
                % (puts in check) moves.
                chmoves = cb.frpmoves(cb.chpmoves(2), 2);

                % If any consuming moves, prioritize. Same as above.
                cmoves = cb.frpmoves(cb.cpmoves(2), 2);

               
                if ~isempty(enigspace)
                    % Get all valid moves for player.
                    vpmoves = cb.frpmoves(cb.vpmoves(2), 2);

                    % Get index (if exists) of second end coord if
                    % at enigspace. If non-zero, then iscane!
                    iscane = has(exti(vpmoves, 2), enigspace);
                end
                    
                % todo!!! :> some way to sort each bracket's moves based on
                % priority (consume enigma pieces, consume/check with
                % cheapest pieces).
                
                % ***** PRIORITY MOVES *****
                % Reaches enigma?
                if iscane
                    vpair = vpmoves{iscane};
                    oldpos = vpair{1};
                    newpos = vpair{2};
                % Checks opponent?
                elseif ~isempty(unwrap(chmoves)) && ~randp(3) % 2/3 chance
                    chmove = chmoves{1};
                    oldpos = chmove{1};
                    newpos = chmove{2};
                % Consumes opponent piece?
                elseif ~isempty(unwrap(cmoves)) && ~randp(4) % 3/4 chance
                    cmove = cmoves{1};
                    oldpos = cmove{1};
                    newpos = cmove{2};
                
                % ***** REGULAR MOVES *****
                else
                    while ~isfound
                        % If no choices, throw error.
                        if isempty(piecetv)
                            error("There were no possible moves for opponent!");
                        end

                        disp("FINDING");
                        % Piece choice index (e.g. 3)
                        pc_ind = vrandp(piecepv);

                        % Piece choice type (e.g. BlackPawn)
                        pc_type = piecetv(pc_ind);

                        % Piece type query (e.g. {[2,1], [2,2]...}). 
                        pc_query = cb.pquery(pc_type);

                        % Valid-move pieces for that type
                        pc_vpieces = cb.qvp(pc_query);


                        % If has valid move, pick a random one
                        if ~isempty(pc_vpieces)
                            % Keep looping until you find a dang piece with a delectable resolving
                            % move
                            isresolving = 0;

                            while ~isresolving
                                disp("RESOLVING");
                                % Get pair of piece and pos, then extract pos.
                                oldpos = pc_query{randget(pc_vpieces)};
                                oldpos = oldpos{2};

                                isresolving = ~isempty(unwrap(cb.rmoves(oldpos)));
                            end

                            % If contains enigspace, go for it! Otherwise,
                            % pick a random vmove.
                            vmoves = cb.vmoves(oldpos);

                            if has(vmoves, enigspace)
                                newpos = enigspace;
                            else
                                newpos = randget(cb.frmoves(oldpos, cb.vmoves(oldpos)));
                            end
                           
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




