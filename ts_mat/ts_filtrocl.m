function w=ts_filtrocl(T,np)
%function w=ts_filtrocl(T,np)
%
% TS_FILTROCL Filtro Coseno-Lanczos.
%             Esta funcion genera los pesos segun la aproximacion de 
%             Coseno-Lanczos, el cual es un filtro paso-bajo (remueve la 
%             porcion de alta frecuencia).
%
% Variables de entrada:
%
%    T = periodo en unidades de dato de la amplitud media
%   np = numero total de pesos

%				ORPA 22/03/95
%            Jcedeno 14/01/14 Comentarios menores y resumen de la funcion
%                             en el toolbox <ts_mat>

k=(1:(np-1)/2)';
m=max(size(k));
w=0.5*(1+cos(2*pi/(np-1)*k)).*sin(2*pi/T*k)./(2*pi/T*k);
s=1+2*sum(w);
ind=(m:-1:1)';
w=[w(ind);1;w]/s;

op=2;
if op==1

%function w = filtroclbp(T1,T2,np);
% function w = filtroclbp(T1,T2,np);
% Lanczos band pass filter
%
% Input
% T1    cut in period (frequencies 2*pi/T1)
% T2    cut out period (frequencies 2*pi/T1)
% np    weights to be defined
% Note  T1 < T2 (eg T1= 10 T2 = 90)
%
% Output
% w     weights of Lanczos band pass filter
%
% eg w = filtroclbp(40,120,361);
% References:
% Jones, C., D.E. Waliser and C. Gautier. Journal of
% Climate, 1057-1072, 1998.
% W. Emery and R. Thomson, 1998. Data Analysis Methods
% in Physical Oceanography. Pergamon, p 533-539.
%
%  SAM DCESS 11/09/00


% Lanczos low pass filter

%Dt = 1;       %interval medition
%wn = pi/Dt;   %Nyquist frequency
%wc = 2*pi/T;  %half amplitude frequency
%ho = wc/wn;
%h = (wc/wn)*sin(pi*k*wc/wn)/(pi*k*wc/wn)*[sin(pi*k/M)/(pi*k/M)];

np = 361;T = 40;

Dt = 1;
N  = (np-1)/2;
k  = [-N:1:-1 1:1:N];
ho = 2*Dt/T;  % for k=0
h  = ho*[sin(pi*k*ho)./(pi*k*ho)].*[sin(pi*k/N)./(pi*k/N)];
wp = [h(1:N) ho h(N+1:2*N)]';


% Lanczos band pass filter [T1 < T2 (eg T1 = 10 T2 = 90)]

 Dt = 1; np = 361; T1 = 40; T2 = 120;

 N  = fix((np-1)/2);
 k  = [-N:1:-1 1:1:N];

 hbo = 2*Dt*(T2-T1)/(T2*T1);
 hb1   = 2*Dt/T1*[sin(pi*k*2*Dt/T1)./(pi*k*2*Dt/T1)];
 hb2   = 2*Dt/T2*[sin(pi*k*2*Dt/T2)./(pi*k*2*Dt/T2)];
 hb = [hb1-hb2].*[sin(pi*k/N)./(pi*k/N)];

 w  = [hb(1:N) hbo hb(N+1:2*N)]';


% Lanczos Hight pass filter

end

