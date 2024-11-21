% "Vector to random probability"
% Uses a vector representing PDF (must add up to 1) and gets an index according to CDF.
function ind = vrandp(pdf)
  % Due to floating point imprecision, you don't need this check
  % if sum(pdf) ~= 1
  %   error('CDF must equal 1!');
  % end

  % Calculate CDF
  cdf = zeros(1,length(pdf));

  for i = 1:length(pdf)
    cdf(i) = sum(pdf(1:i));
  end

  % Generate random probability and get all that match; get first match.
  p = rand();
  pmatches = find(cdf > p);
  ind = pmatches(1);
end
  
