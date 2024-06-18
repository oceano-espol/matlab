function xy = covmiss(x,y)
%function xy = covmiss(x,y)
% COVMISS -- Covariance matrix for arrays with missing data.
%
% COVMISS(X), if X is a vector, returns the variance. For matrices,
% where each row is an observation, and each column a variable,
% COVMISS(X) is the covariance matrix.  DIAG(COVMISS(X)) is a vector 
% of variances for each column, and SQRT(DIAG(COVMISS(X))) is a 
% vector of standard deviations. COVMISS(X,Y) is COVMISS([X Y]).  
%
% Missing data should be coded as NaN. NaNs are replaced with 
% zeros after determining the new degrees of freedom (Nij) for 
% each possible combination of non-missing data. The covariance 
% calculation is done in the normal way, but zeros do not 
% contribute and each element of the covariance matrix is 
% adjusted by a factor = (M-1)/(Nij-1), where M is the orig-
% inal length of all vectors in X & Y. The vectors are also
% demeaned using only non-missing values. 
%
% See also MEANMISS, STDMISS. 

% Revised from Mathworks version on 8-18-94 by D.Enfield
% New or altered statements are commented.
%
% 29/Nov/05 Edited for their use in MATLAB 6.5. 
%           Jonathan Cedeño, FIMCM-ESPOL.
%           jcedeno@espol.edu.ec

[m,n] = size(x);
if nargin > 1
    [my,ny] = size(y);
    if m ~= my | n ~= ny
        error('X and Y must be the same size.');
    end
    x = [x(:) y(:)];
elseif min(size(x)) == 1
    x = x(:);
end
[m, n] = size(x);
x=x-ones(m,1)*meanmiss(x);    % Remove means of non-missing data

% df = finite(x);               % Replace non-missing data with ones
df = isfinite(x);
df = double(df);              % Conversion of logical array to double array
n = df' * df;                 % Calculate matrix of Nij values
jbad=find(isnan(x));          % Find indices for missing values
x(jbad)=zeros(size(jbad));    % Replace NaNs with zeros

if m == 1
    xy = 0;
else
    xy = x' * x ./ (n-1);     % Calculate cov's with adjusted DFs
end 