lc_OPeNDAP_ejemplo
% lc_OPeNDAP_ejemplo
% 
% LC_OPeNDAP LCs para la lectura de datos de altimetria satelital de
%            SSALTO-DUACS (DODS-OPeNDAP).

% directorio de trabajo: <C:\desktop_mh5\condor1\zmatlab_kw>

% Estas LCs también serviran para establecer un protocolo de lectura para
% datos geofísicos utilizando el OPeNDAP.

% -------------------------------------------------------------------------
% [1] identificar el link de acceso de datos. este ejemplo es corrido con
%     los datos de AVISO (SSALTO-DUACS).
%
%     http://opendap.aviso.altimetry.fr/thredds/dodsC/dataset-duacs-dt-upd-global-merged-msla-h-latlon-switched
%
%     este mismo enlace es el que debe de cargarse abajo, como variable 
%     <link>, para extraer los datos correspondientes.
%
%     OJO: al final, va sin la extensión .html !!!
%     ...

link='http://aviso-users:grid2010@opendap.aviso.altimetry.fr/thredds/dodsC/dataset-duacs-dt-upd-global-merged-msla-h-latlon-switched';
dods=loaddap('-A',link),

% -------------------------------------------------------------------------
% [2] correr la variable <dods>. allí apareceran los campos de datos que se
%     requieren para la extracción de datos. en el caso de AVISO, estas
%     variables son:
%
%     1) NbLongitudes = longitud [1080]
%     2)  NbLatitudes = latitud [915]
%     3)         time = tiempo [1087]
%     4)    Grid_0001 = msla (mean sea level anomalies)

% dods = 
% 
%                LatLon: [1x1 struct]
%           NbLatitudes: [1x1 struct]
%          NbLongitudes: [1x1 struct]
%             LatLonMin: [1x1 struct]
%            LatLonStep: [1x1 struct]
%                  time: [1x1 struct]
%             Grid_0001: [1x1 struct]
%     Global_Attributes: [1x1 struct]

% .........................................................................
%
%  [resumen de metadata]
%
%  variable extraida : anomalía del nivel medio del mar [cm]
%      res. temporal : semanal (7 dias)
%       res. espacio : 1/3 grado (~37 km)
%             tiempo : desde 1992-10-14 hasta 2013-08-07
% 
% .........................................................................

% -------------------------------------------------------------------------
% [3] extraccion de latitud-longitud
%     ...
lon_dc=loaddap([link,'?NbLongitudes[0:1079]']);
lat_dc=loaddap([link,'?NbLatitudes[0:914]']);

lonX=lon_dc.NbLongitudes;
latX=lat_dc.NbLatitudes;

% -------------------------------------------------------------------------
% [4] extracción del eje de tiempo
%     ...
time_dc=loaddap([link,'?time[0:1086]']);
timeX=time_dc.time;

% [4.1] correccion de la definicion de tiempo. 
%       utilizamos la funcion <udunits2datenum>
%
%       datenumbers = udunits2datenum(time,isounits)
%
%       <isounits> esta especificado, para los datos de aviso, en:
%       dods.time.units

time = udunits2datenum(timeX,'hours since 1950-01-01');

% -------------------------------------------------------------------------
% [5] extraccion de datos sobre el campo <Grid_0001>
%
% [5.1.1] sobre un solo punto de grilla. ----------------------------------
%       el ejemplo a continuacion indica un punto de grilla muy cercano a 
%       La Libertad (Ecuador). esta coordenada se almacena en la variable 
%       <pg>.

% pg.Position
% 
% ans =
% 
%           278.333333333306           -2.090515998686

% [5.1.2] se corre un <find> sobre lonX/latX para buscar en los archivos de
%       origen la ubicación de esta coordenada.

ilo=find(lonX==pg.Position(1)), ila=find(latX==pg.Position(2)),

% i_lon =
% 
%    836
%
% i_lat =
% 
%    452

% [5.1.3] extraccion de datos con <loaddap>
%         nomenclatura: [time_ini:time_fin][lat_ini:lat_fin][lon_ini:lon_fin]
%         el codigo de dato perdido en este caso esta dado por el valor
%         maximo de <sla>.

sla_llb=loaddap([link,'?Grid_0001[0:1086][451:451][835:835]']);
sla=sla_llb.Grid_0001.Grid_0001(:,:);
sla=nanfill(sla,max(max(sla)));

%                                 >-0-<

% [5.2.1] sobre un campo geografico, con descarga secuencial sobre el eje
%         de tiempo.
%         area : pacifico ecuatorial oriental ---> [180,360-77,-10,10]

box=[180,283,-10,10];

ilo=find(lonX>=box(1) & lonX<=box(2));
ila=find(latX>=box(3) & latX<=box(4));

i_lonlat=[ilo(1),ilo(length(ilo)),ila(1),ila(length(ila))]-1;

% [5.2.2] bucle para la descarga secuencial en tiempo
%         en los datos de aviso, el eje de tiempo tiene 1087 puntos
%         se acuerda un arreglo de 5 bloques de descarga, con 250 puntos de
%         tiempo cada uno.

% [0-250] x51...............................................................

idt=[0:1:250];
h = waitbar(0,'Please wait...');
for i=1:length(idt),
    sla_ty=loaddap([link,'?Grid_0001[',num2str(idt(i)),':',num2str(idt(i)),...
        '][',num2str(i_lonlat(3)),':',num2str(i_lonlat(4)),...
        '][',num2str(i_lonlat(1)),':',num2str(i_lonlat(2)),']']);
    sla_ty2=sla_ty.Grid_0001.Grid_0001(:,:); lost_cd=max(max(sla_ty2));
    sla_x51(:,:,i)=nanfill(sla_ty2,lost_cd);
    waitbar(i/length(idt),h); pause(1),
end
close(h), clear sla_ty2 sla_ty

% [251-500] x52............................................................

idt=[251:1:500];
h = waitbar(0,'Please wait...');
for i=1:length(idt),
    sla_ty=loaddap([link,'?Grid_0001[',num2str(idt(i)),':',num2str(idt(i)),...
        '][',num2str(i_lonlat(3)),':',num2str(i_lonlat(4)),...
        '][',num2str(i_lonlat(1)),':',num2str(i_lonlat(2)),']']);
    sla_ty2=sla_ty.Grid_0001.Grid_0001(:,:); lost_cd=max(max(sla_ty2));
    sla_x52(:,:,i)=nanfill(sla_ty2,lost_cd);
    waitbar(i/length(idt),h); pause(5),
end
close(h), clear sla_ty2 sla_ty

% [501-750] x53............................................................

idt=[501:1:750];
h = waitbar(0,'Please wait...');
for i=1:length(idt),
    sla_ty=loaddap([link,'?Grid_0001[',num2str(idt(i)),':',num2str(idt(i)),...
        '][',num2str(i_lonlat(3)),':',num2str(i_lonlat(4)),...
        '][',num2str(i_lonlat(1)),':',num2str(i_lonlat(2)),']']);
    sla_ty2=sla_ty.Grid_0001.Grid_0001(:,:); lost_cd=max(max(sla_ty2));
    sla_x53(:,:,i)=nanfill(sla_ty2,lost_cd);
    waitbar(i/length(idt),h); pause(5),
end
close(h), clear sla_ty2 sla_ty

% [751-1000] x54...........................................................

idt=[751:1:1000];
h = waitbar(0,'Please wait...');
for i=1:length(idt),
    sla_ty=loaddap([link,'?Grid_0001[',num2str(idt(i)),':',num2str(idt(i)),...
        '][',num2str(i_lonlat(3)),':',num2str(i_lonlat(4)),...
        '][',num2str(i_lonlat(1)),':',num2str(i_lonlat(2)),']']);
    sla_ty2=sla_ty.Grid_0001.Grid_0001(:,:); lost_cd=max(max(sla_ty2));
    sla_x54(:,:,i)=nanfill(sla_ty2,lost_cd);
    waitbar(i/length(idt),h); pause(5),
end
close(h), clear sla_ty2 sla_ty

% [1001-1086] x55..........................................................

idt=[1001:1:1086];
h = waitbar(0,'Please wait...');
for i=1:length(idt),
    sla_ty=loaddap([link,'?Grid_0001[',num2str(idt(i)),':',num2str(idt(i)),...
        '][',num2str(i_lonlat(3)),':',num2str(i_lonlat(4)),...
        '][',num2str(i_lonlat(1)),':',num2str(i_lonlat(2)),']']);
    sla_ty2=sla_ty.Grid_0001.Grid_0001(:,:); lost_cd=max(max(sla_ty2));
    sla_x55(:,:,i)=nanfill(sla_ty2,lost_cd);
    waitbar(i/length(idt),h); pause(5),
end
close(h), clear sla_ty2 sla_ty

% [6] concatenación de los cinco bloques

sla=cat(3,sla_x51,sla_x52,sla_x53,sla_x54,sla_x55);

%  -------------------------- presto!  ////////////////////////////////////





