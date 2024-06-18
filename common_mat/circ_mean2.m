function mu = circ_mean2(alpha)
% function mu = circ_mean2(alpha)
%
% CIRC_MEAN2 Obtencion de la media a traves de estadistica circular
%            Igual que circ_mean2, pero con los angulos de entrada en 
%            sexagecimal (conversion interna de sexag.-radianes-sexag.)

% [1] radianes a sexagecimales
% ...
alpha=alpha.*(pi/180);

% [2] corriendo circ_mean
% ...
mu=circ_mean(alpha);

% [3] sexagecimales a radianes
% ...
mu=mu.*(180/pi);

% [4] testando si algun valor es negativo --> restando de 360
% ...
[izr,jzr]=find(mu<0);
if ~isempty(izr),
    mu(izr,jzr)=360+mu(izr,jzr);
end


