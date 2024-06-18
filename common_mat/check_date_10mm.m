function out=check_date_10mm(date_ini,date_fin,data)
% function out=check_date_10mm(date_ini,date_fin,data)
%
% Variables de entrada:
%
%    date_ini = fecha inicial (año, mes, dia)
%               [yy,mo,dy]
%    date_fin = fecha final (año, mes, dia)
%               [yy,mo,dy]
%        data = data (dos columnas)
%               (1) fecha matlab
%               (2) data
%
% Variables de salida:
%
%         out = matriz de datos de salida (8 columnas)
%               (1) fecha matlab, (2) yy, (3) mo, (4) dy
%               (5) hh, (6) mm, (7) ss, (8) data
%   

% fecha secuenciada
date_seq=secq_date_10mm(date_ini,date_fin);

% fecha referencial
date_ref=data(:,1);
% data referencial
data_ref=data(:,2);

for i=1:length(date_seq(:,1)),
    ifind=find(date_ref(:,1)==date_seq(i,1));
    if isempty(ifind)~=1,
        data_seq(i,:)=data_ref(ifind);
    else
        data_seq(i,:)=NaN;
    end
end

out=[date_seq,data_seq];

function out=secq_date_10mm(date_ini,date_fin)
% function out=secq_date_10mm(date_ini,date_fin)
%
% SECQ_DATE_10MM Secuenciador de 10 minutos

dini=datenum(date_ini);
dfin=datenum(date_fin)+1;

fact=10/60/24;

date_st=dini:fact:dfin;

out=datevec(date_st);
out=[date_st',out];
out=out(1:end-1,:);