function PVE=ts_pve(X,Y)
% function PVE=ts_pve(X,Y)
%
% PVE Proportion of Variance Explained
%     (Porcentaje de varianza explicada)
% Funcion que permite calcular el PVE de dos set de datos (X, Y), como 
% medida de confianza de cuan bueno es el ajuste de dos series. Se ha 
% usado la siguiente definicion:
%
% PVE = C_xy / [SS(x) SS(y)]^(1/2)
%
% Lo que implica que el PVE es igual al llamado "coeficiente de 
% correlacion" o "coeficiente de correlacion producto-momento de Pearson".
% 
% Variables de entrada:
% 
%  X, Y = Matrices de datos de entrada
%         [m*1] [m*1]
%
% Variables de salida:
%
%    PVE = Porcentaje de varianza explicado

% 5/NOV/2013, Jonathan Cedeño, jcedeno@udec.cl
%             UdeC, Magister Oceanografia


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

%          C_xy ---> Covarianza de X, Y
%  SS(x), SS(y) ---> Varianza de X y Varianza de Y 

PVE=ts_cov(X,Y)/(ts_var(X)*ts_var(Y))^(1/2);

