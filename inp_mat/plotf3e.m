function plotf3e(f_esm,f_plop,f_sal)
%function plotf3e(f_esm,f_plop,f_sal)
% Esta función plotea los datos de Temperatura (ºC)
% y Salinidad (ups) para tres estaciones dadas en 
% el programa de Variabilidad Climática del INP
% (Instituto Nacional de Pesca, Ecuador).
%
% Las variables de entrada son:
%
%  f_esm = Matriz de datos de entrada para la est. Esmeraldas
%          1era. col., Profundidad (m)
%          2 da. col., Temperatura
%          3era. col., Salinidad
% f_plop = Matriz de datos de entrada para la est. Pto. López
%          1era. col., Profundidad (m)
%          2 da. col., Temperatura
%          3era. col., Salinidad
%  f_sal = Matriz de datos de entrada para la est. Salinas
%          1era. col., Profundidad (m)
%          2 da. col., Temperatura
%          3era. col., Salinidad
%
% CALLS: suav

% 01/May/05 Jonathan Cedeño, FIMCM-ESPOL.
% 30/Nov/05 1st. Revision, Jonathan Cedeño, FIMCM-ESPOL.
%           jcedeno@espol.edu.ec

max_t=ceil(max([f_esm(:,2);f_plop(:,2);f_sal(:,2)]));
min_t=floor(min([f_esm(:,2);f_plop(:,2);f_sal(:,2)]));
max_s=ceil(max([f_esm(:,3);f_plop(:,3);f_sal(:,3)]));
min_s=floor(min([f_esm(:,3);f_plop(:,3);f_sal(:,3)]));

t_esm=f_esm(:,2);
s_esm=f_esm(:,3);
prf_esm=f_esm(:,1);
[rt_esm]=suav([t_esm prf_esm],1);
[rs_esm]=suav([s_esm prf_esm],1);
clf;

t_plop=f_plop(:,2);
s_plop=f_plop(:,3);
prf_plop=f_plop(:,1);
[rt_plop]=suav([t_plop prf_plop],1);
[rs_plop]=suav([s_plop prf_plop],1);
clf;

t_sal=f_sal(:,2);
s_sal=f_sal(:,3);
prf_sal=f_sal(:,1);
[rt_sal]=suav([t_sal prf_sal],1);
[rs_sal]=suav([s_sal prf_sal],1);
clf;

subplot(1,2,1),plot(rt_esm(:,1),rt_esm(:,2),'m','linewidth',1.5);  % graf_temp Esmeraldas
hold on;
plot(rt_plop(:,1),rt_plop(:,2),'k','linewidth',1.5);               % graf_temp Pto. López
plot(rt_sal(:,1),rt_sal(:,2),'b','linewidth',1.5);                 % graf_temp Salinas
legend('Esmeraldas','Pto. López','Salinas',4)
xlabel('A.- Temperatura (ºC)','fontweight','bold');
ylabel('Profundidad (m)');
axis([min_t,max_t,-100,0]);
set(gca,'PlotBoxAspectRatio',[1 1 1])
grid on;
hold off;

subplot(1,2,2),plot(rs_esm(:,1),rs_esm(:,2),'m','linewidth',1.5);  % graf_sal Esmeraldas
hold on;
plot(rs_plop(:,1),rs_plop(:,2),'k','linewidth',1.5);               % graf_sal Pto. López
plot(rs_sal(:,1),rs_sal(:,2),'b','linewidth',1.5);                 % graf_sal Salinas
legend('Esmeraldas','Pto. López','Salinas',3)
xlabel('B.- Salinidad (ups)','fontweight','bold');
axis([min_s,max_s,-100,0]);
set(gca,'xtick',[min_s:0.5:max_s])
set(gca,'PlotBoxAspectRatio',[1 1 1])
grid on;
hold off;
