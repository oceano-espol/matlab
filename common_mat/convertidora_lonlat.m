function [lon_cc,lat_cc]=convertidora_lonlat(lon,lat);
%function [lon_cc,lat_cc]=convertidora_lonlat(lon,lat);
% Convertidora - LCs para transformar LatLong ref. a LatLong st.
%
% Lineas de Comando para convertir los datos de
% referencia de Longitud y Latitud a series de
% tiempo (de oscar.nc, archivo tipo netCDF).

[i_lon,j_lon]=size(lon);
[i_lat,j_lat]=size(lat);

%--------- latitud

ones_lat=ones(i_lat,i_lon);
% h = waitbar(0,'Please wait...');
for i=1:i_lon;
    ones_lat(:,i)=ones_lat(:,i).*lat;
    % waitbar(i/i_lon)
end
% close(h); 
[i,j]=size(ones_lat); 

lat_cc=reshape(ones_lat,i*j,1);

%------ longitud

ones_lon=ones(i_lat,i_lon);
% h = waitbar(0,'Please wait...');
for i=1:i_lat;
    ones_lon(i,:)=ones_lon(i,:).*lon';
    % waitbar(i/i_lon)
end
% close(h);
[i,j]=size(ones_lon); 

lon_cc=reshape(ones_lon,i*j,1);