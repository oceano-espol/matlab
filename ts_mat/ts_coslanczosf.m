function y=ts_coslanczosf(x,T)
% function y=ts_coslanczosf(x,T)
%
% TS_COSLANCZOSF Filtro de Coseno-Lanczos
%                As in Pizarro (1991)
%
%       Este filtro pondera segmentos de 3*T-1 observaciones. Dicha
%       característica puede ser modificada en la linea 21.
%
% Variables de entrada:
%
%  x = serie de tiempo sin filtrar
%  T = periodo de la amplitud media del filtro
%
% Variables de salida:
%
%  y = serie de tiempo filtrada

% Pizarro O. (1991). Propagación y forzamiento de pertubaciones de baja
%   frecuencia del nivel del mar en la costa norte de Chile. Tesis de
%   Oceanografía. Universidad Católica de Valparaíso. Valparaíso.

% 07/may/2015, jcedeno@udec.cl

NP=T*3;     % [!] Para efectos de ser comparativo con las funciones de 
            %     ORPA, se deja [NP] como T*3. Lo más correcto sería 
            %     [T*3+1]
N=NP-1;

% cosine-lanczos weigths
w=coslanczosw(T,N);

% columnizing [x] and [w]
x=x(:);
w=w(:);

Nx =length(x);
Nw =length(w);
% <fix> force [Nw2] be an integer with no-decimals
Nw2=fix(Nw/2);

y=ones(Nx,1).*NaN;

% cosine-lanczos filter function
for i=Nw2+1:Nx-Nw2,     % defining the position in which the filter will
                        % work. data is lost at the head/end of [x]
                        % how data is lost? the half of length(w).
                        
    % ty=x(i-Nw2:i+Nw2);
    % tyf=w'*ty;
    % whos w ty tyf, pause,
                        
    y(i)=w'*x(i-Nw2:i+Nw2);
end


function w=coslanczosw(T,N)
% function w=coslanczosw(T,N)
%
% COSLANCZOSW Pesos del filtro Coseno-Lanczos
%             As in Pizarro (1991)
%
% Variables de entrada: 
%
%  T = periodo de la amplitud media del filtro
%      (período de corte)
%  N = número de pesos menos 1 (impar)
%      N=T*3-1;
%
% Variables de salida:
%
%  w = pesos del filtro coseno-Lanczos

% OJO: el N de la variable de entrada corresponde al
%      [NP-1] especificado en <ts_coslanczosf>.
%      e.g.: para un T=40; NP=40*3=120; N=NP-1=119;

k=[1:N/2]';
Nk=length(k);

% weight
w=0.5*(1+cos(2*pi/N*k)).*sin(2*pi/T*k)./(2*pi/T*k);
w0=1;

% normalization factor
G=1+2*sum(w);

% normalization
mi=[Nk:-1:1]';          % [mi] mirror index
w=[w(mi);w0;w]./G;

