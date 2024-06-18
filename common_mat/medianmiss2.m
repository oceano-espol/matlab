function z = medianmiss2(xx)
%function z = medianmiss2(xx)
% MEDIANMISS Returns as a row vector the medians of the columns
% of X where missing values are coded as nans. Performs the same
% function that MEDIAN provides for matrices w/o missing data. 

[m,n]=size(xx);z=zeros(1,n);
for k=1:n
  jj=find(finite(xx(:,k))==1);
  if jj>0
  	z(k)=median(xx(jj,k));
  else
  	z(k)=nan;
  end
end 