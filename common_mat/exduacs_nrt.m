function [sl,tm,lola]=exduacs_nrt(lon,lat)
% function [sl,tm,lola]=exduacs_nrt(lon,lat)
%
% EXDUACS_NRT Extractora de SL Duacs, en tiempo real
%
% lon y lat deben significar solamente un punto de grilla
% retorna los datos de SLA de Aviso/Duacs 1024 correspondientes al punto de
% grilla más cercano.
%
% si el punto de grilla es equidistante con respecto a la referencia,
% retorna el punto izquierdo-abajo más cercano

% 18\aug\2105, jcedeno@udec.cl

link='http://aviso-users:grid2010@opendap.aviso.altimetry.fr/thredds/dodsC/dataset-duacs-nrt-over30d-global-allsat-msla-h';
dods=loaddap('-A',link);

lon_dc=loaddap([link,'?lon[0:1439]']);  % max=1440
lat_dc=loaddap([link,'?lat[0:719]']);   % max=720

lonX=lon_dc.lon; clear lon_dc
latX=lat_dc.lat; clear lat_dc

% tmsz, time size
%       para retornar la mayor dimension posible del tiempo
%       (es decir, el último dato disponible)
tmsz=dods.time.DODS_ML_Size;

time_dc=loaddap([link,'?time[0:',num2str(tmsz-1),']']);
timeX=time_dc.time; clear time_dc
% ---
time = udunits2datenum(timeX,'days since 1950-01-01 00:00:00 UTC');
time_vec=datevec(time); time=[time,time_vec(:,1:3)];  clear time_vec timeX
tm=time(:,1);

[~,ixlo]=min(abs(lonX-lon));
[~,ixla]=min(abs(latX-lat));

% [time] [latitude] [longitude]
NaNf=dods.sla.ml__FillValue; 
Sclf=dods.sla.scale_factor;
ty=loaddap([link,'?sla[0:',num2str(tmsz-1),'][',num2str(ixla-1),...
    ':',num2str(ixla-1),'][',num2str(ixlo-1),':',num2str(ixlo-1),']']);
ty2=squeeze(ty.sla.sla);
ty2=nanfill(ty2,NaNf);  sl=ty2.*Sclf*100;  % SLA, en cm

lola=[ty.sla.lon,ty.sla.lat];

