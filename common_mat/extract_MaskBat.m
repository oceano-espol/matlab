function [answ76]=extract_MaskBat(data_lt,xyz)
%function [answ76]=extract_MaskBat(data_lt,xyz)
% 
% EXTRACT_MASKBAT Extractora de coordenada z segun
% orientacion de la transecta.
% Usada para el informe de Crucero Regional CPPS 2007
% bajo la coordinacion del Instituto Nacional de Pesca

% 2007, Jonathan Cedeno, jcedeno@espol.edu.ec

dist=350;

if data_lt(1,2)==data_lt(2,2)
    disp('transecta sobre latitud')
    ini=data_lt(1,1); fin=data_lt(2,1);
    strs_lon=ini-(dist/60):0.03:ini;
    strs_lat=ones(1,length(strs_lon)).*data_lt(1,2);
elseif data_lt(1,2)~=data_lt(2,2)
    disp('transecta oblicua')
    angle=(atan((data_lt(1,2)-data_lt(2,2))/(data_lt(1,1)-data_lt(2,1))))*(180/pi);
    length_lon=cos(angle*(pi/180))*dist; length_lat=sin(angle*(pi/180))*dist;
    strs_lon=data_lt(1,1)-(length_lon/60) : abs((data_lt(1,1)-(length_lon/60))-data_lt(1,1))/60 : data_lt(1,1);
    strs_lat=data_lt(1,2)-(length_lat/60) : abs((data_lt(1,2)-(length_lat/60))-data_lt(1,2))/60 : data_lt(1,2);
end

[c,v,x_out,y_out]=grid_interp([xyz(:,1),xyz(:,2),xyz(:,3)],0.03,0.03);

zi1=interp2(x_out,y_out,c,strs_lon',strs_lat');

for i=1:length(strs_lon)
    if zi1(i)<-500, zi2(i,:)=-500; else, zi2(i,:)=zi1(i); end
end

answ76=[strs_lon',strs_lat',zi1,zi2];

% plot(answ76(:,1),answ76(:,4)), 