function [answ99,timing]=mission_calc(data,flag)
%function [answ99,timing]=mission_calc(data,flag)
% 
% MISSION_CALC Calculadora de Mision de Cruceros Oceanograficos
% Esta rutina calcula los tiempos totales entre recorrido de estaciones y
% tiempo de trabajo en cada estación oceanografica.
%
% Variables de Entrada:
%
%    data = Matriz de datos de entrada [double]
%           Col. 1, Codigo estacion tipo
%           Col. 2, Numero de estacion secuencial
%           Col. 3, Latitud en grados/f
%           Col. 4, Longitud en grados/f
%           Col. 5, Profundidad del sitio
%    flag = 1, Salida completa con estimados de tiempo en estaciones
%              bajo la asumpcion de que todas las estaciones son completas
%           2, Salida resumida solo con estimadas de distancia entre
%              estacion y estacion
%
% Variables de Salida:
%
%  answ99 = Matriz de datos de salida [double]
%           Col. 1, Distancia entre estaciones en metros 
%           Col. 2, Distancia entre estaciones en millas náuticas
%           Col. 3, Delta de tiempo entre estaciones en horas/f
%           Col. 4, Delta de tiempo entre estaciones en horas (°)
%           Col. 5, Delta de tiempo entre estaciones en minutos (')
%
% Sept/2008, Jonathan Cedeño at Instituto Nacional de Pesca
%  Ago/2010, Jonathan Cedeño at Instituto Ocenográfico de la Armada

% answ99=[dist_m,dist_nm,[0;time_hours],[0;dm_lat(:,1)],[0;dm_lat(:,2)]];

if nargin<2, flag=1; end

if flag==1,
    
    vel_rv_kt=8; vel_rv_ms=(((10e6/90)/60)/3600)*vel_rv_kt;
    tasa_desc=0.40; t_redes=0.75; t_ini=20;

    if length(data(1,:))~=5, error('data input is incorrect, SVP check the input!!!'), end

    siz_i=length(data(:,1));
    for i=1:siz_i
        if data(i,5)<-500,
            prof_m(i,:)=-500;
        else
            prof_m(i,:)=data(i,5);
        end
    end

    dist_m1=dist_whoi(data(:,3),data(:,4)); dist_m1=dist_m1';
    dist_m=[0;dist_m1];
    dist_nm=dist_m./((10e6/90)/90);
    time_hours=(dist_m1./vel_rv_ms)/3600; dms_lat=dec2hms([time_hours,time_hours]);
    dm_lat=[dms_lat(:,1),(dms_lat(:,2)+(dms_lat(:,3)./60))];
    t_roseta=((((prof_m.*2)./tasa_desc)./3600)*-1)+(t_ini/60);
    t_estacion=t_roseta+t_redes;
    t_EstRec=t_estacion+[0;time_hours];
    answ99=[prof_m,dist_m,dist_nm,[0;time_hours],[0;dm_lat(:,1)],[0;dm_lat(:,2)],...
        t_roseta,ones(siz_i,1).*t_redes,t_estacion,t_EstRec];
    
elseif flag==2,
    
    vel_rv_kt=8; vel_rv_ms=(((10e6/90)/60)/3600)*vel_rv_kt;
    dist_m1=dist_whoi(data(:,3),data(:,4)); dist_m1=dist_m1'; dist_m=[0;dist_m1]; % pause    
    dist_nm=dist_m./((10e6/90)/90);
    time_hours=(dist_m1./vel_rv_ms)/3600; dms_lat=dec2hms([time_hours,time_hours]);
    dm_lat=[dms_lat(:,1),(dms_lat(:,2)+(dms_lat(:,3)./60))];
    answ99=[dist_m,dist_nm,[0;time_hours],[0;dm_lat(:,1)],[0;dm_lat(:,2)]];
    timing=dec2hms([sum(answ99(:,3)),sum(answ99(:,3))]);
    
else
    
    error('flag unknow, SVP check the input!!!')
    
end

% for i=1:siz_i
    