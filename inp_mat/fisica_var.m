% Ejemplo para plotear los datos fisicos de Variabilidad Climatica
% I.N.P., Departamento de Oceanografia
%
% 1era. columna, Estacion
% 2da.  columna, Mes         (X)
% 3era. columna, Profundidad (Y)
% 4ta.  columna, Salinidad
% 5ta.  columna, Temperatura

load ejemplo_variabilidad.mat

[i1,j1]=find(fisica_2var05(:,1)==1); esmeraldas=fisica_2var05(i1,:);
[i2,j2]=find(fisica_2var05(:,1)==2); p_lopez=fisica_2var05(i2,:);
[i3,j3]=find(fisica_2var05(:,1)==3); salinas=fisica_2var05(i3,:);

cax_max_sal=round(max(fisica_2var05(:,4))); cax_min_sal=round(min(fisica_2var05(:,4)));
cax_max_temp=round(max(fisica_2var05(:,5))); cax_min_temp=round(min(fisica_2var05(:,5)));

% ---------------------------------- SALINIDAD ---------------------------------------------

figure(1); subplot(1,3,1); % Esmeraldas - Salinidad
datamap6([esmeraldas(:,2),esmeraldas(:,3),esmeraldas(:,4)],1,1,[cax_min_sal,cax_max_sal],1);
axis([7 12 -100 0]);
[c,v,x_out,y_out]=grid_interp([esmeraldas(:,2),esmeraldas(:,3),esmeraldas(:,4)],1,1);
hold on; [c1,c2]=contour(x_out,y_out,c,'k');clabel(c1,'manual','fontweight','bold');set(c2,'linewidth',1);
plot(esmeraldas(:,2),esmeraldas(:,3),'k+','markersize',3);
set(gca,'xtick',[7:1:12]);
set(gca,'xticklabel','JUL|AGO|SEPT|OCT|NOV|DIC');
set(gca,'ytick',[-100:10:0]);
xlabel('Tiempo [Meses]','fontweight','bold');
ylabel('Profundidad [Metros]','fontweight','bold');
title('SALINIDAD - ESMERALDAS','fontsize',12,'fontweight','bold');

subplot(1,3,2); % Puerto Lopez - Salinidad
datamap6([p_lopez(:,2),p_lopez(:,3),p_lopez(:,4)],1,1,[cax_min_sal,cax_max_sal],1);
axis([7 12 -100 0]);
[c,v,x_out,y_out]=grid_interp([p_lopez(:,2),p_lopez(:,3),p_lopez(:,4)],1,1);
hold on; [c1,c2]=contour(x_out,y_out,c,'k');clabel(c1,'manual','fontweight','bold');set(c2,'linewidth',1);
plot(p_lopez(:,2),p_lopez(:,3),'k+','markersize',3);
set(gca,'xtick',[7:1:12]);
set(gca,'xticklabel','JUL|AGO|SEPT|OCT|NOV|DIC');
set(gca,'ytick',[-100:10:0]);
xlabel('Tiempo [Meses]','fontweight','bold');
% ylabel('Profundidad [Metros]','fontweight','bold');
title('SALINIDAD - PTO. LOPEZ','fontsize',12,'fontweight','bold');

subplot(1,3,3); % Salinas - Salinidad
datamap6([salinas(:,2),salinas(:,3),salinas(:,4)],1,1,[cax_min_sal,cax_max_sal],1);
axis([7 12 -100 0]);
[c,v,x_out,y_out]=grid_interp([salinas(:,2),salinas(:,3),salinas(:,4)],1,1);
hold on; [c1,c2]=contour(x_out,y_out,c,'k');clabel(c1,'manual','fontweight','bold');set(c2,'linewidth',1);
plot(salinas(:,2),salinas(:,3),'k+','markersize',3);
set(gca,'xtick',[7:1:12]);
set(gca,'xticklabel','JUL|AGO|SEPT|OCT|NOV|DIC');
set(gca,'ytick',[-100:10:0]);
xlabel('Tiempo [Meses]','fontweight','bold');
% ylabel('Profundidad [Metros]','fontweight','bold');
title('SALINIDAD - SALINAS','fontsize',12,'fontweight','bold');

% ---------------------------------- TEMPERATURA ---------------------------------------------

figure(2); subplot(1,3,1); % Esmeraldas - Temperatura
datamap6([esmeraldas(:,2),esmeraldas(:,3),esmeraldas(:,5)],1,1,[cax_min_temp,cax_max_temp],1);
axis([7 12 -100 0]);
[c,v,x_out,y_out]=grid_interp([esmeraldas(:,2),esmeraldas(:,3),esmeraldas(:,5)],1,1);
hold on; [c1,c2]=contour(x_out,y_out,c,'k');clabel(c1,'manual','fontweight','bold');set(c2,'linewidth',1);
[zz2,h2]=contour(x_out,y_out,c,[-20 20],'k'); set(h2,'linewidth',2);          % Isoterma de 20º
plot(esmeraldas(:,2),esmeraldas(:,3),'k+','markersize',3);
set(gca,'xtick',[7:1:12]);
set(gca,'xticklabel','JUL|AGO|SEPT|OCT|NOV|DIC');
set(gca,'ytick',[-100:10:0]);
xlabel('Tiempo [Meses]','fontweight','bold');
ylabel('Profundidad [Metros]','fontweight','bold');
title('TEMPERATURA - ESMERALDAS','fontsize',12,'fontweight','bold');

subplot(1,3,2); % Puerto Lopez - Temperatura
datamap6([p_lopez(:,2),p_lopez(:,3),p_lopez(:,5)],1,1,[cax_min_temp,cax_max_temp],1);
axis([7 12 -100 0]);
[c,v,x_out,y_out]=grid_interp([p_lopez(:,2),p_lopez(:,3),p_lopez(:,5)],1,1);
hold on; [c1,c2]=contour(x_out,y_out,c,'k');clabel(c1,'manual','fontweight','bold');set(c2,'linewidth',1);
[zz2,h2]=contour(x_out,y_out,c,[-20 20],'k'); set(h2,'linewidth',2);          % Isoterma de 20º
plot(p_lopez(:,2),p_lopez(:,3),'k+','markersize',3);
set(gca,'xtick',[7:1:12]);
set(gca,'xticklabel','JUL|AGO|SEPT|OCT|NOV|DIC');
set(gca,'ytick',[-100:10:0]);
xlabel('Tiempo [Meses]','fontweight','bold');
% ylabel('Profundidad [Metros]','fontweight','bold');
title('TEMPERATURA - PTO. LOPEZ','fontsize',12,'fontweight','bold');

subplot(1,3,3); % Salinas - Temperatura
datamap6([salinas(:,2),salinas(:,3),salinas(:,5)],1,1,[cax_min_temp,cax_max_temp],1);
axis([7 12 -100 0]);
[c,v,x_out,y_out]=grid_interp([salinas(:,2),salinas(:,3),salinas(:,5)],1,1);
hold on; [c1,c2]=contour(x_out,y_out,c,'k');clabel(c1,'manual','fontweight','bold');set(c2,'linewidth',1);
[zz2,h2]=contour(x_out,y_out,c,[-20 20],'k'); set(h2,'linewidth',2);          % Isoterma de 20º
plot(salinas(:,2),salinas(:,3),'k+','markersize',3);
set(gca,'xtick',[7:1:12]);
set(gca,'xticklabel','JUL|AGO|SEPT|OCT|NOV|DIC');
set(gca,'ytick',[-100:10:0]);
xlabel('Tiempo [Meses]','fontweight','bold');
% ylabel('Profundidad [Metros]','fontweight','bold');
title('TEMPERATURA - SALINAS','fontsize',12,'fontweight','bold');