function X_mu=ts_mean(X)
% function X_mu=ts_mean(X)
%
% TS_MEAN Media de X
% 
% Criterios:
% - La dimensión sobre la que se ejecuta el calculo es siempre las
%   columnas. Si es necesario trabajar sobre filas, transponer primero
%   variable de entrada.
% - No es sensible con los valores <NaN>. Si es requisito ignorar NaN,
%   trabajar con <nan_mean> o <nanmiss>
%
% TOOLBOX: <ts_mat> on <C:\J577\zmatlab\common_mat\ts_mat>

% Created on    23/aug/2013, jcedeno@udec.cl 
% Edited:       05/nov/2012, jcedeno@udec.cl

test_nan=sum(sum(isnan(X)));
if test_nan>0,
    error('Existen valores NaN, utilizar <nan_mean> o <nanmiss> SVP.')
end

N=length(X(:,1));

X_mu=(1/(N-1))*sum(X);
