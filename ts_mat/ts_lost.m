function lost=ts_lost(x)
% function lost=ts_lost(x)
%
% TS_LOST Calculador de porcentaje de datos perdidos
% Se calcula el porcentaje de datos perdidos de cada set de datos,
% asumiendo que una columna es un set.

id_NaN=isnan(x);

ii_1s=find(id_NaN==1);      % datos faltantes
ii_0s=find(id_NaN==0);      % datos presentes

N=length(ii_1s);

lost=N/length(x(:,1))*100;

