function [hh,t,radio]=rosa_ec_waves(direc,veloc,nombre,prof)
% function [hh,t,radio]=rosa_ec_waves(direc,veloc,nombre,prof)
%
%establezco mapa de colores

colormap(summer); map=colormap;

% subplot(1,2,1),

%1º: ROSA TOTAL
[t,radio1]=rose(deg2rad(direc),24);% de 15º en 15º
tot_radio=sum(radio1);
h1=polargeo(t,radio1*100/tot_radio,map(1,:));
hold on, 

% [*] informacion de rangos (Significant Height):
%     1. Hs < 3
%     2. Hs < 2.5
%     3. Hs < 2
%     4. Hs < 1.5
%     5. Hs < 1

%2º: rosa de menores de 3 m
auxi=[direc veloc];
for ii=length(auxi(:,1)):-1:1;
   if auxi(ii,2)>3;
      auxi(ii,:)=[];
   end
end

% auxi(:,1), pause,

[t,radio2]=rose(deg2rad(auxi(:,1)),24);% de 15º en 15º
h2=polargeo(t,radio2*100/tot_radio, map(13,:));

% disp('1.1'), pause,

%3º: rosa de mayores a 2.5 m
for ii=length(auxi(:,1)):-1:1
   if auxi(ii,2)>2.5
      auxi(ii,:)=[];
   end
end

[t,radio3]=rose(deg2rad(auxi(:,1)),24);% de 15º en 15º
h3=polargeo(t,radio3*100/tot_radio, map(25,:));

% disp('1.2'), pause,

%4º: rosa de menores de 2 m
for ii=length(auxi(:,1)):-1:1
   if auxi(ii,2)>2
      auxi(ii,:)=[];
   end
end

[t,radio4]=rose(deg2rad(auxi(:,1)),24);% de 15º en 15º
h4=polargeo(t,radio4*100/tot_radio, map(37,:));

%5º: rosa de menores de 1.5 m
for ii=length(auxi(:,1)):-1:1
   if auxi(ii,2)>1.5
      auxi(ii,:)=[];
   end
end

[t,radio5]=rose(deg2rad(auxi(:,1)),24); % de 15º en 15º
h5=polargeo(t,radio5*100/tot_radio, map(49,:));

% %6º: rosa de menores de 1 m
% for ii=length(auxi(:,1)):-1:1
%    if auxi(ii,2)>1
%       auxi(ii,:)=[];
%    end
% end
% 
% if ~isempty(auxi),
%     [t,radio6]=rose(deg2rad(auxi(:,1)),24);% de 15º en 15º
%     h6=polargeo(t,radio6*100/tot_radio, map(61,:));
% end

% return

radio=[radio1' radio2' radio3' radio4' radio5'];
hh=[h1 h2 h3 h4 h5];
legend (hh,'>3m','2.5<...<3','2<...<2.5','1.5<...<2','0<...<1.5',...
    'location','southwestoutside');
title([nombre,' ',prof],'FontSize',10,'fontweight','bold'); hold on,

% subplot(1,2,2),
% hist(veloc)
