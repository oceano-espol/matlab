function tsdiagram3(S,T)
%function tsdiagram3(S,T)
% Esta función plotea el diagrama TS con contornos 
% seleccionados de densidad.
%
% Los parámetros de entrada son:
%
% S = Salinidad (valores max & min).
% T = Temperatura (valores max & min).
%
% Los usuarios de esta rutina deberán de superponer los
% valores de Temperatura y Salinidad para una estación dada
% usando la función <plot> (x = Sal. / y = Temp.).
%
% CALLS: swstate, contour

% Notes: RP (WHOI) 09/Dec/91
% 07/Nov/92 Changed for Matlab 4.0
% 14/Mar/94 Made P optional.
% 10/May/05 Revised by Jonathan Cedeño, FIMCM-ESPOL.

if (nargin<2),
   error('tsdiagram3: Insuficientes parámetros de entrada');
elseif (nargin==2),
   P=0;
end

Sg=S(1)+[0:30]/30*(S(2)-S(1));   % grid points of contouring
Tg=T(1)+[0:30]'/30*(T(2)-T(1));
[SV,SG]=swstate(ones(size(Tg))*Sg,Tg*ones(size(Sg)),P(1));
[c,h]=contour(Sg,Tg,SG,'k:'); clabel(c,h)
axis([S(1) S(2) T(1) T(2)]);
% title('DIAGRAMA TS','fontsize',12,'fontweight','bold')
xlabel('Salinidad (ups)'),      % 'fontweight','bold');
ylabel('Temperatura (ºC)'),     %'fontweight','bold');