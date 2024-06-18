function H = fillbar2(x,y)
%  FILLBAR2:     Creates a filled bar plot
%
%   FILLBAR2 genera un gráfico tipo bar especializado para
%   anomalías de parámetros oceanográficos.  Las anomalías
%   positivas se plotean en color rojo, mientras que las
%   negativas en azul. 

%   See BAR for details

% 18/Sept/2007
% Jonathan Cedeño, jcedeno@espol.edu.ec

i_p=find(y>0);
i_n=find(y<0);

y_pos=y; y_neg=y;
y_pos(i_n,:)=NaN; y_neg(i_p,:)=NaN;

h1=bar(x,y_pos);, hold on, h2=bar(x,y_neg);
set(h1,'edgecolor','r','facecolor','r'), set(h2,'edgecolor','b','facecolor','b'),

grid on
% set(gca,'xtick',[round(x(1,1)):5:round(x(siz_i,1))+1],...
%     'ytick',[-5:1:5],'xlim',[round(x(1,1)),round(x(siz_i,1))+1],'ylim',[-5 5]);
xlabel('Tiempo (años)','fontweight','bold')
ylabel('Anomalias Estandarizadas','fontweight','bold')