function z=dewrap(x,m)
%function z=dewrap(x,m)
% Where <x> is M rows by N columns, unwraps successive m-row
% chunks of <x> into rows of length m*N in a new matrix <z) that
% is M/m rows by m*N columns. E.g., for Z=DEWRAP(X,2):
%
% X =  1  2  3  4  5   ==>   Z =  1  6  2  7  3  8  4  9  5 10
%      6  7  8  9 10             11 16 12 17 13 18 14 19 15 20
%     11 12 13 14 15            
%     16 17 18 19 20      Clearly, M must be a multil=ple of m.
%
% For unspecified m, m=M. If X does not reshape to a complete
% marix, the missing values at the end are padded out with NaNs.
%
% Uses RESHAPE. See also WRAP.

[nr,nc]=size(x);n=nr/m;
if nargin<2;m=nr;
end
inc=m*(ceil(nr/m)-nr/m);
x=[x' nan*ones(nc,inc)]';
[nr,nc]=size(x);n=nr/m;
z=zeros(n,nc*m);
for j=1:n
  j1=(j-1)*m+1;j2=j*m;
  z(j,:)=reshape(x(j1:j2,:),1,nc*m);
end 