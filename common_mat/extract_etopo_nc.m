function [lon_d,lat_d,bat]=extract_etopo_nc(v,flag)
%function [lon_d,lat_d,bat]=extract_etopo_nc(v,flag)
%
% EXTRACT_ETOPO_NC Extractor de un subset de datos de elevacion de ETOPO2MIN
% Utilidad para extraer un subset de datos de elevacion delimitado por
% [lon_min,lon_max,lat_min,lat_max], proveniente de la base de datos
% ETOPO2MIN de NOAA.
%
% Variables de Entrada:
%
%     v = [lon_min,lon_max,lat_min,lat_max]
%         Formato de longitud: +/- 180
%  flag = 'elev', elevacion / 'bati', batimetria
%
% Variables de Salida:
%
% lon_d = Longitud de salida ETOPO2MIN recortada
% lat_d = Longitud de salida ETOPO2MIN recortada
%   bat = Elevacion/Batimetria ETOPO2MIN recortada
%
% 07/DEC/2008, Jonathan Cede�o at Instituto Nacional de Pesca
% 30/AGO/2010, Jonathan Cede�o at Instituto Oceanografico de la Armada
% Prueba!!!

if strcmp(computer,'GLNX86')==1,
    pwdB='/media/jonathan/lqsa/J577/zmatlab/mapping2/ETOPO2v2g_f4.nc';
elseif strcmp(computer,'PCWIN')==1,
    pwdB='D:/J577/zmatlab/mapping2/ETOPO2v2g_f4.nc';
end

nc=netcdf(pwdB);

% path_cnv1=proof_gui('Select a *.nc Input File:');
% nc=netcdf(path_cnv1);

lon_nc=nc{'x'}(:,:); lat_nc=nc{'y'}(:,:);

if v(1)>180, v(1)=v(1)-360, end
if v(2)>180, v(2)=v(2)-360, end

[i_lon,j_lon]=find(lon_nc>=v(1) & lon_nc<=v(2));
[i_lat,j_lat]=find(lat_nc>=v(3) & lat_nc<=v(4));

lon_nc2=lon_nc(i_lon); [max(lon_nc2),min(lon_nc2)];
lat_nc2=lat_nc(i_lat); [max(lat_nc2),min(lat_nc2)];

[ic_lon,ic_lat]=convertidora_lonlat_heavy(i_lon,i_lat);
[lon,lat]=convertidora_lonlat_heavy(lon_nc2,lat_nc2); 
[max(lon),min(lon)]; [max(lat),min(lat)];

% nc{'z'} = ncfloat('y', 'x'); %% 58336201 elements.

if strcmp(flag,'elev'),

    j=1;
    h = waitbar(0,'Espera carajo!...');
    for i=1:length(ic_lon)
        bat_pre=nc{'z'}(ic_lat(i),ic_lon(i));
        if bat_pre>=0,
            lon_d(j,:)=lon(i); lat_d(j,:)=lat(i); bat(j,:)=bat_pre;
            j=j+1; % disp('j')
        end
        waitbar(i/length(lon),h)
    end
    close(h)

elseif strcmp(flag,'bati')

    j=1;
    h = waitbar(0,'Espera carajo!...');
    for i=1:length(ic_lon)
        bat_pre=nc{'z'}(ic_lat(i),ic_lon(i));
        if bat_pre<=0,
            lon_d(j,:)=lon(i); lat_d(j,:)=lat(i); bat(j,:)=bat_pre;
            j=j+1; % disp('j')
        end
        waitbar(i/length(lon),h)
    end
    close(h)

end