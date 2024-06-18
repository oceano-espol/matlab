function out=ts_movavg3(data,size_f)
% function out=ts_movavg3(data,size_f)
%
% MOVAVG Running Mean Filter (Media Corrida)
%        -antiguo <movavg_ths>
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
% ts_movavg3 es un caso especifico. Suaviza el ciclo anual de datos
% diarios, y añade en el inicio-fin de la serie 15 datos (respectivamente)
% para utilizar el filtro de 30 dias.

% --- PRIMER BLOQUE -------------------------------------------------------

% (1) datos del nivel medio del mar, tesis Mgs JT. El campo de columna
% sobre el que trabaja <MOVAVG> puede ser intercambiable...
%             1   2   3     4    5
% data = DY_SEC, MO, DY, ANOM, STD

% --- OBS: Aquí se considera el caso especial en el que se procesan datos
% de una climatología. Dado que en la media movil se pierden datos (puesto
% que los datos filtrados comeinzan a ubicarse desde i=n/2), consideramos
% a estos datos "circulares", y rellenamos con los valores últimos y 
% primeros, el primer bloque y el ultimo.

data_filled=[data(353:366,:);data;data(1:15,:)];
% data_anom=

% -------------------------------------------------------------------------

length_d=length(data(:,1));
times_ex=length_d-(size_f-1);

j=1; k=size_f;
for i=1:times_ex,
    out_ty(i,:)=[[sum(data_filled(j:k,4))/size_f],[sum(data_filled(j:k,5))/size_f]];
    j=j+1; k=k+1;
end

out=[data(round(size_f/2):round(size_f/2)+times_ex-1,1:3),out_ty];





