function [ts_0m,lon,lat,sal_1m]=ext_0m(path_cnv1)
%function [ts_0m,lon,lat,sal_1m]=ext_0m
% EXT_0m Extractor de datos a 0m del archivo cnv de CTDs SeaBird
% A partir del archivo *.cnv resultante de la traduccion del *.hex,
% se extrae la fila de datos correspondiente a la profundidad mas
% cercana a la superficie.
% Debido a los problemas encontrados en una correcta  adquisicion de datos
% que involucra la forma en como se baja el CTD y el tiempo que permanece 
% en la superficie antes de bajar, se establece que el dato representativo
% mas cercano a la superficie se tomara de los datos que se encuentren 
% entre -2db y 2db, y aquellos cuya salinidad esten entre el val. de
% salinidad reportado a 1-1.99db y que corrspondan a sal.(1-1.99db) 
% mas y menos 1 ups (a.k.a., sal.1m+1>sal.>sal.1m-1 & 2db>press>-2db).

if nargin==0
    name_file=proof_gui('Select a cnv1 Input File:')
    [lat,lon,gtime,data_cnv1,names,sensors]=cnv2mat(name_file);
elseif nargin==1
    name_file=path_cnv1;
    [lat,lon,gtime,data_cnv1,names,sensors]=cnv2mat(name_file);
end

[i_maxdata,j_maxdata]=find(data_cnv1(:,1)==max(data_cnv1(:,1)));
temp2=data_cnv1(1:i_maxdata(1,1),:); % Para tomar solo datos de ascenso

% -- Bloque de toma de datos del primer metro de profundidad

[i_1m,j_1m]=find(temp2(:,1)>=1 & temp2(:,1)<=1.99), pause,
sal_1m=mean(temp2(i_1m,4)), pause,

% Sentencia que filtra errores de toma de datos de sal. en superficie
% Comprende los que esten comprendidos entre:
% sal.1m+1>sal.>sal.1m-1 & 2db>press>-2db

temp2, [sal_1m-1,sal_1m+1,-2,2], pause,

[i1,j1]=find(temp2(:,4)>sal_1m-1 & temp2(:,4)<sal_1m+1 & temp2(:,1)>-2 & temp2(:,1)<=2);
temp3=temp2(i1,:);    

[i2,j2]=find(abs(temp3(:,1))==min(abs(temp3(:,1))));

if length(i2)>1, avg_0m=mean(temp3(i2,:)); else, avg_0m=temp3(i2,:); end

ts_0m=avg_0m;

% if length(i_1m)>1
%     sal_1m=mean(temp2(i_1m,4));
% else
%     sal_1m=temp2(i_1m,4);
% end
