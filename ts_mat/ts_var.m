function SS_x=ts_var(X)
% function SS_x=jt_var(X)
%
% TS_VAR Varianza de X
% 
% Criterios:
% - La dimensión sobre la que se ejecuta el calculo es siempre las
%   columnas. Si es necesario trabajar sobre filas, transponer primero
%   variable de entrada.
% - No es sensible con los valores <NaN>. Si es requisito ignorar NaN,
%   trabajar con <nan_sd> o <nansd>
%
% TOOLBOX: <ts_mat> on <C:\J577\zmatlab\common_mat\ts_mat>

% Created on:   23/aug/2013, jcedeno@udec.cl 
% Edited:       05/nov/2012, jcedeno@udec.cl


test_nan=sum(sum(isnan(X)));
if test_nan>0,
    error('Existen valores NaN, utilizar <nan_mean> o <nanmiss> SVP.')
end

N=length(X(:,1));    X_mu=ts_mean(X);

% La desviacion estandar es la raiz cuadrada de la varianza... y la
% varianza es el cuadrado de la desviacion estandar...

SS_x=(1/(N-1))*sum((X-X_mu).^2);
