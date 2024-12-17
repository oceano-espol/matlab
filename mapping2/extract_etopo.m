function answ55=extract_etopo(data)
%function answ55=extract_etopo(data)
% Prueba!!!
%
% 1era. Columna, Latitud
% 2do.  Columna, Longitud

load etopo2min.mat

[c,v,x_out,y_out]=grid_interp([bat_etopo2min_ecu(:,1),bat_etopo2min_ecu(:,2),bat_etopo2min_ecu(:,3)],0.02,0.02);

answ55=interp2(x_out,y_out,c,360+data(:,2),data(:,1));