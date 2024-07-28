function [answ58,lon,lat,gtime,cruise,station]=prosc_cnv2(path_cnv1,path_cnv2)
%function [answ58,lon,lat,gtime,cruise,station]=prosc_cnv2
% PROSC_CNV2 Procesamiento del archivo cnv2 de CTDs SeaBird
% Esta funcion procesa en automatico los archivos *.cnv de los
% CTD SeaBird luego de haber sido procesado por el programa 
% binavg de la suite SBE Data Procesing Win32.
% El binsize asumido para el binavg es de 5 dbar.
% Incluye la fila de valores mas cercana a la superficie.
%
% La variable de salida es:
%
% answ58 = Matriz de datos de salida correspondiente al
%          perfil de ascenso mas la fila de datos
%          correspondiente a 0db.

% Entrada de Datos

if nargin==0
    [ts_0m,lon,lat]=ext_0m; ts_0m(1,1)=0;
    name_file=proof_gui('Select a cnv2 Input File:')
    [lat,lon,gtime,data,names,sensors,cruise,station]=cnv2mat(name_file);
elseif nargin==1
    [ts_0m,lon,lat]=ext_0m(path_cnv1); ts_0m(1,1)=0;
    name_file=proof_gui('Select a cnv2 Input File:')
    [lat,lon,gtime,data,names,sensors,cruise,station]=cnv2mat(name_file);
elseif nargin==2
    [ts_0m,lon,lat]=ext_0m(path_cnv1); ts_0m(1,1)=0;
    [lat,lon,gtime,data,names,sensors,cruise,station]=cnv2mat(path_cnv2);
end

% -------------------------------------------------

press=[0 10 30 50 75 100 150 200 250 300 400 500]; press=press';
bin_patron1=[0:5:600]; bin_patron1=bin_patron1';

max_press=max(data(:,1));

temp=(max_press.*ones(length(bin_patron1),1))-bin_patron1;
[i1,j1]=find(temp>0); [i2,j2]=find(temp(i1)==min(temp(i1)));
top_bin=bin_patron1(i2);
[i_ch,j_ch]=find(data(:,1)==top_bin);

data_choose=data(i_ch+1:length(data),:);  % Para el perfil de ascenso
% data_choose=data(1:i_ch+1,:);             % Para el perfil de descenso

answ58=[data_choose;ts_0m]; answ58=sortrows(answ58,1);