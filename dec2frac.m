% "Decimal to fraction"
% What it says on da tin.
function frac = dec2frac(dec)
  % Is negative? 
  isneg = (dec < 0);

  % Is fractional? (0-1)
  isfrac = dec ~= 0 && (abs(dec) < 1);

  % Get fractional representation and append negative if needed.
  if isfrac 
   
    frac = "1/" + string(abs(round(1 / dec)));
    
    if isneg
      frac = '-' + frac;
    end

  else
    frac = string(dec);
  end
end
