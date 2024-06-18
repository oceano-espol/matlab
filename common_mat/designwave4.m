function answ203=designwave4(data,flag,obsyr,root)
%function answ203=designwave4(data,flag,obsyr,root)
%
% DESIGNWAVE4 Calculo de las olas de diseño (por 4 metodos)
% Esta funcion permite obtener las olas extremas (referidas en la
% literatura tambien como olas de diseño o periodo de retorno) segun cuatro
% metodologias especificadas por Espin y Nath (1992).
% Estos metodos son: (1) Weibull, (2) Draper, (3) Log-Log y (4) Log-Ln
%
% Variables de Entrada:
% 
%    data = datos de probabilidad de frecuencia dados los intervalos de
%           clase pre-especificados
%           (1) col, altura de ola (en centimetros) ¡OJO!
%           (2) col, probabilidad de ocurrencia de ola
%    flag = 'weibull', solucion Weibull
%           'draper',  solucion Draper
%           'loglog',  solucion Log-Log
%           'logln',   solucion Log-Ln
%   obsyr = numero de observaciones en un año
%    root = texto de etiqueta en el nombre de la figura generada
%
% Variables de Salida:
% 
% answ203 = Matriz de Resultados
%           (1) col, periodo de retorno
%           (2) col, altura de ola dado el periodo de retorno especificado
%
% 11/MAY/2010, Jonathan Cedeño, INOCAR Ecuador
% 21/JUL/2019, jcedeno@espol.edu.ec

% Inspirada en 'lc_ProbJambeli_Drapper3.m' --------------------------------

% --
% % load waves_jambeliPs_22mar10_L.mat
% --

clr_inamhi=[0,0.502,0.251]; % Verde

% El <y2_siz_data> --> <obsyr> es igual al número de registros anual del 
% set de datos de origen. Por ejemplo, en las salidas de BW es comun 
% encontrar una cada tres horas. Asi, existen 8 salidas por dia, y 2920 
% registros por año 

% 2013-07-29, La Entrada. Una salida cada 6 horas. 4 salidas diarias, 
%             1460 registros por anno.

% y2_siz_data=2920;       % JAMBELI (ORO)
% y2_siz_data=12;         % SAN CRISTOBAL (GAL)
% y2_siz_data=8760;       % BARBASQUILLO (MAN)
% y2_siz_data=1460;       % La Entrada (LET) y Palmar (PAL)

switch lower(flag)
    
    case 'weibull'
        
        x_axis=[0:0.2:22026.47]'; 
        
        % Obteniendo la probabilidad de los periodos de retorno a 
        % 001, 010, 025, 050, 100 años...
        pr_001=(1/(001*obsyr)); pr_010=(1/(010*obsyr));
        pr_025=(1/(025*obsyr)); pr_050=(1/(050*obsyr));
        pr_100=(1/(100*obsyr));
        
        p_001=ones(length(x_axis),1).*pr_001; p_010=ones(length(x_axis),1).*pr_010;
        p_025=ones(length(x_axis),1).*pr_025; p_050=ones(length(x_axis),1).*pr_050;
        p_100=ones(length(x_axis),1).*pr_100;
        
        ywb_axis=log(log(1./(1-data(:,2))));
        % -- Recta de Regresion... --
        [jb_txt_title,jb_corr_r,jb_txt_title2,jb_coef,...
            jb_for_cint]=linreg_dw(log(data(:,1)),ywb_axis); hold on,
        xlr_axis=log(x_axis), ylr_axis=jb_coef(1,1)+(jb_coef(1,2).*xlr_axis), length(ylr_axis), % pause,
        plot(xlr_axis,ylr_axis,'color',clr_inamhi,'LineWidth',1), hold on, grid on, 
        % -- Ploteo de los datos... --
        plot(log(data(:,1)),ywb_axis,'bo'), set(gca,'ydir','reverse'), % pause,

        % Redimensionando al eje -y- las probabilidades de los periodos de
        % retorno        
        pwb_001=log(log(1./(1-p_001))); pwb_010=log(log(1./(1-p_010)));
        pwb_025=log(log(1./(1-p_025))); pwb_050=log(log(1./(1-p_050)));
        pwb_100=log(log(1./(1-p_100))); 
        
        % Ploteando las rectas de referencias de las probabilidades del
        % periodo de retorno...
        plot(x_axis,pwb_001,'b--'), plot(x_axis,pwb_010,'b--'),
        plot(x_axis,pwb_025,'b--'), plot(x_axis,pwb_050,'b--'),
        plot(x_axis,pwb_100,'b--'),
        
        % Calculando la Hs en base a la ecuación de la recta de regresión
        % ...
        hr_wb_001=exp((pwb_001(1,1)-jb_coef(1,1))/jb_coef(1,2))/100;
        hr_wb_010=exp((pwb_010(1,1)-jb_coef(1,1))/jb_coef(1,2))/100;
        hr_wb_025=exp((pwb_025(1,1)-jb_coef(1,1))/jb_coef(1,2))/100;
        hr_wb_050=exp((pwb_050(1,1)-jb_coef(1,1))/jb_coef(1,2))/100;
        hr_wb_100=exp((pwb_100(1,1)-jb_coef(1,1))/jb_coef(1,2))/100;
        
        answ203=[[001,pwb_001(1,1),hr_wb_001];...
            [010,pwb_010(1,1),hr_wb_010];...
            [025,pwb_025(1,1),hr_wb_025];...
            [050,pwb_050(1,1),hr_wb_050];...
            [100,pwb_100(1,1),hr_wb_100]];
        
        text(0.25,pwb_001(1,1),'001 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),  
        text(0.25,pwb_010(1,1),'010 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),
        text(0.25,pwb_025(1,1),'025 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]), 
        text(0.25,pwb_050(1,1),'050 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),
        text(0.25,pwb_100(1,1),'100 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),
        
        text(0.95,0.20,{['\it{Alturas de ola extrema:}'];...
            ['001 años: ',num2str(hr_wb_001,'%4.2f'),'m'];...
            ['010 años: ',num2str(hr_wb_010,'%4.2f'),'m'];...
            ['025 años: ',num2str(hr_wb_025,'%4.2f'),'m'];...
            ['050 años: ',num2str(hr_wb_050,'%4.2f'),'m'];...
            ['100 años: ',num2str(hr_wb_100,'%4.2f'),'m']},'units','normalized','horizontalalignment','right'),
        
        % set(gca,'xlim',[0,10],'ylim',[-14,0],'ytick',[-14:2:0]),
        set(gca,'xlim',[0,10]),
        xlabel('Ln (H_s)','fontweight','bold','fontsize',10),
        ylabel('Ln(Ln(1/(1-P(H_s))))','fontweight','bold','fontsize',10),
        title('Distribución probabilistica según Weibull',...
            'fontweight','bold','fontsize',12),
        
        print('-r300','-dtiff',['fig_198_Hs_weibull_',root]),
        
    case 'draper'
        
        x_axis=[0:1:1000]'; 
        
        % Obteniendo la probabilidad de los periodos de retorno a 
        % 001, 010, 025, 050, 100 años...
        pr_001=(1/(001*obsyr)); pr_010=(1/(010*obsyr));
        pr_025=(1/(025*obsyr)); pr_050=(1/(050*obsyr));
        pr_100=(1/(100*obsyr));
        
        p_001=ones(length(x_axis),1).*pr_001; p_010=ones(length(x_axis),1).*pr_010;
        p_025=ones(length(x_axis),1).*pr_025; p_050=ones(length(x_axis),1).*pr_050;
        p_100=ones(length(x_axis),1).*pr_100;
        
        ywb_axis=log10(data(:,2));
        % -- Recta de Regresion... --
        [jb_txt_title,jb_corr_r,jb_txt_title2,jb_coef,...
            jb_for_cint]=linreg_dw(data(:,1),ywb_axis); hold on,
        xlr_axis=x_axis, ylr_axis=jb_coef(1,1)+(jb_coef(1,2).*xlr_axis), length(ylr_axis), % pause,
        plot(xlr_axis,ylr_axis,'color',clr_inamhi,'LineWidth',1), hold on, grid on, 
        % -- Ploteo de los datos... --
        plot(data(:,1),ywb_axis,'bo'), set(gca,'ydir','reverse'), % pause,

        % Redimensionando al eje -y- las probabilidades de los periodos de
        % retorno        
        pwb_001=log10(p_001); pwb_010=log10(p_010);
        pwb_025=log10(p_025); pwb_050=log10(p_050);
        pwb_100=log10(p_100); 
        
        % Ploteando las rectas de referencias de las probabilidades del
        % periodo de retorno...
        plot(x_axis,pwb_001,'b--'), plot(x_axis,pwb_010,'b--'),
        plot(x_axis,pwb_025,'b--'), plot(x_axis,pwb_050,'b--'),
        plot(x_axis,pwb_100,'b--'),
        
        % Calculando la Hs en base a la ecuación de la recta de regresión
        % ...
        hr_wb_001=(((pwb_001(1,1)-jb_coef(1,1))/jb_coef(1,2))/100);
        hr_wb_010=(((pwb_010(1,1)-jb_coef(1,1))/jb_coef(1,2))/100);
        hr_wb_025=(((pwb_025(1,1)-jb_coef(1,1))/jb_coef(1,2))/100);
        hr_wb_050=(((pwb_050(1,1)-jb_coef(1,1))/jb_coef(1,2))/100);
        hr_wb_100=(((pwb_100(1,1)-jb_coef(1,1))/jb_coef(1,2))/100);
        
        answ203=[[001,pwb_001(1,1),hr_wb_001];...
            [010,pwb_010(1,1),hr_wb_010];...
            [025,pwb_025(1,1),hr_wb_025];...
            [050,pwb_050(1,1),hr_wb_050];...
            [100,pwb_100(1,1),hr_wb_100]];
        
        text(0.25,pwb_001(1,1),'001 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),  
        text(0.25,pwb_010(1,1),'010 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),
        text(0.25,pwb_025(1,1),'025 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]), 
        text(0.25,pwb_050(1,1),'050 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),
        text(0.25,pwb_100(1,1),'100 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),
        
        text(0.95,0.20,{['\it{Alturas de ola extrema:}'];...
            ['001 años: ',num2str(hr_wb_001,'%4.2f'),'m'];...
            ['010 años: ',num2str(hr_wb_010,'%4.2f'),'m'];...
            ['025 años: ',num2str(hr_wb_025,'%4.2f'),'m'];...
            ['050 años: ',num2str(hr_wb_050,'%4.2f'),'m'];...
            ['100 años: ',num2str(hr_wb_100,'%4.2f'),'m']},'units','normalized','horizontalalignment','right'),
        
        set(gca,'xlim',[0,500],'ylim',[-6,0],'ytick',[-6:1:0]),
        xlabel('H_s (cm)','fontweight','bold','fontsize',10),
        ylabel('Log P(H_s)','fontweight','bold','fontsize',10),
        title('Distribución probabilistica según Draper',...
            'fontweight','bold','fontsize',12),
        
        print('-r300','-dtiff',['fig_198_Hs_draper_',root]),
        
    case 'loglog'
        
        x_axis=[0:10:100000]'; 
        
        % Obteniendo la probabilidad de los periodos de retorno a 
        % 001, 010, 025, 050, 100 años...
        pr_001=(1/(001*obsyr)); pr_010=(1/(010*obsyr));
        pr_025=(1/(025*obsyr)); pr_050=(1/(050*obsyr));
        pr_100=(1/(100*obsyr));
        
        p_001=ones(length(x_axis),1).*pr_001; p_010=ones(length(x_axis),1).*pr_010;
        p_025=ones(length(x_axis),1).*pr_025; p_050=ones(length(x_axis),1).*pr_050;
        p_100=ones(length(x_axis),1).*pr_100;
        
        ywb_axis=log10(data(:,2));
        % -- Recta de Regresion... --
        [jb_txt_title,jb_corr_r,jb_txt_title2,jb_coef,...
            jb_for_cint]=linreg_dw(log10(data(:,1)),ywb_axis); hold on,
        xlr_axis=log10(x_axis), ylr_axis=jb_coef(1,1)+(jb_coef(1,2).*xlr_axis), length(ylr_axis), % pause,
        plot(xlr_axis,ylr_axis,'color',clr_inamhi,'LineWidth',1), hold on, grid on, 
        % -- Ploteo de los datos... --
        plot(log10(data(:,1)),ywb_axis,'bo'), set(gca,'ydir','reverse'), % pause,

        % Redimensionando al eje -y- las probabilidades de los periodos de
        % retorno        
        pwb_001=log10(p_001); pwb_010=log10(p_010);
        pwb_025=log10(p_025); pwb_050=log10(p_050);
        pwb_100=log10(p_100); 
        
        % Ploteando las rectas de referencias de las probabilidades del
        % periodo de retorno...
        plot(x_axis,pwb_001,'b--'), plot(x_axis,pwb_010,'b--'),
        plot(x_axis,pwb_025,'b--'), plot(x_axis,pwb_050,'b--'),
        plot(x_axis,pwb_100,'b--'),
        
        % Calculando la Hs en base a la ecuación de la recta de regresión
        % ...
        hr_wb_001=(10^((pwb_001(1,1)-jb_coef(1,1))/jb_coef(1,2)))/100;
        hr_wb_010=(10^((pwb_010(1,1)-jb_coef(1,1))/jb_coef(1,2)))/100;
        hr_wb_025=(10^((pwb_025(1,1)-jb_coef(1,1))/jb_coef(1,2)))/100;
        hr_wb_050=(10^((pwb_050(1,1)-jb_coef(1,1))/jb_coef(1,2)))/100;
        hr_wb_100=(10^((pwb_100(1,1)-jb_coef(1,1))/jb_coef(1,2)))/100;
        
        answ203=[[001,pwb_001(1,1),hr_wb_001];...
            [010,pwb_010(1,1),hr_wb_010];...
            [025,pwb_025(1,1),hr_wb_025];...
            [050,pwb_050(1,1),hr_wb_050];...
            [100,pwb_100(1,1),hr_wb_100]];
        
        text(0.25,pwb_001(1,1),'001 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),  
        text(0.25,pwb_010(1,1),'010 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),
        text(0.25,pwb_025(1,1),'025 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]), 
        text(0.25,pwb_050(1,1),'050 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),
        text(0.25,pwb_100(1,1),'100 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),
        
        text(0.95,0.20,{['\it{Alturas de ola extrema:}'];...
            ['001 años: ',num2str(hr_wb_001,'%4.2f'),'m'];...
            ['010 años: ',num2str(hr_wb_010,'%4.2f'),'m'];...
            ['025 años: ',num2str(hr_wb_025,'%4.2f'),'m'];...
            ['050 años: ',num2str(hr_wb_050,'%4.2f'),'m'];...
            ['100 años: ',num2str(hr_wb_100,'%4.2f'),'m']},'units','normalized','horizontalalignment','right'),
        
        set(gca,'xlim',[0,5],'ylim',[-6,1],'ytick',[-6:1:1]),
        xlabel('Log (H_s)','fontweight','bold','fontsize',10),
        ylabel('Log P(H_s)','fontweight','bold','fontsize',10),
        title('Distribución probabilistica según Log-Log',...
            'fontweight','bold','fontsize',12),
        
        print('-r300','-dtiff',['fig_198_Hs_loglog_',root]),
        
    case 'logln'

        x_axis=[0:0.2:22026]'; 
        
        % Obteniendo la probabilidad de los periodos de retorno a 
        % 001, 010, 025, 050, 100 años...
        pr_001=(1/(001*obsyr)); pr_010=(1/(010*obsyr));
        pr_025=(1/(025*obsyr)); pr_050=(1/(050*obsyr));
        pr_100=(1/(100*obsyr));
        
        p_001=ones(length(x_axis),1).*pr_001; p_010=ones(length(x_axis),1).*pr_010;
        p_025=ones(length(x_axis),1).*pr_025; p_050=ones(length(x_axis),1).*pr_050;
        p_100=ones(length(x_axis),1).*pr_100;
        
        ywb_axis=log10(data(:,2));
        % -- Recta de Regresion... --
        [jb_txt_title,jb_corr_r,jb_txt_title2,jb_coef,...
            jb_for_cint]=linreg_dw(log(data(:,1)),ywb_axis); hold on,
        xlr_axis=log(x_axis); ylr_axis=jb_coef(1,1)+(jb_coef(1,2).*xlr_axis); length(ylr_axis); % pause,
        plot(xlr_axis,ylr_axis,'color',clr_inamhi,'LineWidth',1), hold on, grid on, 
        % -- Ploteo de los datos... --
        plot(log(data(:,1)),ywb_axis,'bo'), set(gca,'ydir','reverse'), % pause,

        % Redimensionando al eje -y- las probabilidades de los periodos de
        % retorno        
        pwb_001=log10(p_001); pwb_010=log10(p_010);
        pwb_025=log10(p_025); pwb_050=log10(p_050);
        pwb_100=log10(p_100); 
        
        % Ploteando las rectas de referencias de las probabilidades del
        % periodo de retorno...
        plot(log(x_axis),pwb_001,'b--'), plot(log(x_axis),pwb_010,'b--'),
        plot(log(x_axis),pwb_025,'b--'), plot(log(x_axis),pwb_050,'b--'),
        plot(log(x_axis),pwb_100,'b--'),
        
        % Calculando la Hs en base a la ecuación de la recta de regresión
        % ...
        hr_wb_001=(exp((pwb_001(1,1)-jb_coef(1,1))/jb_coef(1,2)))/100;
        hr_wb_010=(exp((pwb_010(1,1)-jb_coef(1,1))/jb_coef(1,2)))/100;
        hr_wb_025=(exp((pwb_025(1,1)-jb_coef(1,1))/jb_coef(1,2)))/100;
        hr_wb_050=(exp((pwb_050(1,1)-jb_coef(1,1))/jb_coef(1,2)))/100;
        hr_wb_100=(exp((pwb_100(1,1)-jb_coef(1,1))/jb_coef(1,2)))/100;
        
        answ203=[[001,pwb_001(1,1),hr_wb_001];...
            [010,pwb_010(1,1),hr_wb_010];...
            [025,pwb_025(1,1),hr_wb_025];...
            [050,pwb_050(1,1),hr_wb_050];...
            [100,pwb_100(1,1),hr_wb_100]];
        
        text(0.25,pwb_001(1,1),'001 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),  
        text(0.25,pwb_010(1,1),'010 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),
        text(0.25,pwb_025(1,1),'025 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]), 
        text(0.25,pwb_050(1,1),'050 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),
        text(0.25,pwb_100(1,1),'100 años','horizontalalignment','left','backgroundcolor',[0.878,0.878,0.878]),
        
        text(0.95,0.20,{['\it{Alturas de ola extrema:}'];...
            ['001 años: ',num2str(hr_wb_001,'%4.2f'),'m'];...
            ['010 años: ',num2str(hr_wb_010,'%4.2f'),'m'];...
            ['025 años: ',num2str(hr_wb_025,'%4.2f'),'m'];...
            ['050 años: ',num2str(hr_wb_050,'%4.2f'),'m'];...
            ['100 años: ',num2str(hr_wb_100,'%4.2f'),'m']},'units','normalized','horizontalalignment','right'),
        
        set(gca,'xlim',[0,10],'ylim',[-6,1],'ytick',[-6:1:1]),
        xlabel('Ln (H_s)','fontweight','bold','fontsize',10),
        ylabel('Log P(H_s)','fontweight','bold','fontsize',10),
        title('Distribución probabilistica según Log-Ln',...
            'fontweight','bold','fontsize',12),
        
        print('-r300','-dtiff',['fig_198_Hs_logln_',root]),        
        
end