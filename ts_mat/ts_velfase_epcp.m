function c=ts_velfase_epcp(dist,conf,dof,px,flag)
% function c=ts_velfase_epcp(dist,conf,dof,px,flag)
%
% TS_VELFASE Velocidad de fase del espectro cruzado
%
%           *Enfocado a resolver la banda intraestacional*
%
%            7/jul/2015, jcedeno@udec.cl

% Variables de entrada:
%   
%   dist = distancia [m]
%   conf = nivel de confianza [%] 
%          sugerido: 95
%    dof = grados de libertad
%     px = espectro cruzado
%          1. Fs, 2. Px, 3. Py, 4. Cxy, 5. Fxy
%   flag = identificador para blanquear.
%          eg. crsccp (christmas-santa cruz cp)


% la estructura de datos tiene el rezado de la rutina original
% <ts_velfase.m>
data.dist=dist;     % distancia
data.dof=dof;       % grados de libertad
data.Px=px;         % espectro

% Px.t2_95=orpa_fasesig(Px.t2,95,28);
% [!] el resultado de la fase al 95% está en la col.(6)
ty95=orpa_fasesig(data.Px,conf,data.dof);

% nos quedamos con las frecuencias más bajas que 1/30 [cpd]
ix=find(ty95(:,1)<=1/30);
% ty95(ix,:), pause,

% Fxy=(1) freq., (2) fase [grad.]
% Fxy contiene el espectro de fase bajo dos condiciones:
%    i) nivel de confianza == conf
%   ii)                 Fs <= 1/30
Fxy=[ty95(ix,1),ty95(ix,6)]; clear ix ty95,
Fxy=nanfill(Fxy,9999);

[[1:length(Fxy)]',Fxy], pause,

%% flag issue (blanqueo)

if exist('flag','var')==0, flag='none'; end

switch lower(flag),
    case 'crsccp',
        ixb=[9,10,11];
        Fxy(ixb,2)=NaN;
    case 'sclbep',
        % ixb=[14,15,18];
        % Fxy(ixb,2)=NaN;
    case 'lbclcp',
        ixb=[1,2,3];
        Fxy(ixb,2)=NaN;
end

%% after blanking

disp('after blanking:')
[[1:length(Fxy)]',Fxy],

subplot(1,2,1),
plot(Fxy(:,1),Fxy(:,2),'+'), 

whos,

% [!] filosofia para transformar la recta cortada en una línea continua
%     buscar la tendencia de los primeros valores. en el caso de prueba,
%     la tendencia es a tener valores negativos. así, se toma todos los
%     valores positivos, y se les suma -360 (para que todos sean negativos)

ix=find(Fxy(:,2)>=90 & Fxy(:,2)<=180);

Fxy(:,3)=Fxy(:,2);
Fxy(ix,3)=-360+Fxy(ix,2);
hold on, plot(Fxy(ix,1),Fxy(ix,2),'+r'),

subplot(1,2,2),
plot(Fxy(:,1),Fxy(:,3),'+'),  pause,

% regresion con paso forzado por el origen
% primero, quitando los nans...
ixn=find(~isnan(Fxy(:,3)));

% [1] ajuste con fit -------------------------------
% [f,f2]=fit(Fxy(ixn,1),Fxy(ixn,3),'a*x'),
% if f2.adjrsquare<=0.85, 
%     error('adjrsquare muy bajo, volver a correr'), 
% end

% [2] ajuste con minimos cuadrados -----------------
%     y=a*x (operador \ de matlab)
a=Fxy(ixn,1)\Fxy(ixn,3);

m=abs(a);

% obteniendo frecuencia
fq=360/m;       % [cpd]
pr=1/fq;        % [d]

% c = L/T
%     L, distancia // T, periodo // c, velocidad de fase
c=(1000/24/3600)*data.dist/pr,




