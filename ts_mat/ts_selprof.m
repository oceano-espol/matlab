function out=ts_selprof(data)
% function out=ts_selprof(data)
%
% TS_SELPROF Seleccionador de profundidades
%            Submuestrea un set de datos de T,S para mostrar 
%            "profundidades estándar", que permitirá reducir la cantidad
%            de informacion mostrada para los analisis requeridos.
%
% Variables de entrada:
%           data = set de datos
%                  1era columna, profundidad (positiva)
%                  2da  columna, temperatura
%                  3era columna, salinidad
%
% Variables de salida:
%            out = set de datos re-muestreado
%                  1era columna, profundidad (positiva)
%                  2da  columna, temperatura
%                  3era columna, salinidad

% 22JAN2019, jcedeno@espol.edu.ec

prof=[0,10,20,30,50,75,100,125,150,200,250,300,400,500,600,700,800,900,...
    1000,1100,1200,1300,1400,1500,1750,2000,2500,3000,3500,4000]';

N=length(prof);

% no. variables efectivas: no. columnas menos 1
ncol=length(data(1,:))-1;

for i=1:N
    ix=find(data(:,1)==prof(i));
    if isempty(ix)~=1
        out(i,:)=data(ix,:);
    else
        tp_ty=interp1(data(:,1),data(:,2),prof(i));     % temperature
        sa_ty=interp1(data(:,1),data(:,3),prof(i));     % salinity
        out(i,:)=[prof(i),tp_ty,sa_ty];
    end
end