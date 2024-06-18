function [amx,thx,uux,vvx,lgx,pvx,out]=ts_xveccor(xu,xv,yu,yv,lag)
% function [amx,thx,uux,vvx,lgx,pvx,out]=ts_xveccor(xu,xv,yu,yv,lag)
%
% TS_XVECCOR Correlacion compleja cruzada con significancia
%
% Correlacion compleja segun funcion <veccor1>
% Significancia segun t-test de correlacion de pearson <r2pv>
%
% Programado para tesis Jcedeno (Kelvin)
% Correlacion maxima [amx] definida para el segmento de lag [-7 a 0] dias
% Ver linea 61. Este rango puede ser modificado.
%
%   amx = max. correlacion (polar)
%   thx = fase de angulo de max. correlacion (polar)
%   uux = max. correlacion, vector u (cart.)
%   vux = max. correlacion, vector v (cart.)
%   lgx = lag correspondiente al max. correlacion
%   pvx = p-value correspondiente al max. correlacion

% 23/mar/2015, jcedeno@udec.cl

nx=length(xu);

ls_yu = zeros(nx,lag);         % Initialize left  side of expanded yu matrix
rs_yu = zeros(nx,lag);         % Initialize right side of expanded yu matrix

ls_yv = zeros(nx,lag);         % Initialize left  side of expanded yv matrix
rs_yv = zeros(nx,lag);         % Initialize right side of expanded yv matrix

% Compute the outputs
lags = -lag:1:lag; 

% Fill out the expanded lag-matrix of Y (yy)
for k=1:lag
    nmk = nx-k;
    % yu
    ls_yu(k+1:nx,k) = yu(1:nmk);
    rs_yu(1:nmk,k)  = yu(k+1:nx);
    % yv
    ls_yv(k+1:nx,k) = yv(1:nmk);
    rs_yv(1:nmk,k)  = yv(k+1:nx);
end
ls_yu = fliplr(ls_yu);
ls_yv = fliplr(ls_yv);
yyu = [ls_yu,yu,rs_yu];
yyv = [ls_yv,yv,rs_yv];

% asi, la correlacion compleja se hara entre los pares:
%
%      xu,xv,yyu,yyv

% nx, 
% whos xu xv yyu yyv, pause,

% vector correlation (from bobstuff)
%   [a,theta]=veccor1(u1,v1,u2,v2)
%
% correlation significance (t-test method)
%   p=r2pv(r,n)

for i=1:length(yyu(1,:)),
    [am(i,:),th(i,:)]=veccor1(xu,xv,yyu(:,i),yyv(:,i));
    pv(i,:)=r2pv(am(i),nx);
end

% lag range for determine max. correlation
%   1/apr/2015, rng=[-7,0];
rng=[-7,0];

% [NOT] sobre las salidas: dos grupos de variables de salida
% 
% 1.  out.lg, lags (all)
%     out.pv, p-value (all)
%     out.am, amplitud (all)
%     out.th, angulo de fase (all)
%
% 2.     xam, amplitud maxima (o máxima correlacion)
%        pvx, p-value correspondiente a la max. correlacion
%        xth, angulo de fase correspondiente a la max. correlacion
%        xlg, lag correspondiente a la max. correlacion

% [1]
out.lg=lags;      % lags
out.pv=pv;        % p-value (significance)
out.am=am;        % amplitude
out.th=th;        % theta (phase angle)

% [2]
ixlg=find(lags>=rng(1) & lags<=rng(2));
ixam=find(am(ixlg)==max(am(ixlg)));
amx=am(ixlg(ixam)); pvx=pv(ixlg(ixam)); 
thx=th(ixlg(ixam)); lgx=lags(ixlg(ixam));

%% [01/apr/2015] converting phase angle [-180,180] to [0,360] ref.
%                then, converting polar -> cart. [am,th] to [uu,vv]
%                *only applies to max. correlation values*

% converting to cartesian coordinates
%   [u,v]=compass2cart(theta,rho)

if thx<0, thx=360+thx; end
[uux,vvx]=compass2cart(thx,amx);
