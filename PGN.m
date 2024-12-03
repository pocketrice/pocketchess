classdef PGN < handle
    properties (Constant)
        isoToIocMap = containers.Map(...
    {'AF', 'AL', 'DZ', 'AS', 'AD', 'AO', 'AI', 'AG', 'AR', 'AM', 'AW', 'AU', 'AT', 'AZ', 'BS', 'BH', 'BD', 'BB', 'BY', 'BE', ...
     'BZ', 'BJ', 'BM', 'BT', 'BO', 'BA', 'BW', 'BR', 'BN', 'BG', 'BF', 'BI', 'KH', 'CM', 'CA', 'CV', 'KY', 'CF', 'TD', 'CL', ...
     'CN', 'CO', 'KM', 'CG', 'CD', 'CR', 'HR', 'CU', 'CY', 'CZ', 'DK', 'DJ', 'DM', 'DO', 'EC', 'EG', 'SV', 'GQ', 'ER', 'EE', ...
     'SZ', 'ET', 'FJ', 'FI', 'FR', 'GA', 'GM', 'GE', 'DE', 'GH', 'GR', 'GD', 'GU', 'GT', 'GN', 'GW', 'GY', 'HT', 'HN', 'HU', ...
     'IS', 'IN', 'ID', 'IR', 'IQ', 'IE', 'IL', 'IT', 'JM', 'JP', 'JO', 'KZ', 'KE', 'KI', 'KP', 'KR', 'KW', 'KG', 'LA', 'LV', ...
     'LB', 'LS', 'LR', 'LY', 'LI', 'LT', 'LU', 'MG', 'MW', 'MY', 'MV', 'ML', 'MT', 'MH', 'MR', 'MU', 'MX', 'FM', 'MD', 'MC', ...
     'MN', 'ME', 'MA', 'MZ', 'MM', 'NA', 'NR', 'NP', 'NL', 'NZ', 'NI', 'NE', 'NG', 'MK', 'NO', 'OM', 'PK', 'PW', 'PA', 'PG', ...
     'PY', 'PE', 'PH', 'PL', 'PT', 'PR', 'QA', 'RO', 'RU', 'RW', 'KN', 'LC', 'VC', 'WS', 'SM', 'ST', 'SA', 'SN', 'RS', 'SC', ...
     'SL', 'SG', 'SK', 'SI', 'SB', 'SO', 'ZA', 'SS', 'ES', 'LK', 'SD', 'SR', 'SE', 'CH', 'SY', 'TW', 'TJ', 'TZ', 'TH', 'TL', ...
     'TG', 'TO', 'TT', 'TN', 'TR', 'TM', 'UG', 'UA', 'AE', 'GB', 'US', 'UY', 'UZ', 'VU', 'VA', 'VE', 'VN', 'YE', 'ZM', 'ZW'}, ...
    {'AFG', 'ALB', 'ALG', 'ASA', 'AND', 'ANG', 'AIA', 'ANT', 'ARG', 'ARM', 'ARU', 'AUS', 'AUT', 'AZE', 'BAH', 'BRN', 'BAN', ...
     'BAR', 'BLR', 'BEL', 'BIZ', 'BEN', 'BER', 'BHU', 'BOL', 'BIH', 'BOT', 'BRA', 'BRU', 'BUL', 'BUR', 'BDI', 'CAM', 'CMR', ...
     'CAN', 'CPV', 'CAY', 'CTA', 'CHA', 'CHI', 'CHN', 'COL', 'COM', 'CGO', 'COD', 'CRC', 'CRO', 'CUB', 'CYP', 'CZE', 'DEN', ...
     'DJI', 'DMA', 'DOM', 'ECU', 'EGY', 'ESA', 'GEQ', 'ERI', 'EST', 'SWZ', 'ETH', 'FIJ', 'FIN', 'FRA', 'GAB', 'GAM', 'GEO', ...
     'GER', 'GHA', 'GRE', 'GRN', 'GUM', 'GUA', 'GUI', 'GBS', 'GUY', 'HAI', 'HON', 'HUN', 'ISL', 'IND', 'INA', 'IRI', 'IRQ', ...
     'IRL', 'ISR', 'ITA', 'JAM', 'JPN', 'JOR', 'KAZ', 'KEN', 'KIR', 'PRK', 'KOR', 'KUW', 'KGZ', 'LAO', 'LAT', 'LIB', 'LES', ...
     'LBR', 'LBA', 'LIE', 'LTU', 'LUX', 'MAD', 'MAW', 'MAS', 'MDV', 'MLI', 'MLT', 'MHL', 'MTN', 'MRI', 'MEX', 'FSM', 'MDA', ...
     'MON', 'MGL', 'MNE', 'MAR', 'MOZ', 'MYA', 'NAM', 'NRU', 'NEP', 'NED', 'NZL', 'NCA', 'NIG', 'NGA', 'MKD', 'NOR', 'OMA', ...
     'PAK', 'PLW', 'PAN', 'PNG', 'PAR', 'PER', 'PHI', 'POL', 'POR', 'PUR', 'QAT', 'ROU', 'RUS', 'RWA', 'SKN', 'LCA', 'VIN', ...
     'SAM', 'SMR', 'STP', 'KSA', 'SEN', 'SRB', 'SEY', 'SLE', 'SIN', 'SVK', 'SLO', 'SOL', 'SOM', 'RSA', 'SSD', 'ESP', 'SRI', ...
     'SUD', 'SUR', 'SWE', 'SUI', 'SYR', 'TPE', 'TJK', 'TAN', 'THA', 'TLS', 'TOG', 'TGA', 'TTO', 'TUN', 'TUR', 'TKM', 'UGA', ...
     'UKR', 'UAE', 'GBR', 'USA', 'URU', 'UZB', 'VAN', 'VAT', 'VEN', 'VIE', 'YEM', 'ZAM', 'ZIM'});
    end

    properties
        % ChessBoard obj
        Board

        % Game movetext
        MoveText

        % Seven Tag Roster (required)
        TagEvent
        TagSite
        TagDate
        TagRound
        TagWhite
        TagBlack
        TagResult
        
        % Optional tags
        TagAnnotator
        TagTime
        TagMode
        TagFEN
    end

    methods
        function obj = PGN(cb)
            obj.Board = cb;
            obj.MoveText = Buffer(40);

            obj.TagEvent = 'pcg ' + string(java.util.UUID.randomUUID);
            obj.TagSite = '?';
            obj.TagDate = '??.??.??';
            obj.TagRound = 1;
            obj.TagWhite = 'White';
            obj.TagBlack = 'Black';
            obj.TagResult = [0, 0];

            obj.TagAnnotator = '@pocketrice';
            obj.TagTime = '00:00:00';
            obj.TagMode = 'OTB';
            obj.TagFEN = cb.fen();
        end

        % "Sample populate"
        % Populates with a clever reference for use as sample data.
        % Remember, no crying until the end...
        function spopu(obj)
            obj.TagEvent = 'K/D Return Match';
            obj.TagSite = 'Yado Inn, Tazmily, NWI';
            obj.TagDate = '2004.12.08';
            obj.TagRound = 29;
            obj.TagWhite = 'Kumatora';
            obj.TagBlack = 'Duster';
            obj.TagResult = [1, 0];

            obj.TagAnnotator = 'Annette Luyu';
            obj.TagTime = '14:22:32';
        end

        % "Auto populate"
        % Populates as many automatic fields as possible. Note this
        % requests current time and location.
        function apopu(obj)
            % Fill site tag
            try
                locData = webread("https://www.ipinfo.io/json");

                locCity = string(locData.city);
                locRegion = string(locData.region);
                locISO = locData.country;
                
                
                if isKey(PGN.isoToIocMap, locISO)
                    locIOC = PGN.isoToIocMap(locISO);
                else
                    locIOC = 'Unknown';
                end

            catch
                disp("Geolocation timed out, ignoring.");
                locCity = "??";
                locRegion = "??";
                locIOC = "??";
            end

            obj.TagSite = locCity + ', ' + locRegion + ', ' + locIOC;
            
            % Fill date and time tag
            now = datetime('now');
            
            now.Format = 'yyyy.MM.dd';
            obj.TagDate = string(now);

            now.Format = 'HH:mm:ss';
            obj.TagTime = string(now);
        end

        % "Set name for player"
        % Self-explanatory. Player is 1 or 2.
        function setname(obj, name, player)
            switch player
                case 1
                    obj.TagWhite = name;
                case 2
                    obj.TagBlack = name;
                otherwise
                    error("PGN setname player must be 1 or 2!");
            end
        end

        % "Set annotator"
        function setannot(obj, name)
            obj.TagAnnotator = name;
        end

        % "Set round"
        function setround(obj, round)
            if ~isnumeric(round) || floor(round) ~= round
                error("PGN round must be an integer!");
            end

            obj.TagRound = round;
        end

        % "Set event"
        function setevent(obj, event)
            obj.TagEvent = event;
        end

        % "Skip in movetext"
        % Manually add a skip (--) to the movetext.
        function smt(obj, comm, nag)
            switch nargin
                case 1
                    obj.amt([0,0], [0,0]);
                case 2
                    obj.amt([0,0], [0,0], 0, comm);
                case 3
                    obj.amt([0,0], [0,0], 0, comm, nag);
            end
        end
        % "Add to movetext"
        % Adds the move to the movetext, updating other tags as needed
        % (e.g. result if checkmate). For syncing purposes, the PGN's board
        % should not be modified in any way and instead you may assume the
        % move HAS been done.
        %
        % You may add a NAG (just #) or comment if desired. Note
        % parameter spacing; pass in '' for no comm.
        %
        %
        % Assume movetext order is intact (don't handle player order and
        % such).
        %
        % Unlike other PGN generators, this is rather explicit (e.g. Ngf3
        % instead of Nf3). This is OK! Parsers still A-OK!! :D
        %
        function amt(obj, oldpos, newpos, cap, comm, nag)
            % If turn skipped, short-circuit.
            if psame(oldpos, newpos)
                move = "--";
            else
                move = "";

                % Move data + checkstate
                % (you may assume oldpos has a piece)
                mpiece = obj.Board.get(newpos);
                mplayer = mpiece.Player;
                oplayer = circ(mplayer + 1, 1, 2);
                mtype = mpiece.Type;
                chst = obj.Board.Checks;

                % Notations for old/new positions, moved piece
                an_new = PGN.algnot(newpos);
                an_old = PGN.algnot(oldpos);
                msan = sanMapper(mpiece);

                % Begin figuring out notation...
                % ====== CASTLE ======
                if mtype == PieceType.King && ~has(mpiece.Enigmas, EnigmaType.Panick) && psame(abs(newpos - oldpos), [0,2])
                    % Determine which side via seeing closer to which #.
                    % You can safely assume no ambiguity (e.g. no middle,
                    % hopefully).
                    bsize = size(obj.Board.Board);
                    blenmid = bsize / 2;

                    % Queenside
                    if newpos(2) < blenmid
                        move = "O-O-O";
                        % Kingside
                    else
                        move = "O-O";
                    end

                    % ======= STANDARD MOVE =======
                else
                    % Add SAN mapping and (explicit) start file
                    move = move + msan + chat(an_old, 1);

                    % Add capture marker (if)
                    if ~iseabs(cap)
                        move = move + 'x';
                    end

                    % Add end space
                    move = move + an_new;

                    % Add check marker (if)
                    switch chst(oplayer)
                        case 1
                            move = move + '+';
                        case 2
                            move = move + '#';
                    end
                end

                % Update result flag if checkmate. TODO: draws
                if chst(oplayer) == 2
                    obj.TagResult(mplayer) = obj.TagResult(mplayer) + 1;
                end
            end

            % Compile move cellarr
            mcell = nspace("", 3);

            mcell(1) = move;

            if nargin >= 5 && strlength(comm) ~= 0
                mcell(2) = "{" + comm + "}";
            end

            if nargin >= 6
                mcell(3) = "$" + nag;
            end

            % Add to buffer
            obj.MoveText.a(mcell);
        end

        % "Update promo"
        % This should be called immediately after actually promoting a
        % piece to update the movetext buffer placeholder.
        % function updpromo(obj, type)
        % end

        % "Compile"
        % Compiles to a valid PGN string. Assumes moves are properly formatted
        % (W,B,W,B...)
        function str = compile(obj)
            % Add tags
            str = sprintf(['[SetUp "1"]\n'...
                           '[FEN "%s"]\n' ...
                           '[Event "%s"]\n' ...
                           '[Site "%s"]\n' ...
                           '[Date "%s"]\n' ...
                           '[Time "%s"]\n' ...
                           '[Round "%i"]\n' ...
                           '[White "%s"]\n' ...
                           '[Black "%s"]\n' ...
                           '[Result "%s-%s"]\n' ...
                           '[Mode "OTB"]\n' ...
                           '[Annotator "%s"]\n\n'], obj.TagFEN, obj.TagEvent, obj.TagSite, obj.TagDate, obj.TagTime, obj.TagRound, obj.TagWhite, obj.TagBlack, dec2frac(obj.TagResult(1)), dec2frac(obj.TagResult(2)), obj.TagAnnotator);

            
            movetext = obj.MoveText.flush();

            % Evenify length (+1 if odd)
            if isodd(length(movetext))
                mtlen = length(movetext) + 1;
            else
                mtlen = length(movetext);
            end
            
            % Add each turn
            for i = 1:2:mtlen
                mtstr = string(ceil(i/2)) + '.';

                % Add white move
                mtstr = mtstr + mat2raw(movetext{i}, ' ') + ' ';

                % Add black move (if present)
                if i + 1 <= length(movetext)
                    mtstr = mtstr + mat2raw(movetext{i+1}, ' ') + ' ';
                end

                str = str + mtstr;
            end 

            % Trim extra spaces
            str = trimspace(str);
        end
    end

    methods (Static)
        % "Algebraic notation"
        % Gets the algnot for the provided space. Takes into account 
        % non-8 dimensions, though it may be invalid for PGN parsers!
        %
        % Parameter pre is [r,c] in MATLAB format and post is [a-z][0-8].
        %
        % You may alternatively pass in just algnot(pre) to assume 8 rows
        % (8x8). We don't need dimX as it is a-h not h-a!
        function post = algnot(pre, dimY)
            if nargin < 2
                dimY = 8;
            end

            post = char(96 + pre(2)) + string(dimY + 1 - pre(1));
        end

        % "Move to NAG"
        % Converts a move to NAG based on mscore. Other heuristics can be
        % used later if needed. Ignores enigspaces. Should be called BEFORE
        % moving.
        %
        % NAGs are of course subjective and this kind of goes against that
        % very idea, but I digress... :>
        %
        % This uses only the Nunn Convention NAGs ($1-$6).
        %
        function nag = move2nag(board, oldpos, newpos, isskip7)
            if nargin < 4
                isskip7 = false;
            end

            mscore = board.mscore(oldpos, newpos, [0,0]);
            mplayer = board.get(oldpos).Player;

            if ~isskip7 && isscalar(board.rpmoves(mplayer))
                nag = 7;
            elseif mscore > 40 % (40, ∞) !!
                nag = 3;
            elseif mscore > 25 % (25, 40] !
                nag = 1;
            elseif mscore > 0 % (0, 25] !?
                nag = 5;
            elseif mscore > -10 % (-10, 0] ?!
                nag = 6;
            elseif mscore > -20 % (-20, -10] ?
                nag = 2;
            else % (-∞, -20] ??
                nag = 4;
            end
        end

    end
end
                

            




