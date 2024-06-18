function varqf_control(data,estacion)
%function varqf_control(data,estacion)
% Prueba!!!

clock_now=clock;
clock_now_char=[num2str(clock_now(1)),'/',num2str(clock_now(2)),'/',num2str(clock_now(3)),', ',...
    num2str(clock_now(4)),':',num2str(clock_now(5)),':',num2str(clock_now(6))];
warning off MATLAB:divideByZero
clr_inamhi=[0,0.502,0.251]; 

data=nanfill(data,-999.9);

switch lower(estacion),
    case 'esmeraldas', sc_est='esm'; est=1; sc_est2='Esmeraldas'; ubict='01º04''N / 79º44''W'; ubict2='01 04 N - 79 44 W';
    case 'ptagalera', sc_est='gal'; est=5; sc_est2='Pta. Galeras'; ubict='00º52''N / 80º12''W'; ubict2='00 52 N - 80 12 W';
    case 'ptolopez', sc_est='lop'; est=2; sc_est2='Pto. Lopez'; ubict='01º34''S / 81º00''W'; ubict2='01 34 N - 81 00 W';
    case 'salinas', sc_est='sal'; est=3; sc_est2='Salinas'; ubict='02º07''S / 81º08''W'; ubict2='02 07 N - 81 08 W';
    case 'tonchigue', sc_est='tch'; est=4; sc_est2='Tonchigue'; ubict='01º04''N / 79º44''W'; ubict2='01 04 N - 79 44 W';
    otherwise
        error('varqf_control:UnknownStation');
end

index_est=find(data(:,1)==est);
data_r=data(index_est,:);
depths=[0,-10,-20,-30,-50,-75];
clr2_depths=[[0,0,1.0000];[0,0.5000,0];[1.0000,0,0];[0,0.7500,0.7500];...
    [0.7500,0,0.7500];[0.7500,0.7500,0];[0.2500,0.2500,0.2500];...
    [0,0,1.0000];[0,0.5000,0];[1.0000,0,0]];

time_fus=(1/24:1/12:1); time_fus=time_fus';

for i_timeFus=1:length(data_r(:,1))
    if data_r(i_timeFus,3)==1;
        fract_month=time_fus(1); time_yearly(i_timeFus,:)=data_r(i_timeFus,2)+fract_month;
    elseif data_r(i_timeFus,3)==2;
        fract_month=time_fus(2); time_yearly(i_timeFus,:)=data_r(i_timeFus,2)+fract_month;
    elseif data_r(i_timeFus,3)==3;
        fract_month=time_fus(3); time_yearly(i_timeFus,:)=data_r(i_timeFus,2)+fract_month;
    elseif data_r(i_timeFus,3)==4;
        fract_month=time_fus(4); time_yearly(i_timeFus,:)=data_r(i_timeFus,2)+fract_month;
    elseif data_r(i_timeFus,3)==5;
        fract_month=time_fus(5); time_yearly(i_timeFus,:)=data_r(i_timeFus,2)+fract_month;
    elseif data_r(i_timeFus,3)==6;
        fract_month=time_fus(6); time_yearly(i_timeFus,:)=data_r(i_timeFus,2)+fract_month;
    elseif data_r(i_timeFus,3)==7;
        fract_month=time_fus(7); time_yearly(i_timeFus,:)=data_r(i_timeFus,2)+fract_month;
    elseif data_r(i_timeFus,3)==8;
        fract_month=time_fus(8); time_yearly(i_timeFus,:)=data_r(i_timeFus,2)+fract_month;
    elseif data_r(i_timeFus,3)==9;
        fract_month=time_fus(9); time_yearly(i_timeFus,:)=data_r(i_timeFus,2)+fract_month;
    elseif data_r(i_timeFus,3)==10;
        fract_month=time_fus(10); time_yearly(i_timeFus,:)=data_r(i_timeFus,2)+fract_month;
    elseif data_r(i_timeFus,3)==11;
        fract_month=time_fus(11); time_yearly(i_timeFus,:)=data_r(i_timeFus,2)+fract_month;
    elseif data_r(i_timeFus,3)==12;
        fract_month=time_fus(12); time_yearly(i_timeFus,:)=data_r(i_timeFus,2)+fract_month;
    end
end

figure(3), subplot(3,1,2),plot(data_r(:,3),data_r(:,2),'b*'), grid on
set(gca,'xtick',[1:1:12],'xlim',[1,12],'ylim',[1998,2008],'ytick',[1998:1:2008],...
    'xticklabel','E|F|M|A|M|J|J|A|S|O|N|D','fontsize',10)
xlabel('meses','fontsize',10,'fontweight','bold'), ylabel('años','fontsize',10,'fontweight','bold')
title('DISPONIBILIDAD DE DATOS SEGÚN REGISTRO DE FECHA','fontsize',10,'fontweight','bold')

subplot(3,1,3),plot(time_yearly,data_r(:,6),'b*'), grid on
set(gca,'xtick',[1998:1:2008],'xlim',[1998,2008],'ylim',[-80,0],'ytick',[-80:5:0],...
    'fontsize',10)
xlabel('años','fontsize',10,'fontweight','bold'), ylabel('metros','fontsize',10,'fontweight','bold')
title('DISPONIBILIDAD DE DATOS SEGÚN REGISTRO DE FECHA/PROF.','fontsize',10,'fontweight','bold')

subplot(3,1,1), 
text(0.0,0.80,'RECORD DE PROCESAMIENTO DE DATOS PARA PROMEDIOS HISTORICOS')
text(0.0,0.70,'PROGRAMA DE VARIABILIDAD CLIMATICA')
text(0.0,0.60,'INSTITUTO NACIONAL DE PESCA, LAB. DE OCEANOGRAFIA')
text(0.0,0.50,['ESTACION: ',sc_est2])
text(0.0,0.40,['POSICION: ',ubict])
text(0.0,0.30,['FECHA DE INICIO: ',num2str(min(data_r(:,2))),'/',num2str(min(data_r(:,3)))])
text(0.0,0.20,['FECHA DE TERMINO: ',num2str(max(data_r(:,2))),'/',num2str(max(data_r(:,3)))])
text(0.0,0.10,['FECHA PROCESAMIENTO: ',clock_now_char])
axis off

portrait, print('-dtiff','-r300',['reporte_QFvar_',sc_est]), clf,

depths_nn=[0,10,20,30,50,75];
nutrients_code_c={'no2','no3','po4','si2o3','nh4','od','no3p04','oxsat','PercOxSat','uao'};
nutrients_code_c2={'NO_2','NO_3','PO_4','Si_2O_3','NH_4','OD','NO_3/P0_4','Ox.Sat.','% Ox.Sat.','UAO'};
nutrients_numy=[[1,10];[2,11];[3,12];[4,13];[5,14];[6,15];[7,16];[8,17];[9,18];[10,19]];

for i1=1:length(depths),
    for i2=1:length(nutrients_numy),
        for i3=1:12,
            % i1, i2, i3,
            index_monthy=find(data_r(:,3)==i3 & data_r(:,6)==depths(i1));
            if isempty(index_monthy)==1,
                eval([sc_est,'_',num2str(depths_nn(i1)),'m_',nutrients_code_c{i2},...
                    '(i3,:)=[NaN,NaN];'])
            else
                eval([sc_est,'_',num2str(depths_nn(i1)),'m_',nutrients_code_c{i2},...
                    '(i3,:)=[meanmiss(data_r(index_monthy,nutrients_numy(i2,2))),'...
                    'stdmiss(data_r(index_monthy,nutrients_numy(i2,2)))];'])
            end
        end
    end
    % para las medias, printf
    eval([sc_est,'_print_','no2_mean(i1,:)=[depths(i1),',sc_est,'_',num2str(depths_nn(i1)),'m_no2(:,1)''];'])
    eval([sc_est,'_print_','no3_mean(i1,:)=[depths(i1),',sc_est,'_',num2str(depths_nn(i1)),'m_no3(:,1)''];'])
    eval([sc_est,'_print_','po4_mean(i1,:)=[depths(i1),',sc_est,'_',num2str(depths_nn(i1)),'m_po4(:,1)''];'])
    eval([sc_est,'_print_','si2o3_mean(i1,:)=[depths(i1),',sc_est,'_',num2str(depths_nn(i1)),'m_si2o3(:,1)''];'])
    eval([sc_est,'_print_','od_mean(i1,:)=[depths(i1),',sc_est,'_',num2str(depths_nn(i1)),'m_no2(:,1)''];'])
    eval([sc_est,'_print_','no3p04_mean(i1,:)=[depths(i1),',sc_est,'_',num2str(depths_nn(i1)),'m_no3p04(:,1)''];'])
    % para las desviaciones estandar, printf
    eval([sc_est,'_print_','no2_sd(i1,:)=[depths(i1),',sc_est,'_',num2str(depths_nn(i1)),'m_no2(:,2)''];'])
    eval([sc_est,'_print_','no3_sd(i1,:)=[depths(i1),',sc_est,'_',num2str(depths_nn(i1)),'m_no3(:,2)''];'])
    eval([sc_est,'_print_','po4_sd(i1,:)=[depths(i1),',sc_est,'_',num2str(depths_nn(i1)),'m_po4(:,2)''];'])
    eval([sc_est,'_print_','si2o3_sd(i1,:)=[depths(i1),',sc_est,'_',num2str(depths_nn(i1)),'m_si2o3(:,2)''];'])
    eval([sc_est,'_print_','od_sd(i1,:)=[depths(i1),',sc_est,'_',num2str(depths_nn(i1)),'m_no2(:,2)''];'])
    eval([sc_est,'_print_','no3p04_sd(i1,:)=[depths(i1),',sc_est,'_',num2str(depths_nn(i1)),'m_no3p04(:,2)''];'])
end

save([sc_est,'_answ_varqf_control.mat']), 

nutrients_code_c3={'NITRITO','NITRATO','FOSFATO','SILICATO','OXIGENO DISUELTO','N/P'};
nutrients_code_c4={'no2','no3','po4','si2o3','od','no3p04'};

% ----- para imprimir reporte

fid=fopen([sc_est,'_answ_varqf_control.txt'],'w');
eval(['fprintf(fid,''%%RECORD DE PROCESAMIENTO DE DATOS PARA PROMEDIOS HISTORICOS\n'');'])
eval(['fprintf(fid,''%%PROGRAMA DE VARIABILIDAD CLIMATICA\n'');'])
eval(['fprintf(fid,''%%INSTITUTO NACIONAL DE PESCA, LAB. DE OCEANOGRAFIA\n'');'])
eval(['fprintf(fid,''%%ESTACION: ',sc_est2,'\n'');'])
eval(['fprintf(fid,''%%POSICION: ',ubict2,'\n'');'])
eval(['fprintf(fid,''%%FECHA DE INICIO: ',num2str(min(data_r(:,2))),'/',num2str(min(data_r(:,3))),'\n'');'])
eval(['fprintf(fid,''%%FECHA DE TERMINO: ',num2str(max(data_r(:,2))),'/',num2str(max(data_r(:,3))),'\n'');'])
eval(['fprintf(fid,''%%FECHA PROCESAMIENTO: ',clock_now_char,'\n'');'])
eval(['fprintf(fid,''%%PROF.\tENE\tFEB\tMAR\tABR\tMAY\tJUN\tJUL\tAGO\tSEP\tOCT\tNOV\tDIC\n'');'])
ident='mean';
for ii_fprtf=1:length(nutrients_code_c3),
    eval(['fprintf(fid,''%%Promedio, ',nutrients_code_c3{ii_fprtf},'\n'');'])
    eval(['fprintf(fid,''%2.2f\t %3.2f\t %3.2f\t %3.2f\t %3.2f\t %3.2f\t %3.2f\t %3.2f\t '...
        '%3.2f\t %3.2f\t %3.2f\t %3.2f\t %3.2f\t\n'',',sc_est,'_print_',nutrients_code_c4{ii_fprtf},'_',ident,''');'])
end
ident='sd';
for ii_fprtf=1:length(nutrients_code_c3),
    eval(['fprintf(fid,''%%Desviacion Estandar, ',nutrients_code_c3{ii_fprtf},'\n'');'])
    eval(['fprintf(fid,''%2.2f\t %3.2f\t %3.2f\t %3.2f\t %3.2f\t %3.2f\t %3.2f\t %3.2f\t '...
        '%3.2f\t %3.2f\t %3.2f\t %3.2f\t %3.2f\t\n'',',sc_est,'_print_',nutrients_code_c4{ii_fprtf},'_',ident,''');'])
end
fclose(fid); pause(0.5),

% ---- END CODE

for i2=1:length(nutrients_numy),
    for i1=1:length(depths),
        eval([sc_est,'_max_',nutrients_code_c{i2},'=ceil(max([max(',...
            sc_est,'_',num2str(depths_nn(1)),'m_',nutrients_code_c{i2},'(:,1)),max(',...
            sc_est,'_',num2str(depths_nn(2)),'m_',nutrients_code_c{i2},'(:,1)),max(',...
            sc_est,'_',num2str(depths_nn(3)),'m_',nutrients_code_c{i2},'(:,1)),max(',...
            sc_est,'_',num2str(depths_nn(4)),'m_',nutrients_code_c{i2},'(:,1)),max(',...
            sc_est,'_',num2str(depths_nn(5)),'m_',nutrients_code_c{i2},'(:,1)),max(',...
            sc_est,'_',num2str(depths_nn(6)),'m_',nutrients_code_c{i2},'(:,1))]));'])
    end
end

for i2=1:length(nutrients_numy),
    for i1=1:length(depths),
        
        figure(1), subplot(3,2,i1), 
        
        % eval(['plot([1:12],',sc_est,'_',num2str(depths_nn(i1)),'m_',nutrients_code_c{i2},'(:,1));']), hold on, grid on
        
        eval(['h=errorbar(''v6'',[1:12],',sc_est,'_',num2str(depths_nn(i1)),'m_',nutrients_code_c{i2},'(:,1),',...
            sc_est,'_',num2str(depths_nn(i1)),'m_',nutrients_code_c{i2},'(:,2));']), hold on, grid on,
        
        set(h(1,1),'color','b'), set(h(2,1),'color',clr_inamhi,'linewidth',1.25),
        
        if i1==1
            h1=legend('desv.est.','promedio','location','NE'); legend('boxoff'),
            lgd=get(h1,'position'); set(h1,'position',[-0.05,0.83,lgd(3)*.90,lgd(4)])
        end
        
        % eval(['plot([1:12],',sc_est,'_',num2str(depths_nn(i1)),'m_',nutrients_code_c{i2},'(:,1),''b*'');'])
        
        eval(['set(gca,''xlim'',[1,12],''ylim'',[0,',sc_est,'_max_',nutrients_code_c{i2},...
            '],''xtick'',[1:1:12],''xticklabel'',''E|F|M|A|M|J|J|A|S|O|N|D'',''fontsize'',8),'])
        title([nutrients_code_c2{i2},' ',num2str(depths(i1)),' m'],'fontsize',10,'fontweight','bold')
        
        figure(2), subplot(2,1,1)
        eval(['plot([1:12],',sc_est,'_',num2str(depths_nn(i1)),'m_',nutrients_code_c{i2},'(:,1),''color'',[',...
            num2str(clr2_depths(i1,1)),',',num2str(clr2_depths(i1,2)),',',num2str(clr2_depths(i1,3)),...
            '],''LineWidth'',1.25);']), hold on, grid on,
        
    end

    legend('0 m','10 m','20 m','30 m','50 m','75 m')
    
    for i1=1:length(depths),

        figure(2),
        eval(['plot([1:12],',sc_est,'_',num2str(depths_nn(i1)),'m_',nutrients_code_c{i2},'(:,1),''color'',[',...
            num2str(clr2_depths(i1,1)),',',num2str(clr2_depths(i1,2)),',',num2str(clr2_depths(i1,3)),...
            '],''LineStyle'',''*'');'])

    end
        
    figure(2), eval(['set(gca,''xlim'',[1,12],''ylim'',[0,',sc_est,'_max_',nutrients_code_c{i2},...
        '],''xtick'',[1:1:12],''xticklabel'',''E|F|M|A|M|J|J|A|S|O|N|D'',''fontsize'',10),'])
    title([nutrients_code_c2{i2}],'fontsize',10,'fontweight','bold')
    
    figure(1), 
    subplot(3,2,1), ylabel('ml/lt','fontsize',10,'fontweight','bold')
    subplot(3,2,3), ylabel('ml/lt','fontsize',10,'fontweight','bold')
    subplot(3,2,5), ylabel('ml/lt','fontsize',10,'fontweight','bold'), xlabel('meses','fontsize',10,'fontweight','bold'),
    subplot(3,2,6), xlabel('meses','fontsize',10,'fontweight','bold'),
    h1=text(1,1,['STA.: ',sc_est2],'fontsize',9);
    h2=text(1,2,['DAT: ',clock_now_char],'fontsize',9); 
    set(h1,'unit','normalized','position',[-0.05,-0.30,0]), set(h2,'unit','normalized','position',[-0.05,-0.45,0]), 
    portrait, print('-dtiff','-r300',[sc_est,'_',nutrients_code_c{i2}]), clf, % pause,
    
    figure(2), 
    ylabel('ml/lt','fontsize',10,'fontweight','bold')
    xlabel('meses','fontsize',10,'fontweight','bold'),
    h1=text(1,1,['STA.: ',sc_est2],'fontsize',9);
    h2=text(1,2,['DAT: ',clock_now_char],'fontsize',9);
    set(h1,'unit','normalized','position',[-0.02,-0.20,0]), set(h2,'unit','normalized','position',[-0.02,-0.30,0]),
    portrait, print('-dtiff','-r300',[sc_est,'_multi_',nutrients_code_c{i2}]), clf, % pause,
    pause(0.5),
    
end
    

