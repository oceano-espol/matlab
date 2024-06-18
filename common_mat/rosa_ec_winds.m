function [hh,t,radio]=rosa_ec_winds(direc,veloc,nombre,prof)
% function [hh,t,radio]=rosa_ec_winds(direc,veloc,nombre,prof)
%
%establezco mapa de colores

colormap(summer); map=colormap;

% subplot(1,2,1),

%1º: ROSA TOTAL
[t,radio1]=rose(deg2rad(direc),36);% de 10º en 10º
tot_radio=sum(radio1);
h1=polargeo(t,radio1*100/tot_radio,map(1,:)); hold on,

% [*] informacion de rangos (Wind Speed):
%     1. Ws < 10
%     2. Ws < 8
%     3. Ws < 6
%     4. Ws < 4
%     5. Ws < 2

%2º: rosa de menores de 10 m/s
auxi=[direc veloc];
for ii=length(auxi(:,1)):-1:1;
   if auxi(ii,2)>10;
      auxi(ii,:)=[];
   end
end

% auxi(:,1), pause,

[t,radio2]=rose(deg2rad(auxi(:,1)),36);     % de 10º en 10º
h2=polargeo(t,radio2*100/tot_radio, map(13,:)); 

%3º: rosa de menores de 8 m/s
for ii=length(auxi(:,1)):-1:1
   if auxi(ii,2)>8
      auxi(ii,:)=[];
   end
end

[t,radio3]=rose(deg2rad(auxi(:,1)),36);     % de 10º en 10º
h3=polargeo(t,radio3*100/tot_radio, map(25,:));

%4º: rosa de menores de 6 m/s
for ii=length(auxi(:,1)):-1:1
   if auxi(ii,2)>6
      auxi(ii,:)=[];
   end
end

[t,radio4]=rose(deg2rad(auxi(:,1)),36);     % de 10º en 10º
h4=polargeo(t,radio4*100/tot_radio, map(37,:));

%5º: rosa de menores de 4 m/s
for ii=length(auxi(:,1)):-1:1
   if auxi(ii,2)>4
      auxi(ii,:)=[];
   end
end

[t,radio5]=rose(deg2rad(auxi(:,1)),36);     % de 10º en 10º
h5=polargeo(t,radio5*100/tot_radio, map(49,:));

%6º: rosa de menores de 2 m/s
for ii=length(auxi(:,1)):-1:1
   if auxi(ii,2)>2
      auxi(ii,:)=[];
   end
end

if ~isempty(auxi),
    [t,radio6]=rose(deg2rad(auxi(:,1)),36);     % de 10º en 10º
    h6=polargeo(t,radio6*100/tot_radio, map(61,:));
end

% return

radio=[radio1' radio2' radio3' radio4' radio5' radio6'];
hh=[h1 h2 h3 h4 h5 h6];
legend (hh,'>10m/s','8<...<10','6<...<8','4<...<6','2<...<4','0<...<2',...
    'location','southwestoutside');
title([nombre,' ',prof],'FontSize',10,'fontweight','bold'); hold on,

% subplot(1,2,2),
% hist(veloc)
