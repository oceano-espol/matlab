function y=ts_movavg_fb(x,n)
% function y=ts_movavg_fb(x,n)
%
% MOVAVG Filtro tipo "media corrida" -promedios moviles-
%        -caso general, hacia adelante y atras (forward-backward)
%
% El filtro es ejecutado dos veces, en ambos sentidos, para asegurar que
% la serie reconstruida con el filtro no tenga sesgo en la fase con
% respecto a la original.


% 15-dec-2013, Jonathan Cedeño, jcedeno@udec.cl
%              Construida para la Tesis de Mgs., UdeC Concepcion
% Edited on:   

% ---forward---------------------------------------------------------------

y_f = cumsum(x);

% Add a zero at the beginning of the cumsum
% ...
[p,q] = size (x);
if     p==1, y_f = [0, y_f];
elseif q==1, y_f = [0; y_f];
else   error ('First argument must be a vector');
end

% Calculate the moving average (running mean)
% ...
m=max(p,q)+1;
y_f = (y_f(n+1:m) - y_f(1:m-n))./n;

% ---backward--------------------------------------------------------------

y_b = cumsum(flipdim(y_f,1));

% Add a zero at the beginning of the cumsum
% ...
[p,q] = size (y_f);
if     p==1, y_b = [0, y_b];
elseif q==1, y_b = [0; y_b];
else   error ('First argument must be a vector');
end

% Calculate the moving average (running mean)
% ...
m=max(p,q)+1;
y_b = (y_b(n+1:m) - y_b(1:m-n))./n;
y_b=flipdim(y_b,1);

% -------------------------------------------------------------------------

% adding NaN at tails in order to have equal lengths w/respect to x
% odd --> impar, even ---> par
% ...
if mod(n,2)==0      % even (par)
    disp('par!')
    y=[ones(((n/2)*2)-1,1).*NaN;y_b;ones(((n/2)*2)-1,1).*NaN];
else                % odd (impar)
    disp('impar!')
    y=[ones(floor(n/2)*2,1).*NaN;y_b;ones(floor(n/2)*2,1).*NaN];
end

