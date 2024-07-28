function [i_coef,answ49]=nearest_lonlat(lon_ec,lat_ec,lon,lat)
%function [i_coef,answ49]=nearest_lonlat(lon_ec,lat_ec,lon,lat)
% NEAREST_LONLAT Buscador de coordenadas mas cercanas
% Esta funcion realiza la busqueda de los puntos de coordenadas
% mas cercanos a partir de una registro de lat y lon previamente
% establecido.
%
% Las variables de entrada son:
%
% lon_ec/lat_ec = Registros de Latitud y Longitud base
%                 (Estos son los referenciales). El formato de la 
%                  longitud es de -180/180.
%       lon/lat = Registros de Latitud y Longitud de la cual
%                 se requiera buscar su cercania.
%                 (Estos son los objetivos). El formato de la 
%                 longitud es de -180/180.
%
% Las variables de salida son:
%
%        i_coef = Coeficiente i que ubica en la dimension de las filas de
%                 lon_ec/lat_ec los valores mas cercanos a lon/lat.
%        answ49 = Matriz de salida
%                 1era. Col., lon (de la variable de entrada)
%                 2da.  Col., lat (de la variable de entrada)
%                 3era. Col., lon_ec_near (coord. mas cercana de lon_ec para lon)
%                 4ta.  Col., lat_ec_near (coord. mas cercana de lat_ec para lat)
%                 5ta.  Col., distancia entre lon/lat y puntos mas cercanos
%                 de lon_ec_near/lat_ec_near
%
% La rutina mas jodida de crear!!!

% Terminada probablemente hacia 2007, para dar soporte la Tesis "Validación
% de tres productos de precipitacion en la costa ecuatoriana", así como a
% la rutina <plot_tsd>, para su uso en el Instituto Nacional de Pesca
% -Jonathan Cedeño, jcedeno@espol.edu.ec

cnst_deg2km=(10e6/90);
siz_lon_ec=length(lon_ec);
siz_lon=length(lon);

answ49=zeros(siz_lon,5); % edited 2019-03-17
i_coef=zeros(siz_lon,1);

j=1; h = waitbar(0,'patientez s''il vous plaît...');
for i=1:siz_lon
    temp1=lat(j,1).*ones(siz_lon_ec,1); temp2=lon(j,1).*ones(siz_lon_ec,1);
    rng1=distance(temp1(:,1),temp2(:,1),lat_ec(:,1),lon_ec(:,1));
    [i_u,j_u]=find(rng1==min(rng1)); length_i_u=length(i_u);
    if length_i_u>1 & length_i_u<3 & lon_ec(i_u(1))==lon_ec(i_u(2)), disp('lon')
        [i_u1,j_u1]=find(lat_ec(i_u)==min(lat_ec(i_u)));
        [i_u2,j_u2]=find(lat_ec(:,1)==lat_ec(i_u(i_u1)) & lon_ec(:,1)==lon_ec(i_u(1)));
    elseif length_i_u>1 & length_i_u<3 & lat_ec(i_u(1))==lat_ec(i_u(2)), disp('lat')
        [i_u1,j_u1]=find(lon_ec(i_u)==min(lon_ec(i_u)));
        [i_u2,j_u2]=find(lon_ec(:,1)==lon_ec(i_u(i_u1)) & lat_ec(:,1)==lat_ec(i_u(1)));
    elseif length_i_u==4 disp('lonlat')
        [i_u1,j_u1]=find(lon_ec(i_u)==min(lon_ec(i_u)) & lat_ec(i_u)==min(lat_ec(i_u)));
        [i_u2,j_u2]=find(lon_ec(:,1)==lon_ec(i_u(i_u1)) & lat_ec(:,1)==lat_ec(i_u(i_u1)));
    else
        i_u2=i_u;
    end
    answ49(j,:)=[lon(j,1),lat(j,1),lon_ec(i_u2,1),lat_ec(i_u2,1),...
            rng1(i_u2,1)*cnst_deg2km];
    i_coef(j,:)=i_u2;
    j=j+1; temp1=[]; i_u=[]; j_u=[]; temp_2=[]; rng1=[];
    waitbar(i/siz_lon,h),
end
close(h);
