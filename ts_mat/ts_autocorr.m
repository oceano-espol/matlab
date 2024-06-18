function Cx=ts_autocorr(X,Y,lag)
% function Cx=ts_autocorr(X,Y,lag),
%
% TS_AUTOCORR Autocorrelacion/Correlación Cruzada

% Created on 27/aug/2013, jcedeno@udec.cl 
% Edited:    23/apr/2014, jcedeno@udec.cl

N_x=size(X); N_y=size(Y);
if N_x(1)*N_x(2)~=N_y(1)*N_y(2),
    error('Las dimensiones no coinciden. Revisar SVP.'),
end

N=length(X);

% Resampleando las matrices a una longitud concordante con el <lag>
% ingresado. <data_2> es la matriz que se atrasa-adelanta. <data_1> 
% permanece estatico. Lags positivos (+) indican que <data_2> se corre
% a la derecha/abajo. Lags negativos (-) indican que <data_1> se corre 
% a la izquierda/arriba.

lag_s=[-lag:1:lag];

for i=1:length(lag_s),
    if lag_s(i)==0,
        Xty=X;                  Yty=Y;
    elseif lag_s(i)>0,
        Xty=X(lag_s(i)+1:N);    Yty=Y(1:N-lag_s(i));
    elseif lag_s(i)<0,
        Xty=X(1:N+lag_s(i));    Yty=Y(-lag_s(i)+1:N);
    end
    Cx(i,:)=[lag_s(i),ts_corr(Xty,Yty)];
    Xty=[]; Yty=[];
end

