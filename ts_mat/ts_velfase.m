function out=ts_velfase(data)
% function out=ts_velfase(data)
%
% TS_VELFASE Velocidad de fase del espectro cruzado
%
%           *Enfocado a resolver la banda intraestacional*
%
%            20/jun/2015, jcedeno@udec.cl

% [!] la variable de entrada es una estructura que se lee del sig. modo:
%

% data.dist , distancia [km]
%     .tm   , tiempo [jul]
%     .dt   , data []
%     .dof  , grados de libertad
%     .Px   , espectro cruzado
%             [Fs,Px,Py,Cxy,Fxy]

% nivel de confianza. este parametro puede ser editado.
conf=95;    

% Px.t2_95=orpa_fasesig(Px.t2,95,28);
% [!] el resultado de la fase al 95% está en la col.(6)
ty95=orpa_fasesig(data.Px,conf,data.dof);

% nos quedamos con las frecuencias entre 1/30 a 1/120 [d^-1]
% (banda intraestacional)
ix=find(ty95(:,1)<=1/30);
% ty95(ix,:), pause,

% Fxy=(1) freq., (2) fase [grad.]
% Fxy contiene el espectro de fase bajo dos condiciones:
%    i) nivel de confianza = 95%
%   ii) banda intraestacional
Fxy=[ty95(ix,1),ty95(ix,6)]; clear ix ty95,
Fxy=nanfill(Fxy,9999);

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
c=(1000/24/3600)*data.dist/pr;

% out.
%    .m (pendiente de la recta de ajuste)
%    .c (velocidad de fase)
out=[m,c],



