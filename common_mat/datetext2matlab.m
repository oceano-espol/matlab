function answ321=datetext2matlab(data_in)
% function answ321=datetext2matlab(data_in)
%
% PRUEBA!!!

% Texto de entrada:
% 
% data_in = matriz de entrada de datos (m*2) [char]
%           Col. 1, Fecha (dd/mm/yyyy)
%           Col. 2, Hora (hh:mm:ss)

% is=findstr(str,':');
% isub=is+1:length(str);
% dm=sscanf(str(isub),'%f',2);

for i=1:length(data_in(:,1)),
    
    is_date=findstr(data_in{i,1},'/'); isub_dd=1:is_date(1)-1; 
    isub_mm=is_date(1)+1:is_date(2)-1; isub_yy=is_date(2)+1:length(data_in{i,1});
    
    is_hour=findstr(data_in{i,2},':');  isub_hh=1:is_hour(1)-1; 
    isub_mi=is_hour(1)+1:is_hour(2)-1; isub_ss=is_hour(2)+1:length(data_in{i,2});
    
    dm_date(i,:)=[sscanf(data_in{i,1}(isub_dd),'%f',2),...
        sscanf(data_in{i,1}(isub_mm),'%f',2),sscanf(data_in{i,1}(isub_yy),'%f',4)];
    dm_hour(i,:)=[sscanf(data_in{i,2}(isub_hh),'%f',2),...
        sscanf(data_in{i,2}(isub_mi),'%f',2),sscanf(data_in{i,2}(isub_ss),'%f',2)];
    
    date_num(i,:)=datenum([dm_date(i,3),dm_date(i,2),dm_date(i,1),...
        dm_hour(i,1),dm_hour(i,2),dm_hour(i,3)]);
        
end


whos, pause,

julian_fact=1721059;
answ321=[date_num,date_num+julian_fact,dm_date(:,3),dm_date(:,2),dm_date(:,1),dm_hour];

