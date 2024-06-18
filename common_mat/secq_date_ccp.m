function answ315=secq_date_ccp(date_ini,date_fin)
% function answ315=secq_date_ccp(date_ini,date_fin)
%
% SECQ_DATE_CCP Secuenciador de fechas (diarias)
%
% Variable de Entrada:
%
%    date_ini = referencia de fecha inicial (1*3)
%               [yyyy,mo,dy]
%    date_fin = referencia de fecha final (1*3)
%               [yyyy,mo,dy]
%
% Variables de Salida:
%
%     answ315 = matriz de salida de datos (m*5)
%               1 Col., DNUM Julian_Matlab
%               2 Col., DJUL Julian_Tmplt
%               3 Col., YYYY Julian_Tmplt
%               4 Col., MOTH Julian_Tmplt
%               5 Col., DAYS Julian_Tmplt

% 22/FEB/2012, Jonathan Cedeño, jcedeno@snriesgos.gob.ec

date_ini=[date_ini,0,0,0];
date_fin=[date_fin,0,0,0];

date_nm_ini=datenum(date_ini);  date_nm_fin=datenum(date_fin);

% getting "one day" differences
% ...
date_d1=datenum(2010,8,9);  date_d2=datenum(2010,8,10);
date_diff=date_d2-date_d1;

% This is the "reference TS".
% ...
date_st_num_REF=[datenum(date_nm_ini):date_diff:datenum(date_nm_fin)]';

julian_fact=1721059;

% size(date_st_num_REF), size(date_st_num_DAT),
% [date_st_num_REF(1:10,:),date_st_num_DAT(1:10,:)],
% ...
for i=1:length(date_st_num_REF(:,1)),
    [yyyy,mo,dy]=datevec(date_st_num_REF(i));
    % (1) DNUM, (2) DJUL, (3) YYYY, (4) MOTH, (5) DAYS,
    answ315(i,:)=[date_st_num_REF(i),date_st_num_REF(i)+julian_fact,...
        yyyy,mo,dy];
    yyyy=[]; mo=[]; dy=[];
end



