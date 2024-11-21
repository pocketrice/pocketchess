
cb=ChessBoard;
global WhitePawn WhiteRook WhiteKnight WhiteBishop WhiteQueen WhiteKing BlackPawn BlackRook BlackKnight BlackBishop BlackQueen BlackKing;


board=cb.Board;

%create a function to check if the king is in check. if yes, there are only
%a max of 8 other spots that the king can move. this function needs to be
%called for the whole game to check each spot after every move to see if 
% the king is in check
%set is_checked equal to false because the king is not in check right now,
%but then create a loop for if is_checked is true.


%set losses and wins equal to 0
% the next part will check for if the black king piece is missing (equal to 0)
% because when the king is in check it will just disappear. then, giving
% options for what the player wants to do next
win = 0;
loss = 0;
if isempty(cb.pquery(BlackKing)) == 0
        msgbox('\nYou lose!')
        loss=loss+1;
        msgbox('Do you want to a)play again, b)see stats, c) reset stats or d)quit?')
        choice= input('a,b,c,d-','s');
        switch choice
            case 'a'
                %reset the chessboard
                cb=ChessBoard;
            case 'b'
                msgbox('Wins-%d\n',win,'Losses-%d\n,',loss)
                pause(5)
                close(msgbox)
            case 'c'
                win=0;
                loss=0;
            case 'd'
                msgbox('Thanks for playing!')
                pause(5)
                close(msgbox)
        end
elseif isempty(cb.pquery(WhiteKing))
    msgbox('\nYou win!')
    win=win+1;
    msgbox('Do you want to a)play again, b)see stats, c) reset stats or d)quit?')
    choice= input('a,b,c,d-','s');
        switch choice
            case 'a'
                %reset the chessboard
                cb=ChessBoard;
            case 'b'
                msgbox('Wins-%d\n',win,'Losses-%d\n,',loss)
                pause(5)
                close(msgbox)
            case 'c'
                win=0;
                loss=0;
            case 'd'
                msgbox('Thanks for playing!')
                pause(5)
                close(msgbox)
        end
end