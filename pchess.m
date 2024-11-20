% *************************** NOTE ******************************* 
% retro_chess.png is a custom spritesheet and must be imported.
% ****************************************************************

% Instantiate game scene.
game_scene = betterGameEngine('retro_chess.png', 16, 16, 4, [67, 55, 65]);

% Cache sound effects.
sfx_move = game_scene.cachesound("audio/scrolle.wav");
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
cardSpace = 34;
cbSelBlack = 83;
cbSelWhite = 84;
effPaneClock = 62;
effPaneWarn = 93;

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
moveReg = [ 24, 23 ];
moveValid = [ 54, 53 ];
moveEnigma = [ 95, 94 ];


% [ dvi1, dvi2 ]
dviEx = [ 91, 92 ];




% Get vector representing empty row.
na_row = nspace(na, 18);

% ====================== SCENE 1 ========================
% Game state trackers.
kbframe = 0;
enigframe = 1;
pturn = 1;
pturnmoves = 1;

% Magnesis tracker and position of magnetised piece (rook)
ismagnesis = 0;
magpos = [0,0];

% Keyboard controls.
kbrel = [4,4];
kfcurr = [0,0];

% Chessboard and chessbot
cb = ChessBoard();
bot = ChessBot(cb);

% Create enigma spot and set enigma count
enigspace = randget(cb.aquery());
enigspace = enigspace{2};

enigcount = 0;


% Fill each row of layer 1.
row1 = [ stdStatusIcon, na, stdPaneTop, na, na, na, cardHUD, cardNum(1), na, enigmaHUD(1), enigmaHUD(1), enigmaHUD(1) ];
row2 = [ na, na, stdPaneBtm, nspace(na, 9) ];
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
row1 = [ nspace(na, 3), textNeg, textNeg, textNeg, na, textNeg, nspace(na, 10)];
row7 = [ nspace(na, 12), noData, nspace(na, 4) ];
    

% Compile manual layer 2.
layer2 = mow(layer2, row1, [0,0]);
layer2 = mow(layer2, row7, [6,0]);

% Auto overwrites for layer 2.
layer2 = mow(layer2, cb.correspond(@pieceMapper), [3,1]);

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
% White's turn
if pturn
        enigframe = circ(enigframe + 1, 1, 4);
        key = getKeyboardInput(game_scene);
        dir = Direction.NA;
        switch key
            case 'escape'
                if kbframe
                    if kfplayer == 2
                        game_scene.sound(sfx_chd);
                    else
                        game_scene.sound(sfx_scan);
                    end
                    kbframe = 0;
                end
            case 'tab'
                eroll = EnigmaType.roll(cb.get(kfcurr));

                if kbframe && enigcount > 0 && ~isempty(eroll)
                    game_scene.sound(sfx_enigapp);
                    cb.eniga(kfcurr, eroll);
                    enigcount = enigcount - 1;
                else
                    game_scene.sound(sfx_bloc);
                end
            case 'return'
                game_scene.sound(sfx_done);
                pturn = ~pturn;
                pturnmoves = 1;
        
            case 'space'
                % If piece was picked up AND piece player was black or
                % wasn't magnesis and no turns left OR is magnesis and not mag piece, block.
                if kbframe && (kfplayer == 2 || (~ismagnesis && pturnmoves < 0) || (ismagnesis && ~all(kfcurr == magpos)))
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

                        % Move piece and play sound; decrement turn moves
                        if (~iseabs(cb.pmove(kfcurr, kbrel)))
                            game_scene.sound(sfx_cap);
                        else
                            game_scene.sound(sfx_sdown);

                            % If rook with Magnesis and did not capture,
                            % set magnesis flag!
                            if (cb.get(kbrel).Type == PieceType.Rook && ~isempty(cb.get(kbrel).Enigmas))
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
                            enignet = 3 - enigcount;

                            % Fill enigma
                            enigcount = 3;
                 

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

            case 'leftarrow'
                game_scene.sound(sfx_move);
                dir = Direction.Right;
            case 'uparrow'
                game_scene.sound(sfx_move);
                dir = Direction.Down;
            case 'rightarrow'
                game_scene.sound(sfx_move);
                dir = Direction.Left;
            case 'downarrow'
                game_scene.sound(sfx_move);
                dir = Direction.Up;
        end
    
  % Black's turn
  else 
       while pturnmoves > 0
           [oldb, newb] = bot.nextmove();

           % Draw selector to screen, move piece, play sfx
           pause(1.2);
           layer2 = mow(layer2, moveEnigma(2), newb + [2,0]);
           if ~iseabs(cb.pmove(oldb, newb))
               game_scene.sound(sfx_cap);
           else
               game_scene.sound(sfx_sdown);
           end

           pturnmoves = pturnmoves - 1;
       end

       % Toggle turn and reset moves
       pturnmoves = 1;
       pturn = ~pturn;
  end

% Update layer1 HUD
layer1 = mow(layer1, pfill(enigcount, 3, enigmaHUD(2), enigmaHUD(1)), [0,15]);

% Update layer2 board
layer2 = mow(layer2, cb.correspond(@pieceMapper), [3,1]);

% Create enigma if needed
if isempty(enigspace) && randp(10)
    enigspace = randget(cb.aquery());
    enigspace = enigspace{2};
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
    kfvmoves = cb.vmoves(kfcurr);
    kfevmoves = cb.evmoves(kfcurr);

    for vmove = kfvmoves
        layer3 = mow(layer3, moveValid(1), vmove{1} + [2,0]);
    end

    for evmove = kfevmoves
        layer3 = mow(layer3, moveEnigma(1), evmove{1} + [2,0]);
    end
end

% Place cursor and overwrite.
kbrel = applykb(kbrel, dir);
kbspr = moveReg(kbframe + 1);
kboff = rel2abs(kbrel, [2,0], 2);

layer3 = mow(layer3, kbspr, kboff);


% Overwrite layer 4 with enigma marks.
eqs = exti(cb.equery(), 2);

if ~isempty(eqs)
    for i = 1:length(eqs)
        layer4 = mow(layer4, enigmaMark, eqs{i} + [2,0]);
    end
end

% Update display.
drawScene(game_scene, layer1, layer2, layer3, layer4);

% Check kings for game state.
kq = cb.kquery();

if iseabs(kq{2})
    game_scene.sound(sfx_win);
    break;
elseif iseabs(kq{1})
    game_scene.sound(sfx_gameover);
    break;
end
end
 