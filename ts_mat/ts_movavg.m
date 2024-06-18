function y=ts_movavg(x,n)
% function y=ts_movavg(x,n)
%
% MOVAVG Filtro tipo "media corrida" -promedios moviles-
%        -caso general, hacia adelante (forward)

% 27-sept-2013, Jonathan Cedeño, jcedeno@udec.cl
%               Construida para la Tesis de Mgs., UdeC Concepcion
% Edited on:    18/nov/2013, jcedeno@udec.cl (modo general)
%               15/dec/2013, jcedeno@udec.cl (dbe)

% ---forward---------------------------------------------------------------

y = cumsum(x);

% Add a zero at the beginning of the cumsum
% ...
[p,q] = size (x);
if     p==1, y = [0, y];
elseif q==1, y = [0; y];
else   error ('First argument must be a vector');
end

% Calculate the moving average (running mean)
% ...
m=max(p,q)+1;
y = (y(n+1:m) - y(1:m-n))./n;

% adding NaN at tails in order to have equal lengths w/respect to x
% odd --> impar, even ---> par
% ...
if mod(n,2)==0      % even (par)
    y=[ones((n/2)-1,1).*NaN;y;ones(n/2,1).*NaN];
else                % odd (impar)
    y=[ones(floor(n/2),1).*NaN;y;ones(floor(n/2),1).*NaN];
end

