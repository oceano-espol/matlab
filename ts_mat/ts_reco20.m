function [y,y_time,lost,pve]=ts_reco20(data,segm)
% function [y,y_time,lost,pve]=ts_reco20(data,segm)
%
% TS_RECO20 Reconstruccion de una serie de tiempo por 20 armonicos
% 
% PRUEBA!!!

N=length(data(:,1));
n_segm=floor(N/segm);       % Numero de segmentos a calcular

T=segm./[1:1:20];           % Definicion de los 20 periodos armonicos
cut=30;                     % Umbral de corte para la ejec. de RECO

data_sel=data(1:n_segm*segm,:);

time_rs=reshape(data_sel(:,1),segm,n_segm);  % Tiempo
varb_rs=reshape(data_sel(:,2),segm,n_segm);  % Variable

% whos, pause,

for i=1:length(varb_rs(1,:)),
    lost(1,i)=ts_lost(varb_rs(:,i));
    if lost(1,i)==0                             % no hay datos faltantes
        y(:,i)=varb_rs(:,i);
        pve(:,i)=1;
    elseif (lost(1,i)<=cut) && (lost(1,i)>0)     % ejecutar reconst. por armonicos
        id_NaN=isnan(varb_rs(:,i));
        ii_0s=find(id_NaN==0);      ii_1s=find(id_NaN==1);
        [Coef_reco,EtaAv_reco,EtaS2_reco]=ts_harmo([time_rs(ii_0s,i),...
            varb_rs(ii_0s,i)],T,time_rs(:,i));
        EtaArm=sum(EtaS2_reco,2)+meanmiss(varb_rs(:,i));
        % -------------------------------
        y(:,i)=varb_rs(:,i);        
        y(ii_1s,i)=EtaArm(ii_1s);
        % -------------------------------
        pve(:,i)=ts_pve(varb_rs(ii_0s,i),EtaArm(ii_0s));
    elseif lost(1,i)>cut                         % relleno automático con NaNs
        y(:,i)=ones(segm,1).*NaN;
        pve(:,i)=NaN;
    else
        error('algo pasa, no?')
    end
end

y_time=time_rs;

