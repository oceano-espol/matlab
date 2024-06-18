function C_xy=ts_cov(X,Y)
% function C_xy=ts_cov(X,Y)
%
% TS_COV Funcion covarianza de X, Y
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

% --- varargin check ------------------------------------------------------

siz_x=size(X); siz_y=size(Y);
if siz_x(1)*siz_x(2)~=siz_y(1)*siz_y(2),
    error('Las dimensiones no coinciden. Revisar SVP.')
end

test_nan=sum(sum(isnan(X)));
if test_nan>0,
    error('Existen valores NaN, utilizar <nan_mean> o <nanmiss> SVP.')
end

test_nan=sum(sum(isnan(Y)));
if test_nan>0,
    error('Existen valores NaN, utilizar <nan_mean> o <nanmiss> SVP.')
end

% --- varargin check ------------------------------------------------------

N=length(X(:,1));
X_mu=ts_mean(X);        Y_mu=ts_mean(Y); 

C_xy=(1/(N-1))*sum((X-X_mu).*(Y-Y_mu));
