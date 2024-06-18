function [hh,t,radio]=rosa_ec(direc,veloc,nombre,prof)
% function [hh,t,radio]=rosa_ec(direc,veloc,nombre,prof)
%
% ROSA_EC Graficador de Histogramas de Frecuencias Angulares
% para corrientes marinas (rango==[0 - 1 m/s])
% Adaptado de <ROSA_CORRIENTES.m>, Matcor, IEO.
%
% 14/fev/2010, Jonathan Cedeno, Proyecto Jambeli.

colormap(summer);
map=colormap;

%1º: ROSA TOTAL
[t,radio1]=rose(deg2rad(direc),24);% de 15º en 15º
tot_radio=sum(radio1);
h1=polargeo(t,radio1*100/tot_radio,map(1,:));
hold on, 

% return

%2º: rosa de menores de 0.5m/s
auxi=[direc veloc];
for ii=length(auxi(:,1)):-1:1;
   if auxi(ii,2)>0.5;
      auxi(ii,:)=[];
   end
end

% auxi(:,1), pause,

[t,radio2]=rose(deg2rad(auxi(:,1)),24);% de 15º en 15º
h2=polargeo(t,radio2*100/tot_radio, map(13,:));

%3º: rosa de menores de 0.4m/s
for ii=length(auxi(:,1)):-1:1
   if auxi(ii,2)>0.4
      auxi(ii,:)=[];
   end
end

[t,radio3]=rose(deg2rad(auxi(:,1)),24);% de 15º en 15º
h3=polargeo(t,radio3*100/tot_radio, map(25,:));

%4º: rosa de menores de 0.3m/s
for ii=length(auxi(:,1)):-1:1
   if auxi(ii,2)>0.3
      auxi(ii,:)=[];
   end
end

[t,radio4]=rose(deg2rad(auxi(:,1)),24);% de 15º en 15º
h4=polargeo(t,radio4*100/tot_radio, map(37,:));

%5º: rosa de menores de 0.2m/s
for ii=length(auxi(:,1)):-1:1
   if auxi(ii,2)>0.2
      auxi(ii,:)=[];
   end
end

[t,radio5]=rose(deg2rad(auxi(:,1)),24);% de 15º en 15º
h5=polargeo(t,radio5*100/tot_radio, map(49,:));

%6º: rosa de menores de 0.1m/s
for ii=length(auxi(:,1)):-1:1
   if auxi(ii,2)>0.1
      auxi(ii,:)=[];
   end
end

[t,radio6]=rose(deg2rad(auxi(:,1)),24);% de 15º en 15º
h6=polargeo(t,radio6*100/tot_radio, map(61,:));

radio=[radio1' radio2' radio3' radio4' radio5' radio6'];
hh=[h1 h2 h3 h4 h5 h6];

legh=legend (hh,'>0.5m/s','0.4<...<0.5','0.3<...<0.4','0.2<...<0.3','0.1<...<0.2','0.0<...<0.1',...
    'location','northwestoutside');
set(legh,'fontsize',8); poss=get(legh,'position'); set(legh,'position',[0,.75,poss(3),poss(4)]);

return,

title([nombre,' ',prof],'FontSize',10,'fontweight','bold');

subplot(1,2,2),

hist(veloc)
