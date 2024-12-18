% *************************** NOTE *******************************
% retro_chess.png is a custom spritesheet and must be imported.
% ****************************************************************
% Clear memory.
clearvars -global
clearvars variables
clear

global BlackBishop BlackPawn BlackKnight;


% Instantiate game scene.
game_scene = betterGameEngine('retro_chess.png', 16, 16, 4, [67, 55, 65], false);

% Cache sound effects.
sfx_move = game_scene.cachesound("audio/scrolle.wav");
sfx_movehor = game_scene.cachesound("audio/cur_hor.wav");
sfx_movever = game_scene.cachesound("audio/cur_ver.wav");
sfx_sel = game_scene.cachesound("audio/selected.wav");
sfx_sup = game_scene.cachesound("audio/dollop.wav");
sfx_sdown = game_scene.cachesound("audio/cancel.wav");
sfx_scan = game_scene.cachesound("audio/stomp.wav");
sfx_done = game_scene.cachesound("audio/new_evidence.wav");
sfx_err = game_scene.cachesound("audio/card.wav");
sfx_bloc = game_scene.cachesound("audio/bloc.wav");
sfx_gameover = game_scene.cachesound("audio/gameover.wav");
sfx_win = game_scene.cachesound("audio/clear.wav");
sfx_cap = game_scene.cachesound("audio/diceroll.mp3");
sfx_enighit = game_scene.cachesound("audio/feather.wav");
sfx_enigadd = game_scene.cachesound("audio/1up.wav");
sfx_enigapp = game_scene.cachesound("audio/coin.wav");
sfx_chup = game_scene.cachesound("audio/switch_act.wav");
sfx_chd = game_scene.cachesound("audio/switch_end.wav");
sfx_bomp = game_scene.cachesound("audio/bomp.wav");
sfx_debug = game_scene.cachesound("audio/present.wav");
sfx_blip = game_scene.cachesound("audio/m3_blip.flac");

% Get icon indices.
% ==================== PANES ========================
na = 100;
stdStatusIcon = 25;
stdPaneTop = [ 27, 38, 38, 38, 38, 38, 28 ];
stdPaneMid = [ 36, 30, 30, 30, 30, 30, 37 ];
stdPaneBtm = [ 26, 39, 39, 39, 39, 39, 29 ];

effStatusIcon = 65;
effPaneTop = stdPaneTop + 30;
effPaneMid = stdPaneMid + 30;
effPaneBtm = stdPaneBtm + 30;

inputPaneTop = stdPaneTop + 50;
inputPaneMid = stdPaneMid + 50;
inputPaneBtm = stdPaneBtm + 50;

% ==================== ENIGMA ========================
% [ off, on ]
enigmaHUD = [ 52, 31 ];

% [ frame1, frame3, frame2, frame3 ]
enigmaSpace = [32, 84, 33, 90];
enigmaMark = 55;

% ===================== CARDS ========================
cardHUD = 35;
cardNum = 41:50;
cbSelBlack = 83;
cbSelWhite = 84;
effPaneClock = 62;

% [ 1, 2 ]
effPaneNum = [ 63, 64 ];

cbA = [ 21, 22, 21, 22, 21, 22, 21, 22 ];
cbB = [ 22, 21, 22, 21, 22, 21, 22, 21 ];

% ===================== MISC ========================
% Starts from top and goes clockwise
dirArrows = [ 9, 8, 7, 18, 17, 20, 19, 10 ];
ranks = 71:75;

% [ no, data ]
noData = [ 81, 82 ];
textNeg = 61;
textPos = 51;

% [ reg, active ]
cursorOpen = [ 24, 23 ];
cursorClosed = [ 99, 98 ];
moveValid = [ 54, 53 ];
moveEnigma = [ 95, 94 ];
moveCheck = [ 97, 96 ];

cursorDebug = [ 61, 51 ];
markerDebugA = 34;
markerDebugB = 93;

% [ dvi1, dvi2 ]
dviEx = [ 91, 92 ];




% Get vector representing empty row.
na_row = nspace(na, 18);

% ====================== SCENE 1 ========================
% Game state trackers.
kbframe = 0;
debugframe = 0;
enigframe = 1;
pturn = 0;
pturnmoves = 1;
eturn = 0;
moverem = 1;
isforfeit = 0;

% Debug marker.
debugFrom = [];
debugTo = [];

% Magnesis tracker and position of magnetised piece (rook)
ismagnesis = 0;
magpos = [0,0];

% Keyboard controls.
kbrel = [4,4];
kfcurr = [0,0];

% Chessboard, chessbot, PGN
cb = ChessBoard(BoardPreset.PromoTest);
bot = ChessBot(cb, 0.1);
pgn = PGN(cb);
pgn.apopu();


% Create enigma spot and set enigma count
enigspace = randget(cb.aquery());
enigspace = enigspace{2};

enigcount = 0;


% Fill each row of layer 1.
row1 = [ nspace(na, 15), enigmaHUD(1), enigmaHUD(1), enigmaHUD(1) ];
row2 = na_row;
row3 = na_row;
row4 = [ na, cbA, na, inputPaneTop, na ];
row5 = [ na, cbB, na, inputPaneMid, na ];
row6 = [ na, cbA, na, inputPaneMid, na ];
row7 = row5;
row8 = row6;
row9 = row5;
row10 = row6;
row11 = [ na, cbB, na, inputPaneBtm, na ];
row12 = na_row;

% Compile layer 1.
layer1 = [ row1; row2; row3; row4; row5; row6; row7; row8; row9; row10; row11; row12 ];

% =====================

% Create layer 2.
layer2 = repmat(na, 12, 18);

% Manual overwrites for layer 2.
row7 = [ nspace(na, 12), noData, nspace(na, 4) ];


% Compile manual layer 2.
layer2 = mow(layer2, row7, [6,0]);

% Auto overwrites for layer 2.
layer2 = mow(layer2, cb.correspond(@repMapper), [3,1]);

% =====================

% Create layer 3.
layer3 = repmat(na, 12, 18);

% =====================

% Create layer4.
layer4 = repmat(na, 12, 18);

% %%%%%%%%%%%%%%%%%%%%%

% Draw display.
drawScene(game_scene, layer1, layer2, layer3);

% %%%%%%%%%%%%%%%%%%%%%

while 1
    % Update current player (1,2)
    pplayer = pturn + 1;

    % White's turn (0)
    if ~pturn
        % Change enigma animation frame
        enigframe = circ(enigframe + 1, 1, 4);

        % Get keyboard input
        key = getKeyboardInput(game_scene);

        % Clear keyboard direction
        dir = Direction.NA;

        switch key
            case 'hyphen'
                if ~isforfeit
                    disp("Really forfeit? (press again if so)...");
                    isforfeit = 1;
                else
                    cb.Checks = [2, 0];
                    pgn.smt("White forfeit");
                end
            case 'backspace'
                debugframe = ~debugframe;
                game_scene.sound(sfx_debug);
            case 'escape'
                if kbframe
                    if kfplayer == 2
                        game_scene.sound(sfx_chd);
                    else
                        game_scene.sound(sfx_scan);
                    end
                    kbframe = 0;
                end

                if debugframe
                    game_scene.sound(sfx_scan);
                    debugFrom = [];
                    debugTo = [];
                end
            case 'tab'
                % Bloc if kfcurr wasn't updated (empty).
                if ~cb.iserel(kfcurr)
                    eroll = EnigmaType.roll(cb.get(kfcurr));

                    if kbframe && enigcount > 0 && ~isempty(eroll)
                        game_scene.sound(sfx_enigapp);
                        cb.get(kfcurr).egadd(eroll);
                        enigcount = enigcount - 1;
                    else
                        game_scene.sound(sfx_bloc);
                    end
                else
                    game_scene.sound(sfx_bloc);
                end
            case 'return'
                game_scene.sound(sfx_done);
                pturn = ~pturn;
                pturnmoves = 1;
                eturn = eturn + 1;
                
                % Manually skip turn in PGN if move still remaining (didn't
                % move)
                if moverem
                    pgn.smt();
                end

                % Reset moverem.
                moverem = 1;

                % If still selected after turn ended, unselect.
                if kbframe
                    kbframe = 0;
                end
            case 'space'
                if debugframe
                    if isempty(debugFrom)
                        debugFrom = applykb(kbrel, dir);
                        game_scene.sound(sfx_blip);
                    elseif isempty(debugTo)
                        debugTo = applykb(kbrel, dir);
                        game_scene.sound(sfx_blip);
                    else
                        game_scene.sound(sfx_bloc);
                    end
                else
                    % If piece was picked up AND piece player was black or
                    % wasn't magnesis and no turns left OR is magnesis and not mag piece, block.
                    if kbframe && (kfplayer == 2 || (~ismagnesis && pturnmoves <= 0) || (ismagnesis && ~all(kfcurr == magpos)))
                        game_scene.sound(sfx_bomp);
                        % If piece was (a) picked up but location is not valid (enigma
                        % or reg) OR (b) wasn't picked up and location empty — in other words not selecting a piece to pick up
                        % then block.
                    elseif (kbframe && ~has(kfvmoves, kbrel) && ~has(kfevmoves, kbrel)) || (~kbframe && cb.iserel(applykb(kbrel, dir)))
                        game_scene.sound(sfx_err);
                        % Otherwise... (piece picked up is valid or placed on valid
                        % location with turns remaining or magnesis and rook picked up)
                    else
                        % Switch kb selector sprite
                        kbframe = ~kbframe;

                        % Check if JUST placed/picked up.
                        if kbframe
                            kfcurr = applykb(kbrel, dir);
                            kfplayer = cb.get(kfcurr).Player;

                            if kfplayer == 1
                                game_scene.sound(sfx_sup);
                            else
                                game_scene.sound(sfx_chup);
                            end
                        else
                            % Decrement turn moves.
                            pturnmoves = pturnmoves - 1;

                            % If no turn moves left, notify.
                            if pturnmoves == 0
                                moverem = 0;
                            end

                            % Move piece and play sound; decrement turn moves
                            if ~iseabs(cb.pgnmove(kfcurr, kbrel, pgn))
                                game_scene.sound(sfx_cap);
                            else
                                game_scene.sound(sfx_sdown);

                                % If rook with Magnesis and did not capture,
                                % set magnesis flag!
                                if cb.get(kbrel).Type == PieceType.Rook && has(cb.get(kbrel).Enigmas, EnigmaType.Magnesis)
                                    ismagnesis = 1;
                                    magpos = kbrel;
                                end
                            end

                            % If magnesis already used (pturnmoves less than
                            % 0), disable magnesis.
                            if pturnmoves < 0
                                ismagnesis = 0;
                            end

                            % Add enigma if moved to enigma
                            if (~isempty(enigspace) && all(kbrel == enigspace))
                                enigspace = [];

                                % Net enigma gained
                                enignet = 2 - enigcount;

                                % Fill enigma
                                enigcount = 2;


                                game_scene.sound(sfx_enighit);
                                pause(1.5)

                                while enignet > 0
                                    game_scene.sound(sfx_enigadd);
                                    pause(0.8);
                                    enignet = enignet - 1;
                                end
                            end
                        end
                    end
                end

            case 'leftarrow'
                game_scene.sound(sfx_movehor);
                dir = Direction.Right;
            case 'uparrow'
                game_scene.sound(sfx_movever);
                dir = Direction.Down;
            case 'rightarrow'
                game_scene.sound(sfx_movehor);
                dir = Direction.Left;
            case 'downarrow'
                game_scene.sound(sfx_movever);
                dir = Direction.Up;
        end

        % Black's turn (1)
    else
        while pturnmoves > 0
            if cb.Checks(2) ~= 2
                % We can guarantee = 1 is FROM set and not TO set.
                switch isempty(debugFrom) + isempty(debugTo)
                    case 2
                        [oldb, newb] = bot.nextmove(enigspace);
                    case 1
                        % TODO: use mscore?
                    case 0
                        if has(cb.vmoves(debugFrom, 1), debugTo)
                            oldb = debugFrom;
                            newb = debugTo;
                        else
                            [oldb, newb] = bot.nextmove(enigspace);
                        end

                        debugFrom = [];
                        debugTo = [];
                end

                % If moved to enigma, "add enigma" (plays sounds, but bot
                % just immediately applies them to random pieces).
                % Add enigma if moved to enigma
                if psame(newb, enigspace)

                    % "Add enigma"
                    enigspace = [];

                    game_scene.sound(sfx_enighit);
                    pause(1.5);

                    % Apply 2 enigma. Only does so to bishops, pawns, knights
                    % for now.

                    for i = 1:2
                        % Omnipool of pieces to randomly pick one to apply
                        % enigma for. They all can receive some enigmatype.
                        opool = [ cb.pquery(BlackBishop), cb.pquery(BlackPawn), cb.pquery(BlackKnight) ];

                        for j = length(opool):-1:1
                            % { piece, [x,y] }
                            oentry = opool{j};

                            % If not canae (not any enigma we can add),
                            % remove.
                            if isempty(oentry{1}.canae())
                                opool(j) = [];
                            end
                        end
                        
                        % Pick a random piece from omnipool to add enigma to
                        % (and roll random valid enigma); if no eligible
                        % then skip.
                        if ~isempty(opool)
                            opiece = randget(opool);
                            oenigma = randget(opiece{1}.canae());

                            % Add enigma.
                            game_scene.sound(sfx_enigapp);
                            pause(0.8);
                            cb.get(opiece{2}).egadd(oenigma);
                        end
                    end
                end

                % Draw selector to screen, move piece, play sfx
                pause(0.2);
                layer2 = mow(layer2, moveEnigma(2), newb + [2,0]);
                if ~iseabs(cb.pgnmove(oldb, newb, pgn))
                    game_scene.sound(sfx_cap);
                else
                    game_scene.sound(sfx_sdown);
                end
            end

            pturnmoves = pturnmoves - 1;
        end

        % **** END OF CYCLE ****
        % Toggle turn, increment enigma turns, reset turn moves.
        pturnmoves = 1;
        pturn = ~pturn;
        eturn = eturn + 1;
    end


    % Update layer1 HUD
    layer1 = mow(layer1, pfill(enigcount, 3, enigmaHUD(2), enigmaHUD(1)), [0,15]);

    % Update layer2 board
    layer2 = mow(layer2, cb.correspond(@repMapper), [3,1]);

    % Create enigma if needed
    if isempty(enigspace) && eturn > 6 && randp(4)
        enigspace = randget(cb.aquery());
        enigspace = enigspace{2};
        eturn = 0;
    end

    % Draw layer2 enigma space if existent.
    if ~isempty(enigspace)
        layer2 = mow(layer2, enigmaSpace(enigframe), enigspace + [2,0]);
    end

    % Clear layer3 and layer4
    layer3(:) = na;
    layer4(:) = na;

    % Apply changes if selected (piece hologram, vmoves)
    if kbframe
        % Restrict if checked. We can't have this in vmoves because
        % checkcheck() relies on cmoves() which relies on vmoves() which would
        % then use checkcheck...

        kfvmoves = cb.rmoves(kfcurr);
        kfevmoves = cb.removes(kfcurr);

        if cb.Checks(pplayer)
            sprValid = moveCheck(1);
            sprEnigma = moveCheck(1);
        else
            sprValid = moveValid(1);
            sprEnigma = moveEnigma(1);
        end


        if ~isempty(unwrap(kfvmoves, 1))
            for vmove = kfvmoves
                layer3 = mow(layer3, sprValid, vmove{1} + [2,0]);
            end
        end

        if ~isempty(unwrap(kfevmoves, 1))
            for evmove = kfevmoves
                layer3 = mow(layer3, sprEnigma, evmove{1} + [2,0]);
            end
        end
    end

    % Place appropriate cursor and overwrite.
    kbrel = applykb(kbrel, dir);
    kboff = rel2abs(kbrel, [2,0], 2);
    if debugframe
        kbspr = cursorDebug(circ((~isempty(debugTo) && ~isempty(debugFrom)) + 2, 1, 2));
    elseif moverem
        kbspr = cursorOpen(kbframe + 1);
    else
        kbspr = cursorClosed(kbframe + 1);
    end

    layer3 = mow(layer3, kbspr, kboff);


    % Overwrite layer 4 with enigma marks.
    eqs = [ exti(cb.equery(1), 2), exti(cb.equery(2), 2) ];

    if ~isempty(eqs)
        for i = 1:length(eqs)
            layer4 = mow(layer4, enigmaMark, eqs{i} + [2,0]);
        end
    end

    % Overwrite layer 4 again with dmove marks and clear.
    if ~isempty(debugFrom)
        layer4 = mow(layer4, markerDebugA, debugFrom + [2,0]);
        if ~isempty(debugTo)
            layer4 = mow(layer4, markerDebugB, debugTo + [2,0]);
        end
    end

    

    % Update display.
    drawScene(game_scene, layer1, layer2, layer3, layer4);

    if any(cb.Checks == 2)
        if cb.Checks(2) == 2 % Black checkmated
            game_scene.sound(sfx_win);
            pwinner = "White";
        else % White checkmated
            game_scene.sound(sfx_gameover);
            pwinner = "Black";
        end

        pgn_fpath = input('\n' + pwinner + " wins! Save PGN to... ", 's');

        if ~isblank(pgn_fpath)
            pgn_fid = fopen(pgn_fpath, 'w');

            pgn_wname = input("White player's name... ", 's');
            pgn_bname = input("Black player's name... ", 's');
            pgn_event = input("Event... ", 's');
        
            if ~isblank(pgn_wname)
                pgn.setname(pgn_wname, 1);
            end

            if ~isblank(pgn_bname)
                pgn.setname(pgn_bname, 2);
            end

            if ~isblank(pgn_event)
                pgn.setevent(pgn_event);
            end

            fprintf(pgn_fid, "%s", pgn.compile());
            fclose(pgn_fid);

            fprintf("\n\n. ݁₊ ⊹ . ݁˖ . ݁ Thanks for playing! PGN written to %s. ⟡ ݁₊ .\n", pgn_fpath);
        else
            fprintf("\n\n. ݁₊ ⊹ . ݁˖ . ݁ Thanks for playing! PGN paste below ↴ ⟡ ݁₊ .\n\n%s\n", pgn.compile());
        end

        break;
    end
end
