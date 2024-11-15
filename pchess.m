% ************************************************
% *  Name:  Lucas Xie   Date:  11/07/2024        *
% *  Seat:  64          File:  SDP_grprev.m      *
% *  Instructor:  Kecskemety 9:10                *
% ************************************************

fprintf ('\n')
fprintf ('\n************************************************')
fprintf ('\n*  Name:  Lucas Xie   Date:  11/07/2024        *')
fprintf ('\n*  Seat:  64    File:  SDP_grprev.m            *')
fprintf ('\n*  Instructor:  Kecskemety 9:10                *')                       
fprintf ('\n************************************************')
fprintf ('\n')

% *************************** NOTE ******************************* 
% retro_chess.png is a custom spritesheet and must be imported.
% ****************************************************************

% Instantiate game scene.
game_scene = simpleGameEngine('retro_chess.png', 16, 16, 4, [67, 55, 65]);

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


% ===================== PIECES ========================
cpWhiteRook = 5;
cpWhiteBshp = 4;
cpWhiteKngt = 6;
cpWhiteQueen = 3;
cpWhiteKing = 2;
cpWhitePawn = 1;
cpStdWhite1 = [ 5, 4, 6, 3, 2, 6, 4, 5 ];
cpStdWhite2 = ones(1, 8);

cpBlackRook = 15;
cpBlackBshp = 14;
cpBlackKngt = 16;
cpBlackQueen = 13;
cpBlackKing = 12;
cpBlackPawn = 11;
cpStdBlack1 = cpStdWhite1 + 10;
cpStdBlack2 = cpStdWhite2 + 10;

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

% [ active, reg ]
moveReg = [ 23, 24 ];
moveEnigma = [ 53, 54 ];

% [ dvi1, dvi2 ]
dviEx = [ 91, 92 ];




% Get vector representing empty row.
na_row = nspace(18, na);

% ====================== SCENE 1 ========================
% Fill each row of layer 1.
row1 = [ stdStatusIcon, na, stdPaneTop, na, na, na, cardHUD, cardNum(1), na, enigmaHUD(1), enigmaHUD(1), enigmaHUD(1) ];
row2 = [ na, na, stdPaneBtm, nspace(9, na) ];
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

% Overwrite rows for layer 2.
row1 = [ nspace(3, na), textNeg, textNeg, textNeg, na, textNeg, nspace(10, na)];
row4 = [ na, cpStdBlack1, nspace(9, na) ];
row5 = [ na, cpStdBlack2, nspace(9, na) ];
row7 = [ nspace(12, na), noData, nspace(4, na) ];
row10 = [ na, cpStdWhite2, nspace(9, na) ];
row11 = [ na, cpStdWhite1, nspace(9, na) ];

% Compile layer 2.
layer2 = [ row1; row2; row3; row4; row5; row6; row7; row8; row9; row10; row11; row12 ];

% Draw scene 1 to display.
drawScene(game_scene, layer1, layer2);

% Display scene 1 note.
xlabel('Depicted is the initial game layout; note the initial values of the chess board and auxiliary elements. (SPACE TO ADVANCE 1/3)');

% Await user input of SPACE to advance to next scene.
fprintf('Press SPACE to advance to next scene.');

while (~strcmp(getKeyboardInput(game_scene), 'space'))
end

% ====================== SCENE 2 ========================
% Fill each row of layer 1.
row1 = [ stdStatusIcon, na, stdPaneTop, na, na, na, cardHUD, cardNum(1), na, enigmaHUD(1), enigmaHUD(1), enigmaHUD(1) ];
row2 = [ na, na, stdPaneBtm, nspace(9, na) ];
row3 = na_row;
row4 = [ na, cbA, na, inputPaneTop, na ];
row5 = [ na, cbB, na, inputPaneMid, na ];
row6 = [ na, cbA, na, inputPaneMid, na ];
row7 = row5;
row8 = [ na, cbA(1:3), cbSelWhite, cbA(5:8), na, inputPaneMid, na ];
row9 = row5;
row10 = row6;
row11 = [ na, cbB, na, inputPaneBtm, na ];
row12 = na_row;

% Compile layer 1.
layer1 = [ row1; row2; row3; row4; row5; row6; row7; row8; row9; row10; row11; row12 ];

% Overwrite rows for layer 2.
row1 = [ nspace(3, na), textNeg, textNeg, na, na, textNeg, nspace(10, na) ];
row4 = [ na, na, cpBlackKngt, na, cpBlackKing, cpBlackKngt, na, cpBlackRook, nspace(3, na), textPos, textPos, textPos, textPos, nspace(3, na) ];
row5 = [ na, cpBlackPawn, na, cpBlackPawn, cpBlackPawn, na, na, cpBlackPawn, nspace(4, na), dviEx, nspace(4, na) ];
row6 = [ na, na, cpBlackBshp, na, na, cpBlackPawn, cardSpace, na, cpBlackQueen, na, ranks(1), na, textPos, textPos, nspace(4, na) ];
row7 = [ na, na, cardSpace, nspace(3, na), enigmaSpace(1), nspace(3, na), ranks(2), na, textPos, textPos, nspace(4, na) ];
row8 = [ nspace(4, na), cpWhiteKngt, nspace(5, na), ranks(3), na, textPos, nspace(5, na) ];
row9 = [ nspace(3, na), cpWhitePawn, nspace(6, na), ranks(4), na, textPos, textPos, nspace(4, na) ];
row10 = [ na, cpWhitePawn, nspace(4, na), cpWhitePawn, na, cpWhitePawn, na, ranks(5), na, textPos, textPos, nspace(4, na) ];
row11 = [ na, na, cpWhiteBshp, nspace(4, na), cpWhiteBshp, cpWhiteKing, nspace(3, na), cardHUD, cardNum(2), enigmaHUD(2), cardNum(3), na, na ];

% Compile layer 2.
layer2 = [ row1; row2; row3; row4; row5; row6; row7; row8; row9; row10; row11; row12 ];

% Draw scene 2 to display.
drawScene(game_scene, layer1, layer2);

% Display scene 2 note.
xlabel('Depicted is a typical midgame layout emphasising user input pane and how the question workflow works. (SPACE TO ADVANCE 2/3)');

% Await user input of SPACE to advance to next scene.
fprintf('Press SPACE to advance to next scene.');

while (~strcmp(getKeyboardInput(game_scene), 'space'))
end


% ====================== SCENE 3 ========================
% Fill each row of layer 1.
row1 = [ effStatusIcon, na, effPaneTop, na, na, na, cardHUD, cardNum(4), na, enigmaHUD(2), enigmaHUD(2), enigmaHUD(1) ];
row2 = [ na, na, effPaneBtm, nspace(9, na) ];
row3 = na_row;
row4 = [ nspace(10, na), inputPaneTop, na ];
row5 = [ nspace(10, na), inputPaneMid, na ];
row6 = [ nspace(3, na), cbB(1:4), nspace(3, na), inputPaneMid, na ];
row7 = [ nspace(3, na), cbA(1), cpBlackKngt, cbA(3:4), nspace(3, na), inputPaneMid, na ];
row8 = [ nspace(3, na), cbB(1:2), cpWhitePawn, cbB(4), nspace(3, na), inputPaneMid, na ];
row9 = [ nspace(3, na), cbA(1:4), nspace(3, na), inputPaneMid, na ];
row10 = row5;
row11 = [ nspace(10, na), inputPaneBtm, na ];
row12 = na_row;

% Compile layer 1.
layer1 = [ row1; row2; row3; row4; row5; row6; row7; row8; row9; row10; row11; row12 ];

% Overwrite rows for layer 2.
row1 = [ nspace(3, na), effPaneWarn, textNeg, textNeg, textNeg, na, nspace(10, na) ];
row2 = [ nspace(6, na), effPaneClock, effPaneNum(2), nspace(10, na) ];
row6 = [ nspace(3, na), cpBlackKing, na, moveEnigma(2), nspace(12, na) ];
row7 = [ nspace(3, na), cpBlackBshp, moveReg(1), moveReg(2), nspace(6, na), noData, nspace(4, na) ];
row8 = [ nspace(5, na), enigmaMark, nspace(12, na) ];
row9 = [ nspace(3, na), cpWhitePawn, na, cpWhiteKing, nspace(12, na) ];


% Compile layer 2.
layer2 = [ row1; row2; row3; row4; row5; row6; row7; row8; row9; row10; row11; row12 ];

% Draw scene 3 to display.
drawScene(game_scene, layer1, layer2);

% Display scene 3 note.
xlabel('Depicted is the effect of a Card [8x8 → 4x4 board] and Enigma [pawn can en-passant any time] + status pane changes. (3/3)');





% ================================ EVALUATE ===========================
%
% Regarding this task, a particularly challenging part was designing the
% rules of the game itself; we had only had the concept of meshing
% engineering problem-solving with chess and had not worked through the
% logistics. Intuitive UI design and working with the two-layer limitation
% was also a significant hurdle but due to past experience analyzing how
% GB and GBA graphics are designed it went mostly well.
%
% For questions, I am wondering if there is any way to add a layer 3 (since
% the use of move overlays is not really possible without sacrificing the
% chessboard background itself) — though perhaps there might be some
% workaround by hardcoding sprites.
%
% There are not really many aspects of the current plan I foresee changing,
% apart from perhaps adding many of the ideas I came up with while drafting
% this graphics preview (see Game Rules in PDF).
%
% ========================================================================