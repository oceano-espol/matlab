function answ416=lacks_ostia_files(pathy,date_ini,date_fin)
% function answ416=lacks_ostia_files(pathy,date_ini,date_fin)
% 
% LACKS_OSTIA_FILES Buscador de datos faltantes de OSTIA
% Rutina especialmente disennada para buscar los archivos faltantes de
% OSTIA dado un rango de fechas establecidos en date_ini y date_fin.
% 
% Variables de entrada 
% 
%  date_ini = fecha inicial del rango [YYYY,MO,DY] /[DOUBLE]
%  date_fin = fecha final del rango [YYYY,MO,DY] /[DOUBLE]
%     pathy = path en donde la rutina actua /[STRINGS]
%
% Variables de salida
% 
%  answ416 = matriz de datos de salida de m*5 elementos /[DOUBLE]
%            01 COL, DNUM,       02 COL, DJUL        03 COL, YYYY
%            04 COL, MOTH        05 COL, DAYS

% 27/FEB/2012, Jonathan Cedeño, jcedeno@snriesgos.gob.ec

% dir2 = 
% 
% 227x1 struct array with fields:
%     name
%     date
%     bytes
%     isdir
%     datenum

% Mostra of the OSTIA name file
% ...
% 20100101-UKMO-L4HRfnd-GLOB-v01-fv02-OSTIA.nc

test_dir=exist(pathy,'dir');
if test_dir~=7, 
    error('El directorio no existe, meta bien el dedo SVP...'), 
end
tempy1=dir(pathy);

for i=1:length(tempy1)-2,
    str=tempy1(i+2).name,
    if ~strcmp(str(1:5),'bzip2'),
        year=sscanf(str(1:4),'%f');     moth=sscanf(str(5:6),'%f');
        days=sscanf(str(7:8),'%f');     date(i,:)=[year,moth,days];
        year=[]; moth=[]; days=[]; i,
    end
end

date_ini=[date_ini,0,0,0];      date_fin=[date_fin,0,0,0];
date_nm_ini=datenum(date_ini);  date_nm_fin=datenum(date_fin);

% getting "one day" differences
% ...
date_d1=datenum(2010,8,9);  date_d2=datenum(2010,8,10);
date_diff=date_d2-date_d1;

% This is the "reference TS".
% ...
date_st_num_REF=[datenum(date_nm_ini):date_diff:datenum(date_nm_fin)]';

% This is the "data TS".
% ...
for i=1:length(date(:,1)),
    date_st_num_DAT(i,:)=datenum(date(i,1),date(i,2),date(i,3),0,0,0);
end

for i=1:length(date_st_num_REF(:,1)),
    dtvec(i,:)=datevec(date_st_num_REF(i));
end

% date_st_num_REF --- DE LA SERIE REF. DISPUESTA POR DATE_INI/DATE_FIN
% date_st_num_DAT --- DE LOS ARCHIVOS QUE HAY EN EL <DIR>
% ...

% [date_st_num_REF,dtvec], pause,
whos date_st_num_DAT date_st_num_REF, pause,

julian_fact=1721059; j=1;

% searching for the lacking dates
% ...
for i=1:length(date_st_num_REF(:,1)),
    i_date=find(date_st_num_DAT==date_st_num_REF(i));
    if isempty(i_date),
        disp('este caso esta vacio'), pause,
        [yyyy,mo,dy]=datevec(date_st_num_REF(i));
        % (1) DNUM, (2) DJUL, (3) YYYY, (4) MOTH, (5) DAYS,
        answ416(j,:)=[date_st_num_REF(i),date_st_num_REF(i)+julian_fact,...
            yyyy,mo,dy];
        j=j+1;
    end
    yyyy=[]; mo=[]; dy=[];
end

