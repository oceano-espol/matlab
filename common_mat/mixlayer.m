function yi_ml=mixlayer(data)
%function yi_ml=mixlayer(data)
% MIXLAYER (capa de mezcla) Esta funcion calcula
% la profundidad de la capa de mezcla, definida como la 
% profundidad donde la temperatura es 0.5ºC menos que
% la TSM (Kessler et al., 1998; Wang and McPhaden, 1999).
% 
% Las variables de entrada son:
%
%      data = Matriz de Datos de Entrada
%             1era. Col., Profundidad (negativa, en m).
%             2da.  Col., Temperatura (ºC). 
%
% Las variables de salida son:
%
%     yi_ml = Profundidad de la capa de mezcla
%
% CALLS: find, size

% 20/Oct/2005 Jonathan Cedeño, FIMCM-ESPOL (Ecuador).

[a,b]=size(data);

delta_ml=data(1,2)-0.5;
[u1,v1]=find(data(:,2)>delta_ml);
[siz_u1,siz_v1]=size(u1);
x1=data(siz_u1,2);
xi=delta_ml;                 % T-0.5 (capa de mezcla)
x2=data(siz_u1+1,2);
y1=data(siz_u1,1);
y2=data(siz_u1+1,1);
yi_ml=((xi*y2)-(x1*y2)+(y1*x2)-(y1*xi))/(x2-x1);

