function plot_tsd(sst,sst_sbe21,sss_sbe21)
%function plot_tsd(sst,sst_sbe21,sss_sbe21)
% Esta rutina permite la generacion de un reporte impreso que incluye
% un grafico de temperatura/salinidad y los datos correspondientes a
% estas variables, ademas de densidad, segun las profundidades estandares
% muestreadas a bordo del B/I Tohalli, del Instituto Nacional de Pesca.
% (1) El grafico del reporte impreso se basa en el procesamiento de los datos
% crudos (cnv1) segun la rutina <binavg>, con un binsize de 1 db.
% (2) Los datos del reporte impreso se basan en el procesamiento de los
% datos del archivo cnv2, ya pre-procesados por el software
% SBEDataProcessing-Win32 / binaverage, con un binsize de 5 db. De estos, la
% rutina <prosc_cnv2> elige el perfil de ascenso y extrae los datos mas
% cercanos a la superficie. Adicionalmente, los datos reportados de las 
% profundidades de las isotermas de 20°C/15°C y de la capa de mezcla son 
% segun la rutina <isotermas_cnv>.
% (3) Se incluye tambien la utilizacion de la funcion <levitus_ext>, que extrae
% las anomalias de T/S segun la climatologia de Levitus, 1998 para las
% profundidades estandares definidas por esta, guardandola luego en un
% archivo de texto bajo el directorio de trabajo definido por el ususario.
%
% CALLS: proof_gui, cnv2mat, binavg, prosc_cnv2, isotermas_cnv, floatAxisX,
%        levitus_ext
% SPECIAL TOOLBOXES CALLS: sbe_mat, levitus_ts, dbe_freq, floatAxis,
%        oc_pilar

% 30/Sept/2007, Jonathan Cedeño, jcedeno@espol.edu.ec
% 03/Augt/2008, Updated & Corrected

warning off MATLAB:divideByZero, format bank

path_cnv1=proof_gui('Select a cnv1 Input File:');
path_cnv2=proof_gui('Select a cnv2 Input File:');
[lat,lon,gtime,data_cnv1,names,sensors,cruise,station,cast,sn,cal_date]=cnv2mat(path_cnv1);
[data_1m,desc_1m,asce_1m,align_1m]=binavg(data_cnv1,1);
[data_binavg5_asc]=prosc_cnv2(path_cnv1,path_cnv2);
[yi_temp20,yi_temp15,yi_ml]=isotermas_cnv(data_binavg5_asc);

align_1m, data_binavg5_asc, pause,

press=[0 10 30 50 75 100 150 200 250 300 400 500]; press=press';
find_i=find(press>max(data_binavg5_asc(:,1)));
press_sel=press(1:find_i(1,1)-1,:);

for i=1:length(press_sel)
    ii=find(data_binavg5_asc(:,1)==press_sel(i,1));
    data_std(i,:)=[data_binavg5_asc(ii,1),data_binavg5_asc(ii,3),data_binavg5_asc(ii,4),data_binavg5_asc(ii,5)];
end

data_std, pause,

densBuckt_0m=sw_dens(data_std(1,3),sst,data_std(1,1));  % dens = sw_dens(S,T,P)
ctd_0m=[0,sst,data_std(1,3),densBuckt_0m-1000];
data_std_uncorr=data_std; data_std_corr=[ctd_0m;data_std(2:length(data_std(:,1)),:)];

temp_char=sprintf('%03.0f    %07.4f    %07.4f    %07.4f\n',data_std_corr');

% plot temperature vs pressure
subplot(1,2,2)
hl1=plot(align_1m(:,4),align_1m(:,1)*-1,'b-'); grid on,
ax1=gca; set(ax1,'XMinorTick','on', 'box','on','xcolor',get(hl1,'color'))
% htitle = title(['CTD Profile, ',station,', ',cruise,'. ',num2str(lat),' LAT / ',num2str(lon),' LON. Date ',...
%         gtime_char],'fontweight','bold');
xlabel('Temperature'), ylabel('Depth (db)')

% adding 1st floating axis for the second parameter (salinity) plotted
[hl2,ax2,ax3] = floatAxisX(align_1m(:,5),align_1m(:,1)*-1,'r','Salinity');

subplot(1,2,1), 
text(-0.1,1.05,['%SBE19 CTD Profile, ',station,', ',cruise],'fontweight','bold')
text(-0.1,1.00,['%SN: ',sn,', CAL.DATE: ',cal_date,', CAST: ',cast],'fontweight','bold')
text(-0.1,0.95,['%cnv1_file: ',path_cnv1],'fontsize',8,'fontweight','bold')
text(-0.1,0.90,['%cnv2_file: ',path_cnv2],'fontsize',8,'fontweight','bold')
text(-0.1,0.85,['%LATITUDE: ',num2str(lat,'%+09.4f'),', LONGITUDE: ',num2str(lon,'%+09.4f')],'fontweight','bold')
text(-0.1,0.80,['%Start acquisition data at: ',datestr(gtime)],'fontweight','bold')
text(-0.1,0.75,['%DepthMixLayer: ',num2str(yi_ml,4),'db'],'fontweight','bold')
text(-0.1,0.70,['%DepthIs20°C: ',num2str(yi_temp20,4),'db, DepthIs15°C: ',num2str(yi_temp15,4),'db'],...
    'fontweight','bold')
text(-0.1,0.65,['%SST Bucket: ',num2str(sst,'%05.2f'),'ºC'],'fontweight','bold')
text(-0.1,0.60,['%SST SBE21: ',num2str(sst_sbe21,'%05.2f'),'ºC, SSS SBE21: ',num2str(sss_sbe21,'%05.2f'),'ups'],...
    'fontweight','bold')
text(-0.1,0.55,['%SST CTD: ',num2str(data_std(1,2),'%05.2f'),'ºC, SSS CTD: ',num2str(data_std(1,3),'%05.2f'),'ups'],...
    'fontweight','bold')
text(-0.1,0.49,'db      Temp.          Sal.           \sigma-t','fontweight','bold')
text(-0.1,0.45,temp_char,'VerticalAlignment','top')
axis off

% portrait,
% gtime_char=char([num2str(gtime(1,1)),'/',num2str(gtime(1,2)),'/',num2str(gtime(1,3)),', ',...
%     num2str(gtime(1,4)),':',num2str(gtime(1,5)),':',num2str(gtime(1,6))]);

if strcmp(station,'ESM') || strcmp(station,'GAL') || strcmp(station,'GLR') || strcmp(station,'LOP') || strcmp(station,'PLP')
    root_fname=['vrclim_',num2str(gtime(1,1),'%4.0f'),'_',num2str(gtime(1,2),'%02.0f'),'_',num2str(gtime(1,3),'%02.0f')];
else
    root_fname=[cruise,'_',num2str(gtime(1,1),'%4.0f'),'_',num2str(gtime(1,2),'%02.0f'),'_',num2str(gtime(1,3),'%02.0f')];
end

k=menu('Do you want to print & save the report?','print & save','no print & save','no print & no save');

if (k==1),
    print, print('-dtiff','-r300',['ctdReport_',station,'_',root_fname])
    [ts_fprint]=levitus_ext(gtime(2),1,sst,sst_sbe21,sss_sbe21,path_cnv1,path_cnv2);
    disp(['el reporte fue impreso y guardado como imagen bajo el nombre: ctdReport_',station,'_',root_fname,'.tiff']);
    disp(['el reporte fue guardado como texto bajo el nombre: ctdReport_',station,'_',root_fname,'.txt']);
elseif (k==2),
    print('-dtiff','-r300',['ctdReport_',station,'_',root_fname])
    [ts_fprint]=levitus_ext(gtime(2),1,sst,sst_sbe21,sss_sbe21,path_cnv1,path_cnv2);
    disp(['el reporte no fue impreso y guardado como imagen bajo el nombre: ctdReport_',station,'_',root_fname,'.tiff']);
    disp(['el reporte fue guardado como texto bajo el nombre: ctdReport_',station,'_',root_fname,'.txt']);
elseif (k==3),
    disp('el reporte no fue impreso ni guardado');
end

