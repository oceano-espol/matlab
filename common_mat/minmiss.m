function mn = minmiss(x)
%function mn = minmiss(x)
% MINMISS Find the minimum of nonmissing data
% Works like MIN where missing data are coded == NaN.

for k = 1:length(x(1,:));
	jj = ~isnan(x(:,k));
	mn(k) = min(x(jj,k));
end 