% This is pchess but with all SFX and enigmas removed.

% Instantiate game scene.
game_scene = betterGameEngine('retro_chess.png', 16, 16, 4, [67, 55, 65]);

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
pturn = 1;
pturnmoves = 1;

% Keyboard controls.
kbrel = [4,4];
kfcurr = [0,0];

% Chessboard and chessbot
cb = ChessBoard();
bot = ChessBot(cb);


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
        key = getKeyboardInput(game_scene);
        dir = Direction.NA;
        switch key
            case 'escape'
                if kbframe
                    kbframe = 0;
                end
            case 'return'
                pturn = ~pturn;
                pturnmoves = 1;
        
            case 'space'
                % If piece placing down AND piece player was black, location not valid, or no turns left OR piece picking up but space empty block.
                if ~(kbframe && (~has(kfvmoves, kbrel) || kfplayer == 2 || pturnmoves == 0) || (cb.iserel(applykb(kbrel, dir))))
                
                % Otherwise... (piece picked up is valid or placed on valid
                % location with turns remaining)
                    % Switch kb selector sprite
                    kbframe = ~kbframe;

                    % Check if JUST placed/picked up.
                    if kbframe
                        kfcurr = applykb(kbrel, dir);
                        kfplayer = cb.get(kfcurr).Player;
                    else
                        % Decrement turn moves.
                        pturnmoves = pturnmoves - 1;

                        % Move piece and play sound; decrement turn moves
                        cb.pmove(kfcurr, kbrel);
                    end
                end

            case 'leftarrow'
                dir = Direction.Right;
            case 'uparrow'
                dir = Direction.Down;
            case 'rightarrow'
                dir = Direction.Left;
            case 'downarrow'
                dir = Direction.Up;
        end
    
  % Black's turn
  else 
       while pturnmoves > 0
           [oldb, newb] = bot.nextmove();

           % Move piece, play sfx
           pause(1.2);
          
           cb.pmove(oldb, newb);
         
           pturnmoves = pturnmoves - 1;
       end

       % Toggle turn and reset moves
       pturnmoves = 1;
       pturn = ~pturn;
  end

% Update layer2 board
layer2 = mow(layer2, cb.correspond(@pieceMapper), [3,1]);

% Clear layer3 and layer4
layer3(:) = na;
layer4(:) = na;

% Apply changes if selected (piece hologram, vmoves)
if kbframe
    kfvmoves = cb.vmoves(kfcurr);

    for vmove = kfvmoves
        layer3 = mow(layer3, moveValid(1), vmove{1} + [2,0]);
    end
end

% Place cursor and overwrite.
kbrel = applykb(kbrel, dir);
kbspr = moveReg(kbframe + 1);
kboff = rel2abs(kbrel, [2,0], 2);

layer3 = mow(layer3, kbspr, kboff);


% Update display.
drawScene(game_scene, layer1, layer2, layer3, layer4);

% Check kings for game state.
kq = cb.kquery();

if iseabs(kq{2}) || iseabs(kq{1})
    break;
end
end
 