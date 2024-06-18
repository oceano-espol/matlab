function [sf] = ts_filtrado(x,p1)
% function [sf] = ts_filtrado(x,p1)
%
% TS_FILTRADO Funcion de transferencia para el filtrado de datos.
%             De acuerdo al peso p1, se filtra la serie x. Los pesos pueden
%             determinarse por medio de la función <ts_filtrocl>, o 
%             cualquier otra ventana que se estime conveniente, como 
%             butter, hamm, hann, etc.
%
% Su uso con <ts_filtrocl> es especiualizado para procesamiento de datos
% geofisicos. Por defecto, este conjunto funciona como un filtro "lowpass".
% Sin embargo, también es posible configurar su uso para tareas "highpass"
% y "bandpass":   *P1 y P2 son los pesos según T1 y T2. T2 > T1.
%
%   "lowpass" --> ts_filtrado(x,P2)
%  "highpass" --> x-lowpass
%  "bandpass" --> ts_filtrado(highpass,P1)
%
% Variables de entrada:
% 
%    x = serie de tiempo original
%   p1 = pesos del filtro (determinada con anterioridad gracias a 
%        ts_filtrocl o cualquier otra ventana)
%
% Variables de salida:
% 
%   sf = serie de tiempo filtrada
%

%            Jessica 18/10/10
%            Jcedeno 14/01/14 Comentarios menores y resumen de la funcion
%                             en el toolbox <ts_mat>

%    x = 3*cos(2*pi/20*[0:1:100])'+ 3*rand(101,1);
%   p1 = boxcar(5); p1=p1/sum(p1);
%   p1 = triang(9); p1=p1/sum(p1);

x  = x(:);      % columnize
p1 = p1(:);

n   = length(x);
np  = length(p1);
np2 = fix(np/2);

sf = x+NaN;

% filtrando la serie...
% ...
for i1 = np2+1:n-np2
    sf(i1) = p1'*x(i1-np2:i1+np2);
end
