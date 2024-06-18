function answ551=ts_sd(data)
% function answ551=ts_sd(data)
%
% TS_SD Calculo de la desviacion estandar de un conjunto de valores
% 
% Criterios:
% - La dimensión sobre la que se ejecuta el calculo es siempre las
%   columnas. Si es necesario trabajar sobre filas, transponer primero
%   variable de entrada.
% - No es sensible con los valores <NaN>. Si es requisito ignorar NaN,
%   trabajar con <nan_sd> o <nansd>
%
% TOOLBOX: <jugo_mat> on <C:\J577\zmatlab\common_mat\jugo_mat>

test_nan=sum(sum(isnan(data)));
if test_nan>0,
    error('Existen valores NaN, utilizar <nan_mean> o <nanmiss> SVP.')
end

N=length(data(1,:));

% La desviacion estandar es la raiz cuadrada de la varianza... y la
% varianza es el cuadrado de la desviacion estandar... la varianza ya fue
% calculada anteriormente con jt_var.

for i=1:N,
    answ551(:,i)=(ts_var(data(:,i)))^(1/2);
end


