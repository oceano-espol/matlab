function m = meanmiss(x)
%function m = meanmiss(x)
% MEANMISS Column matrix means with missing data.
%
% MEANMISS(X) returns the means of the columns of X 
% as a row vector, where missing data in X are encoded as NaN's.
% Returns the same result as MEAN if there are no NaNs in X.

notvalid = isnan(x);
x(notvalid) = zeros(size(x(notvalid)));
m = sum(x)./sum(1-notvalid); 