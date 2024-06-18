function [res,ixoutl,outl]=quartile(x,factor_w)
% function [res,ixoutl,outl]=quartile(x,factor_w)
%
% Variables de entrada:
%         x = datos (vector columna)
%  factor_w = maximum whisker length
%
% Variables de salida:
%       res = (vect columna) [upper adjacent value; q3; q2; q1;
%                             lower adjacent values]
%    ixoutl = indice de posicion de datos outliers
%      outl = datos outliers

% 2004-09-17, chris d larson (mathworks central)
%  https://la.mathworks.com/matlabcentral/fileexchange/5877-quartile-percentile-calculation
% 2020-07-06, jcedeno@espol.edu.ec
%
% [notes]
%
% maximum whisker lengths:
%   1.5 by default (matlab)
%   3   for precipitation applications (González-Rouco et al., 2001)

if nargin==1
    factor_w = 1.5;
end

% % define data set
% x = [16, 22, 24, 24, 27, 28, 29, 30]';
Nx = size(x,1);

% compute mean
mx = nanmean(x);

% compute the standard deviation
sigma = nanstd(x);

% compute the median
medianx = nanmedian(x);

% STEP 1 - rank the data
y = sort(x);

% compute 25th percentile (first quartile)
Q(1) = nanmedian(y(find(y<nanmedian(y))));

% compute 50th percentile (second quartile)
Q(2) = nanmedian(y);

% compute 75th percentile (third quartile)
Q(3) = nanmedian(y(find(y>nanmedian(y))));

% compute Interquartile Range (IQR)
IQR = Q(3)-Q(1);

% compute Semi Interquartile Deviation (SID)
% The importance and implication of the SID is that if you 
% start with the median and go 1 SID unit above it 
% and 1 SID unit below it, you should (normally) 
% account for 50% of the data in the original data set
SID = IQR/2;

% determine extreme Q1 outliers (e.g., x < Q1 - 3*IQR)
iy = find(y<Q(1)-3*IQR);
if length(iy)>0,
    outliersQ1 = y(iy);
else
    outliersQ1 = [];
end

% determine extreme Q3 outliers (e.g., x > Q1 + 3*IQR)
iy = find(y>Q(1)+3*IQR);
if length(iy)>0,
    outliersQ3 = y(iy)
else
    outliersQ3 = [];
end

% -------------------------------------------------------------------------
% res?

% uav: upper adjacent value
% lav: lower adjacent value
uav = Q(3) + factor_w * IQR;
lav = Q(1) - factor_w * IQR;

% para encontrar el valor "limite", buscamos el valor mínimo entre el rango
% de datos que va desde q1 a uav. de igual forma

ix_uav=find(x>=Q(3) & x<=uav);
uav_max=max(x(ix_uav));
% ---
ix_lav=find(x>=lav & x<=Q(1));
lav_min=min(x(ix_lav));

res=[uav_max;...
    Q(3);...
    Q(2);...
    Q(1);...
    lav_min],

% -------------------------------------------------------------------------
% outliers?

ix_outl_uav=find(x>uav_max);
outl_uav=x(ix_outl_uav);

ix_outl_lav=find(x<lav_min);
outl_lav=x(ix_outl_lav);

if isempty(ix_outl_uav)==1
    ix_outl_uav=[];
    outl_uav=[];
end

if isempty(ix_outl_lav)==1
    ix_outl_lav=[];
    outl_lav=[];
end

ixoutl=cat(2,ix_outl_lav',ix_outl_uav');
outl=cat(2,outl_lav',outl_uav');

return

%% ------------------------------------------------------------------------

% compute total number of outliers
Noutliers = length(outliersQ1)+length(outliersQ3);

% display results
disp(['Mean:                                ',num2str(mx)]);
disp(['Standard Deviation:                  ',num2str(sigma)]);
disp(['Median:                              ',num2str(medianx)]);
disp(['25th Percentile:                     ',num2str(Q(1))]);
disp(['50th Percentile:                     ',num2str(Q(2))]);
disp(['75th Percentile:                     ',num2str(Q(3))]);
disp(['Semi Interquartile Deviation:        ',num2str(SID)]);
disp(['Number of outliers:                  ',num2str(Noutliers)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Percentile Calculation Example
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define percent
kpercent = 75;

% STEP 1 - rank the data
y = sort(x);

% STEP 2 - find k% (k /100) of the sample size, n.
k = kpercent/100;
result = k*Nx;

% STEP 3 - if this is an integer, add 0.5. If it isn't an integer round up.
[N,D] = rat(k*Nx);
if isequal(D,1),               % k*Nx is an integer, add 0.5
    result = result+0.5;
else                           % round up
    result = round(result);
end

% STEP 4 - Find the number in this position. If your depth ends 
% in 0.5, then take the midpoint between the two numbers.
[T,R] = strtok(num2str(result),'0.5');
if strcmp(R,'.5'),
    Qk = mean(y(result-0.5:result+0.5));
else
    Qk = y(result);
end

% display result
fprintf(1,['\nThe ',num2str(kpercent),'th percentile is ',num2str(Qk),'.\n\n']);
