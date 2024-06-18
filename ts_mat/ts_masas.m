function [pm1,pm2]=ts_masas(T,S)
% function [pm1,pm2]=ts_masas(T,S)
%
% MASAS permite estimar las proporciones de masas de agua
%       teniendo como referencia tres aguas tipo.
%
% El sistema de tres ecuaciones (con tres incognitas) se resuelve de la
% forma matricial x = A\B. Ver anotaciones en clase.

% [*] aguas tipo definidas según ejercicio del 2016-11-25
%               A(ESPIW)  B(AAIW)   C(CDW)     Mezcla
% T [°C]        12.5      5          1         T
% S [ups]       34.3     34.12      34.67      S

% [*] aguas tipo definidas para aguas ecuatorianas
% IHS Invierno del hemisferio sur (Estación Seca Ecuatoriana, Jun-Nov):
%
% - AESS (Agua Ecuatorial Sub-Superficial) = 13.0ºC, 35.1 ups
% - ATS (Agua Tropical Superficial) = 27.0ºC, 33.4 ups
% - ASTS (Agua Sub-Tropical Superficial) = 21.0ºC, 35.3 ups
%
%               A(AESS)  B(ATS)   C(ASTS)     Mezcla
% T [°C]        13.0     27.0      21.0        T
% S [ups]       35.1     33.4      35.3        S
%
% VHS Verano del hemisferio sur (Estación Lluviosa Ecuatoriana, Dic-May):
%
% - AESS (Agua Ecuatorial Sub-Superficial) = 13.0ºC, 35.1 ups
% - ATS (Agua Tropical Superficial) = 28.0ºC, 33.7 ups
% - ASTS (Agua Sub-Tropical Superficial) = 24.0ºC, 35.5 ups
%
%               A(AESS)  B(ATS)   C(ASTS)     Mezcla
% T [°C]        13.0     28.0      24.0        T
% S [ups]       35.1     33.7      35.5        S

% VHS Verano del hemisferio sur (Estación Lluviosa Ecuatoriana, Dic-May):
%
% - AESS (Agua Ecuatorial Sub-Superficial) = 13.0ºC, 35.1 ups
% - ATS (Agua Tropical Superficial) = 28.0ºC, 33.7 ups
% - ASTS (Agua Sub-Tropical Superficial) = 24.0ºC, 35.5 ups
%
% IHS Invierno del hemisferio sur (Estación Seca Ecuatoriana, Jun-Nov):
%
% - AESS (Agua Ecuatorial Sub-Superficial) = 13.0ºC, 35.1 ups
% - ATS (Agua Tropical Superficial) = 27.0ºC, 33.4 ups
% - ASTS (Agua Sub-Tropical Superficial) = 21.0ºC, 35.3 ups
%
% La composición porcentual fue obtenida por el método del Triángulo
% de Mezcla, y el sistema de tres ecuaciones es resuelto por el
% método de determinantes.
%
% El "Filtro de Mamayev" fue extraido de las rutinas <masshhvhs_ted>
% y <masshhihs_ted>, traducidas de BASIC a MATLAB 5.1 por 
% De la Cuadra T. en el año del 2004.
%
% Referencias:
%
% Cucalón, E. 1983. Temperature, Salinity and Water Masses Distribution off
%    Ecuador during an El Niño Event in 1976. Rev.Cien.Mar.Limnol. 2(1):1-25.

% caso de ejemplo: masas de agua en el pac. eq. oriental (ihs) julio
% AESS, ATS, ASTS
A=[ 13.0 , 27.0 , 21.0 ; ...
    35.1 , 33.4 , 35.3 ; ...
     1   ,  1   ,  1];

N=length(T);
for i=1:N
    B=[T(i) ; S(i) ; 1];
    x(:,i) = A\B;
end

x=x';

%% segunda parte: filtro de mamayev

answ1=x.*100;

n2=length(answ1);                          % Filtro de Mamayev
for i=1:n2
   pp1=answ1(i,1);
   aa=100-answ1(i,1);
   qq=answ1(i,1)+answ1(i,2);
   if pp1>=100
      answ1(i,1)=100;
      answ1(i,2)=0;
      answ1(i,3)=0;
      % disp('1'),
   end
   if pp1<100 & pp1>=50 & answ1(i,3)>aa
      answ1(i,3)=aa;
      answ1(i,2)=0;
      % disp('2'),
   end
   if answ1(i,3)>=100
      answ1(i,3)=100;
      answ1(i,1)=0;
      answ1(i,2)=0;
      % disp('3'),
   end
   if answ1(i,2)<0 & answ1(i,1)<10
      answ1(i,3)=answ1(i,3)+qq;
      answ1(i,2)=0;
      answ1(i,1)=0;
      % disp('4'),
   end
   if answ1(i,2)<0 & answ1(i,1)>10
      answ1(i,2)=0;
      rr=answ1(i,1)+answ1(i,3)-100;
      ss=rr*1/2;
      answ1(i,1)=answ1(i,1)-ss;
      answ1(i,3)=answ1(i,3)-ss;
      % disp('5'),
   end
   if answ1(i,1)<0 & answ1(i,3)<answ1(i,2)
      answ1(i,3)=answ1(i,3)+answ1(i,1);
      answ1(i,1)=0;
      % disp('6'),
   end
   if answ1(i,1)<0 & answ1(i,3)>answ1(i,2)
      answ1(i,2)=answ1(i,2)+answ1(i,1);
      answ1(i,1)=0;
      % disp('7'),
   end
   if answ1(i,3)<0
      answ1(i,2)=aa;
      answ1(i,3)=0;
      % disp('8'),
   end
end

pm1=x;           % proporcion de masas de aguas sin correccion
pm2=answ1./100;  % proporcion de masas de aguas CON correccion (f. mamayev)

return
