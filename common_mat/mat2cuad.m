function [answ200,answ201]=mat2cuad(lon_mat,lat_mat,data_mat,xx,yy)
% function [answ200,answ201]=mat2cuad(lon_mat,lat_mat,data_mat,xx,yy)
%
% MAT2CUAD Transforma matrices MATLAB (que no incluye puntos de grilla sobre
% la costa) a matrices cuadradas que incluyen estos puntos.
% Esto es util para diversos calculos oceanograficos...
%
% 29JAN09, jcedeno@espol.edu.ec

v_maria=[180,285,-30,30]; 

vv_lonlat=[min(lon_mat),max(lon_mat),min(lat_mat),max(lat_mat)],

lon_new=vv_lonlat(1):xx:vv_lonlat(2); siz_lon=length(lon_new); lon_new=lon_new';
lat_new=vv_lonlat(3):yy:vv_lonlat(4); siz_lat=length(lat_new); lat_new=lat_new';

[lat_cc,lon_cc]=convertidora_lonlat(lat_new,lon_new);

% subplot(2,1,1), coastmap(v_maria,'nofill',10); hold on, plot(lon_mat,lat_mat,'b*'),
% subplot(2,1,2), coastmap(v_maria,'nofill',10); hold on, plot(lon_cc,lat_cc,'b*'),

% ahora, a testar puntos!!!

for i=1:length(lon_cc)

    ii=[]; jj=[];

    [ii,jj]=find(lon_mat==lon_cc(i) & lat_mat==lat_cc(i));

    if isempty(ii)==1 && isempty(jj)==1

        answ200(i,:)=NaN;
        answ202(i,:)=0;

    else

        answ200(i,:)=data_mat(ii);
        answ202(i,:)=1;

    end

end

answ201=reshape(answ200',siz_lon,siz_lat); size(answ201),

size(answ200), 
        
ii_isNaN=isnan(answ200); [i_True,j_True]=find(ii_isNaN==1);

% figure, 
% subplot(1,2,1), coastmap(v_maria,'nofill',10); hold on, text(lon_cc(i_True),lat_cc(i_True),'NaN'),
% subplot(1,2,2), coastmap(v_maria,'nofill',10); hold on, contourf(lon_new,lat_new',answ201'); colorbar
        
answ201=[lon_cc,lat_cc];

