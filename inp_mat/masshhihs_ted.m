function [p,t,s]=masshhihs_ted(crucero)
%function [p,t,s]=masshhihs_ted(crucero)
% ****CALCULO DE MASAS DE AGUA EN INVIERNO DE HEMISFERIO SUR****
%
% Hecho por: OC. TELMO DE LA CUADRA FRIAS
%            INSTITUTO NACIONAL DE PESCA
%
% Rutina para calcular las masas de agua con valores de Invierno del HS

prob=crucero;
t=prob(:,1);
s=prob(:,2);
p1=(.01219*t)-(.4878*s)+16.96341;
p3=(35.3-s-(1.9*p1))/(.2);
p2=1-p1-p3;
p1=p1*100;
p2=p2*100;
p3=p3*100;
p(:,1)=p1;
p(:,2)=p2;
p(:,3)=p3;

n=length(p);
for i=1:n
   pp1=p(i,1);
   if pp1>=100
      p(i,1)=100;
      p(i,2)=0;
      p(i,3)=0;
   end;
   a=100-p(i,1);
   if pp1<100 & pp1>=50 & p(i,3)>a; 
      p(i,3)=a;
      p(i,2)=0;
   end;
   if p(i,3)>=100
      p(i,3)=100;
      p(i,1)=0;
      p(i,2)=0;
   end;
   q=p(i,1)+p(i,2);
   if p(i,2)<0 & p(i,1)<10; 
      p(i,3)=p(i,3)+q;
      p(i,2)=0;
      p(i,1)=0;
   end;
   if p(i,2)<0 & p(i,1)>10; 
      p(i,2)=0;
      r=p(i,1)+p(i,3)-100;
      s=r*1/2;
      p(i,1)=p(i,1)-s;
      p(i,3)=p(i,3)-s;
   end;
   if p(i,1)<0 & p(i,3)<p(i,2) 
      p(i,3)=p(i,3)+p(i,1);
      p(i,1)=0;
   end;
   if p(i,1)<0 & p(i,3)>p(i,2)
      p(i,2)=p(i,2)+p(i,1);
      p(i,1)=0;
   end;
   if p(i,3)<0
      p(i,2)=a;
      p(i,3)=0;
   end;
end;