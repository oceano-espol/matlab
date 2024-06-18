function Fs=ts_coslanczosfs(T,N,Ts)
% function Fs=ts_coslanczosfs(T,N,Ts)
%
% COSLANCZOSFS Respuesta del filtro Coseno-Lanzcos
%          (También llamada función de respuesta Fs)
%          As in Pizarro (1991) and Mooers et al. (1968)
%
% Variables de entrada: 
%
%  T = periodo de la amplitud media del filtro
%      (período de corte)
%  N = número de pesos menos 1 (impar)
%      N=T*3-1;
% Ts = Tsigma, T en los cuales se evalúa la respuesta del filtro
%      Ts=2*pi/sigma
%
% Variables de salida:
%
%  Fs = amplitud de respuesta del filtro (de 0 a 1)
%       1 --> toda la señal pasa (100%)
%       0 --> ninguna señal pasa

% 07/may/2015, jcedeno@udec.cl

% Pizarro O. (1991). Propagación y forzamiento de pertubaciones de baja
%   frecuencia del nivel del mar en la costa norte de Chile. Tesis de
%   Oceanografía. Universidad Católica de Valparaíso. Valparaíso.
% Mooers C.N.K., L.M. Bogert, R.L. Smith and J.G. Patullo (1968). A 
%   compilation of observations from moored current meters and
%   thermographs (and complementary oceanoraphic and atmospheric data).
%   Volume II: Oregon Continental shelf, August-September 1966. Data 
%   Report 30. Oregon State University. Corvallis.

k=[1:N/2]';
Nk=length(k);
% weight
w=0.5*(1+cos(2*pi/N*k)).*sin(2*pi/T*k)./(2*pi/T*k);
% columnizing [w]
w=w(:);
% normalization factor
G=1+2*sum(w);

% response function
for i=1:length(Ts),
    Fs(i)=[1+2*(w'*cos(k.*(2*pi/Ts(i))))]/G;
end



