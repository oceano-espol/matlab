function [lam,ev,vem,tc,sc]=eof_dbe(x,c,minpct)
%function [lam,ev,vem,tc,sc]=eof_dbe(x,c,minpct)
% Computation of empirical orthogonal functions (EOFs) or principal 
% component analysis (PCA). Data enter as array (X) of M variables 
% arranged as columns of N times (cases). VEM & E are output as M  
% variables arranged as columns of P modes or components, where 
% M-P = number of variabes removed. 
%
% Treatment of data: Removes the data means and standardizes the 
% data if C­0. Columns (variables, stations) whose non-missing values
% do not exceed MINPCT(%) of the column length are excluded from analysis
% and NaNs are reinserted into the output eigenvectors. Acceptable gappiness
% is handled by excluding gaps in the calculation of the covariance matrix 
% (COVMISS). MINPCT = 100 excludes all columns having any missing data.
%   
% INPUT VARIABLES:
% 
% X(N,M) = matrix with original data.
%      C = 0 if data NOT to be normalized (covariance  matrix) 
%      C ­  0 if data ARE to be normalized (correlation matrix)
%
% OUTPUT VARIABLES
%
%    LAM = eigenvalue matrix (mode#, e-value, %var, %cum.var)
%     EV = eigenvector matrix. Rows are modes, columns correspond to data.
%    VEM = % variance explained for the i-th column by the j-th component.
%          The square root of this is called the product moment correlation
%          of the i-th response and the j-th component.
%     TC = the time (case) coefficients of the n modes. 
%          (columns of Y are modes, importance decreasing to right)
%     SC = sample covariance of i-th variable with the j-th component =S*Ej.
%          If the E matrix is used, each column corresponds to a vector.
%
% METHOD: [E,D]=eig(cov(XM)); % D is the "e-value" column of LAM.
%              
% NOTE: The method is taken from "Multivariate Statistical Methods",
%       Donald F. Morrison, McGraw-Hill Book Company, Chapter 7, 1967. 
%
% SEE ALSO: MEANMISS, STDMISS, COVMISS

%   Written by D.B. Enfield
%   NOAA/Atlantic Oceanographic & Meteorological Laboratory
%   Miami, FL 33149 (305-361-4351)

% =================== Data preparation section =========================
% Redefine array to exclude stations where gappiness is unacceptable
if nargin<3;minpct=100;end
[nr,nc]=size(x);
mincases=fix(minpct*nr/100);
% nn=sum(finite(x));
nn=sum(isfinite(x));
jj=find(nn>=mincases);                     % ID acceptable stations
xx=x(:,jj);                                % Eliminate gappy stations
[n,m]=size(xx);                            % Dimensions of new matrix
xx=xx-ones(n,1)*meanmiss(xx);              % Demean the data
if c~=0;xx=xx./(ones(n,1)*stdmiss(xx));end % Standardize if c~=1

% ======================= Comutations section ==========================
s=covmiss(xx);                            % Compute covariance matrix
[eigvct,d]=eig(s);                        % [E,D]= eigenvector, eigenvalue
[d,k]=sort(-diag(d));eigvct=eigvct(:,k)'; % Arrange [e,d] in decreasing order
d=-d;tv=sum(d);                           % tv = total variance = trace(l)
ve=100*d./(tv*ones(m,1));                 % ve = pct of variance explained
sumve=cumsum(ve);                         % sumve = cumulative sum
index=1:m;index=index';                   % Create the mode idices
lam=[index d ve sumve];                   % Eigenvalue output matrix

% VEM = pct variance explained for the ith variable by the jth mode 
vem=nan*ones(m,nc); ev=vem;               % Replace missing columns
vem(:,jj)=(eigvct.^2).*(d*ones(1,m))./(ones(m,1)*diag(s)'); vem=100*vem;
ev(:,jj)=eigvct;

idx=find(isnan(xx));                      % ID missing data
xx(idx)=zeros(size(idx));                 % and remove
tc=xx*eigvct';                            % Time coeffs for the jth mode
% Columns #1,2,... = time amplitudes of 1st,2nd,...modes, etc.

% SC = sample covariance of the ith variable with the jth component= S*Ej
% if the E matrix is used, each column corresponds to a 'vector'
sc=s*eigvct';    % Note: another way to do this computation is Yj =Dj*Eij
