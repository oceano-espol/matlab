function [dms_lat,dms_lon]=dec2hms_scr(data)
%function [dms_lat,dms_lon]=dec2hms_scr(data)
% Prueba!!!
% Col. 1, Latitud, Col. 2, Longitud
% Si se ingresa lat y longitud, flag=2
% Si se ingresa solo una columna, flag=1

[siz_i,siz_j]=size(data);
if siz_j==2, flag=2; elseif siz_j==1, flag=1; end
data_abs=abs(data);

for i1=1:2
    j=1;
    for i2=1:siz_i
        deg_data(j,1)=floor(data_abs(j,i1));
        mins=rem(data_abs(j,i1),1)*60; min_data(j,1)=floor(mins);
        seg_data_w(j,1)=rem(mins,1)*60;
        j=j+1; mins=[]; 
    end
    if i1==1, dms_lat=[deg_data,min_data,seg_data_w]; end
    if i1==2, dms_lon=[deg_data,min_data,seg_data_w]; end
    deg_data=[]; min_data=[]; seg_data_w=[];
end
