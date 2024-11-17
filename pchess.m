% *************************** NOTE ******************************* 
% retro_chess.png is a custom spritesheet and must be imported.
% ****************************************************************

% Instantiate game scene.
game_scene = betterGameEngine('retro_chess.png', 16, 16, 4, [67, 55, 65]);

% Cache sound effects.
sfx_move = game_scene.cachesound("audio/scroll.wav");
sfx_sel = game_scene.cachesound("audio/selected.wav");
sfx_sup = game_scene.cachesound("audio/dollop.wav");
sfx_sdown = game_scene.cachesound("audio/cancel.wav");
sfx_done = game_scene.cachesound("audio/new_evidence.wav");
sfx_err = game_scene.cachesound("audio/card.wav");

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

% [ frame1, frame2 ]
enigmaSpace = [32, 33]; 
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
moveEnigma = [ 54, 53 ];

% [ dvi1, dvi2 ]
dviEx = [ 91, 92 ];




% Get vector representing empty row.
na_row = nspace(na, 18);

% ====================== SCENE 1 ========================
% Keyboard controls.
kbrel = [4,4];
kbframe = 0;
kfcurr = [0,0];

% Chessboard
cb = ChessBoard();

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

% Draw display.
drawScene(game_scene, layer1, layer2, layer3);

while 1
    key = getKeyboardInput(game_scene);
dir = Direction.NA;
switch key
    case 'escape'
        if kbframe
            game_scene.sound(sfx_sdown);
            kbframe = 0;
        end
    case 'return'
        game_scene.sound(sfx_done);
    case 'space'
        if (kbframe && ~has(kfvmoves, kbrel)) || (~kbframe && cb.iserel(applykb(kbrel, dir)))
            game_scene.sound(sfx_err);
        else
            kbframe = ~kbframe;

            % Check if JUST selected
            if kbframe
                game_scene.sound(sfx_sup);
                kfcurr = applykb(kbrel, dir);
            else
                game_scene.sound(sfx_sdown);
                cb.pmove(kfcurr, kbrel);
            end
        end

    case 'leftarrow'
        game_scene.sound(sfx_move);
        dir = Direction.Left;
    case 'uparrow'
        game_scene.sound(sfx_move);
        dir = Direction.Down;
    case 'rightarrow'
        game_scene.sound(sfx_move);
        dir = Direction.Right;
    case 'downarrow'
        game_scene.sound(sfx_move);
        dir = Direction.Up;
end

% Update layer2 board
layer2 = mow(layer2, cb.correspond(@pieceMapper), [3,1]);

% Clear layer3
layer3(:) = na;

% Apply changes if selected (piece hologram, vmoves)
if kbframe
    kfvmoves = cb.vmoves(kfcurr);
    for move = kfvmoves
        layer3 = mow(layer3, moveEnigma(1), move{1} + [2,0]);
    end
end

% Place cursor and overwrite.
kbrel = applykb(kbrel, dir);
kbspr = moveReg(kbframe + 1);
kboff = rel2abs(kbrel, [2,0], 2);

layer3 = mow(layer3, kbspr, kboff);

% Update display.
drawScene(game_scene, layer1, layer2, layer3);
end
 