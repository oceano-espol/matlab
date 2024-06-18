function w=ts_coslanczosw(T,N)
% function w=ts_coslanczosw(T,N)
%
% COSLANCZOSW Pesos del filtro Coseno-Lanzcos
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

% 07/may/2015, jcedeno@udec.cl

% Pizarro O. (1991). Propagación y forzamiento de pertubaciones de baja
%   frecuencia del nivel del mar en la costa norte de Chile. Tesis de
%   Oceanografía. Universidad Católica de Valparaíso. Valparaíso.

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

