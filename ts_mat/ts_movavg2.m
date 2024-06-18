function out=ts_movavg2(data,size_f)
% function out=ts_movavg2(data,size_f)
%
% MOVAVG Running Mean Filter (Media Corrida)
%        -antiguo <movavg>
% Rutina para filtrar datos según la técnica de media corrida, que es un
% filtro de "caja rectangular". La explicacion para construir la misma
% esta dada en la tesis de A. Cedeño (1988).
%
% Variables de Entrada:
%
%    data = datos de entrada
%           (la columna de datos se puede ajustar en el primer bloque)
%  size_f = tamaño del filtro
%
% Variables de Salida:
%
%     out = datos de salida
%           (en orden correspondiente a los datos de entrada)

% 27-sept-2013, Jonathan Cedeño, jcedeno@udec.cl
%               Construida para la Tesis de Mgs., UDEC Concepcion

% Ajustado a los datos de tesis KW, Magister Jcedeno, UdeC
% ts_movavg2 es un caso especifico. Suaviza el ciclo anual de datos
% diarios.

% --- PRIMER BLOQUE -------------------------------------------------------

% (1) datos del nivel medio del mar, tesis Mgs JT. El campo de columna
% sobre el que trabaja <MOVAVG> puede ser intercambiable...
%             1   2   3     4    5
% data = DY_SEC, MO, DY, ANOM, STD

data_d=data(:,4);       % Anomalia del Nivel Medio del Mar (NMM)
data_sd=data(:,5);      % Desviacion Estandar del NMM

% -------------------------------------------------------------------------

length_d=length(data_d);
sec_data=[1:1:length_d]';

times_ex=length_d-(size_f-1);

j=1; k=size_f;
for i=1:times_ex,
    out_ty(i,:)=[[sum(data_d(j:k))/size_f],[sum(data_sd(j:k))/size_f]];
    j=j+1; k=k+1;
end

out=[data(round(size_f/2):round(size_f/2)+times_ex-1,1:4),out_ty];





