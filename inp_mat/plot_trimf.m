function plot_trimf(data_base,meses)
%function plot_trimf(data_base,meses)
% Esta funcion genera, a partir de datos de Temperatura y Salinidad
% de las estaciones costeras de Esmeraldas, Pto. Lopez y Salinas,
% un grafico tipo 'mosaico' de 4 paneles:
%
% Panel Izquierdo Superior = TSM
%   Panel Derecho Superior = SSM
% Panel Izquierdo Inferior = Prof. Isoterma de 20ºC
%   Panel Derecho Inferior = Temp. promedio de la Columna de Agua
%
% Los datos de entrada son:
%
% data_base = Matriz de datos de entrada
%             1era. Col., Id. de Estacion
%             2da.  Col., Meses
%             3era. Col., Profundidad
%             4ta.  Col., Salinidad
%             5ta.  Col., Temperatura
%     meses = Meses (No. de mes en un arreglo de 1 fila por n columnas)
%
% ATENCION:
%
% - El Codigo Numerico de las estaciones deberan ser:
%   1 = Esmeraldas, 2 =  Pto. Lopez, 3 = Salinas.
% - El No. de mes debera ser del 1 al 12 (Enero a Diciembre)
% - Las profundidades deben de ser de 0 a -100 m, con un intervalo de 5 m.
% - No deben de exixtir datos perdidos NaNs.
% - La rutina no esta diseñada para trimestres inter-anuales.

% Diseñada y Testada en el Instituto Nacional de Pesca, para
% el programa de Variabilidad Climatica.
% 15/Oct/2005 Jonathan Cedeño, FIMCM-ESPOL (Ecuador).

% load ejemplo_trimestral_variabilidad.mat


% EDITADO EL 01-JUN-09, PARA EL INFORME DE VARIABILIDAD
[ii,jj]=find(data_base(:,3)>=0 & data_base(:,3)<=100);
data_base=data_base(ii,:);


[i1,j1]=find(data_base(:,1)==1); esmeraldas=data_base(i1,:);
[i2,j2]=find(data_base(:,1)==2); p_lopez=data_base(i2,:);
[i3,j3]=find(data_base(:,1)==3); salinas=data_base(i3,:);

if meses(1,1)==1
    char_meses=char('D','E','F','M','A');
elseif meses(1,1)==2
    char_meses=char('E','F','M','A','M');
elseif meses(1,1)==3
    char_meses=char('F','M','A','M','J');
elseif meses(1,1)==4
    char_meses=char('M','A','M','J','J');
elseif meses(1,1)==5
    char_meses=char('A','M','J','J','A');
elseif meses(1,1)==6
    char_meses=char('M','J','J','A','S');
elseif meses(1,1)==7
    char_meses=char('J','J','A','S','O');
elseif meses(1,1)==8
    char_meses=char('J','A','S','O','N');
elseif meses(1,1)==9
    char_meses=char('A','S','O','N','D');
elseif meses(1,1)==10
    char_meses=char('S','O','N','D','E');
end

% -------------------- TSM

subplot(2,2,1);
[i1,j2]=find(esmeraldas(:,2)==meses(1,1) & esmeraldas(:,3)==0);                 % Julio
[i3,j4]=find(esmeraldas(:,2)==meses(1,2) & esmeraldas(:,3)==0);                 % Agosto
[i5,j6]=find(esmeraldas(:,2)==meses(1,3) & esmeraldas(:,3)==0);                 % Septiembre
g1_e=[esmeraldas(i1,5),esmeraldas(i3,5),esmeraldas(i5,5)];   % Esmeraldas (3 meses)
plot(meses,g1_e,'m','linewidth',1.5); hold on;

[i1,j2]=find(p_lopez(:,2)==meses(1,1) & p_lopez(:,3)==0);                 % Julio
[i3,j4]=find(p_lopez(:,2)==meses(1,2) & p_lopez(:,3)==0);                 % Agosto
[i5,j6]=find(p_lopez(:,2)==meses(1,3) & p_lopez(:,3)==0);                 % Septiembre
g1_p=[p_lopez(i1,5),p_lopez(i3,5),p_lopez(i5,5)];   % Pto. Lopez (3 meses)
plot(meses,g1_p,'k','linewidth',1.5);

[i1,j2]=find(salinas(:,2)==meses(1,1) & salinas(:,3)==0);                 % Julio
[i3,j4]=find(salinas(:,2)==meses(1,2) & salinas(:,3)==0);                 % Agosto
[i5,j6]=find(salinas(:,2)==meses(1,3) & salinas(:,3)==0);                 % Septiembre
g1_s=[salinas(i1,5),salinas(i3,5),salinas(i5,5)];   % Salinas (3 meses)
plot(meses,g1_s,'b','linewidth',1.5);

mat1=[g1_e;g1_p;g1_s];                                                    % Bloque de limites de ejes y detalles
x1_min=floor(min(min(mat1)));
x1_max=ceil(max(max(mat1)));
axis([meses(1,1)-1,meses(1,3)+1,x1_min,x1_max])
% legend('Esmeraldas','Pto. López','Salinas',1); hold off;
set(gca,'xtick',[meses(1,1)-1:1:meses(1,3)+1]);
set(gca,'xticklabel',char_meses);
% xlabel('Tiempo [Meses]','fontweight','bold');
ylabel('Temperatura (°C)','fontweight','bold');
title('A. TSM','fontsize',12,'fontweight','bold');
grid on;

% -------------------- SSM

subplot(2,2,2);
[i1,j2]=find(esmeraldas(:,2)==meses(1,1) & esmeraldas(:,3)==0);                 % Julio
[i3,j4]=find(esmeraldas(:,2)==meses(1,2) & esmeraldas(:,3)==0);                 % Agosto
[i5,j6]=find(esmeraldas(:,2)==meses(1,3) & esmeraldas(:,3)==0);                 % Septiembre
g2_e=[esmeraldas(i1,4),esmeraldas(i3,4),esmeraldas(i5,4)];   % Esmeraldas (3 meses)
plot(meses,g2_e,'m','linewidth',1.5); hold on;

[i1,j2]=find(p_lopez(:,2)==meses(1,1) & p_lopez(:,3)==0);                 % Julio
[i3,j4]=find(p_lopez(:,2)==meses(1,2) & p_lopez(:,3)==0);                 % Agosto
[i5,j6]=find(p_lopez(:,2)==meses(1,3) & p_lopez(:,3)==0);                 % Septiembre
g2_p=[p_lopez(i1,4),p_lopez(i3,4),p_lopez(i5,4)];   % Pto. Lopez (3 meses)
plot(meses,g2_p,'k','linewidth',1.5);

[i1,j2]=find(salinas(:,2)==meses(1,1) & salinas(:,3)==0);                 % Julio
[i3,j4]=find(salinas(:,2)==meses(1,2) & salinas(:,3)==0);                 % Agosto
[i5,j6]=find(salinas(:,2)==meses(1,3) & salinas(:,3)==0);                 % Septiembre
g2_s=[salinas(i1,4),salinas(i3,4),salinas(i5,4)];   % Salinas (3 meses)
plot(meses,g2_s,'b','linewidth',1.5);

mat2=[g2_e;g2_p;g2_s];                                                    % Bloque de limites de ejes y detalles
x2_min=floor(min(min(mat2)));
x2_max=ceil(max(max(mat2)));
axis([meses(1,1)-1,meses(1,3)+1,x2_min,x2_max])
% legend('Esmeraldas','Pto. López','Salinas',1); hold off;
set(gca,'xtick',[meses(1,1)-1:1:meses(1,3)+1]);
set(gca,'xticklabel',char_meses);
% xlabel('Tiempo [Meses]','fontweight','bold');
ylabel('Salinidad (ups)','fontweight','bold');
title('B. SSM','fontsize',12,'fontweight','bold');
grid on;

% -------------------- Prof. Isoterma de 20ºC

[index,answ_isoterm]=isotermas_sp(data_base(:,3:5));
isoterm_matrix=[data_base(index(:,1),1:2),answ_isoterm];

% ESM
[i1,j1]=find(isoterm_matrix(:,1)==1); isoterm_1_esm=isoterm_matrix(i1,:);
[i2,j2]=find(isoterm_1_esm(:,2)==meses(1) |...
    isoterm_1_esm(:,2)==meses(2) | isoterm_1_esm(:,2)==meses(3));
isoterm_1_esm_MO=isoterm_1_esm(i2,:); % pause

% PLP
[i1,j1]=find(isoterm_matrix(:,1)==2); isoterm_2_plp=isoterm_matrix(i1,:);
[i2,j2]=find(isoterm_2_plp(:,2)==meses(1) |...
    isoterm_2_plp(:,2)==meses(2) | isoterm_2_plp(:,2)==meses(3));
isoterm_2_plp_MO=isoterm_2_plp(i2,:); % pause

% SAL
[i1,j1]=find(isoterm_matrix(:,1)==3); isoterm_3_sal=isoterm_matrix(i1,:);
[i2,j2]=find(isoterm_3_sal(:,2)==meses(1) |...
    isoterm_3_sal(:,2)==meses(2) | isoterm_3_sal(:,2)==meses(3));
isoterm_3_sal_MO=isoterm_3_sal(i2,:); % pause

mat3=[isoterm_1_esm_MO(:,3)';isoterm_2_plp_MO(:,3)';isoterm_3_sal_MO(:,3)'], % pause,

subplot(2,2,3);
% mat3=[yi_temp(1:3);yi_temp(4:6);yi_temp(7:9)], pause,
plot(meses,mat3(1,:),'m','linewidth',1.5); hold on; 
plot(meses,mat3(2,:),'k','linewidth',1.5);
plot(meses,mat3(3,:),'b','linewidth',1.5);


% 'position',[left bottom width height]
h1=legend('Esmeraldas','Pto. López','Salinas','location','S','orientation','horizontal'); legend('boxoff'),
lgd=get(h1,'position'); lgd(1), set(h1,'position',[lgd(1)+0.205,lgd(2)-0.13,lgd(3),lgd(4)])


x3_min=floor(min(min(mat3)));                                                % Bloque de limites de ejes y detalles
x3_max=ceil(max(max(mat3)));
axis([meses(1,1)-1,meses(1,3)+1,x3_min,x3_max])
% legend('Esmeraldas','Pto. López','Salinas',1); hold off;
set(gca,'xtick',[meses(1,1)-1:1:meses(1,3)+1]);
set(gca,'xticklabel',char_meses,'ydir','reverse');
xlabel('Meses','fontweight','bold');
ylabel('Profundidad (Metros)','fontweight','bold');
title('C. PROF. ISOTERMA 20ºC','fontsize',12,'fontweight','bold');
grid on;

% ------------------------ Temp. Promedio de la columna

subplot(2,2,4);
[i1,j2]=find(esmeraldas(:,2)==meses(1,1));                 % Julio
[i3,j4]=find(esmeraldas(:,2)==meses(1,2));                 % Agosto
[i5,j6]=find(esmeraldas(:,2)==meses(1,3));                 % Septiembre
g4_e=[meanmiss(esmeraldas(i1,5)),meanmiss(esmeraldas(i3,5)),meanmiss(esmeraldas(i5,5))];   % Esmeraldas (3 meses)
plot(meses,g4_e,'m','linewidth',1.5); hold on;

[i1,j2]=find(p_lopez(:,2)==meses(1,1));                 % Julio
[i3,j4]=find(p_lopez(:,2)==meses(1,2));                 % Agosto
[i5,j6]=find(p_lopez(:,2)==meses(1,3));                 % Septiembre
g4_p=[meanmiss(p_lopez(i1,5)),meanmiss(p_lopez(i3,5)),meanmiss(p_lopez(i5,5))];   % Pto. Lopez (3 meses)
plot(meses,g4_p,'k','linewidth',1.5);

[i1,j2]=find(salinas(:,2)==meses(1,1));                 % Julio
[i3,j4]=find(salinas(:,2)==meses(1,2));                 % Agosto
[i5,j6]=find(salinas(:,2)==meses(1,3));                 % Septiembre
g4_s=[meanmiss(salinas(i1,5)),meanmiss(salinas(i3,5)),meanmiss(salinas(i5,5))];   % Salinas (3 meses)
plot(meses,g4_s,'b','linewidth',1.5);

mat4=[g4_e;g4_p;g4_s];                                                    % Bloque de limites de ejes y detalles
x1_min=floor(min(min(mat4)));
x1_max=ceil(max(max(mat4)));
axis([meses(1,1)-1,meses(1,3)+1,x1_min,x1_max])
% legend('Esmeraldas','Pto. López','Salinas',1); hold off;
set(gca,'xtick',[meses(1,1)-1:1:meses(1,3)+1]);
set(gca,'xticklabel',char_meses);
xlabel('Meses','fontweight','bold');
ylabel('Temperatura (°C)','fontweight','bold');
title('D. TEMP. PROM. DE LA COLUMNA','fontsize',12,'fontweight','bold');
grid on; print('-dtiff','-r300','graf_triFIS_2f_var09')