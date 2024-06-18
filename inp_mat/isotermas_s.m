function [yi_temp15,yi_temp20,answ11]=isotermas_s(data)
%function [yi_temp15,yi_temp20,answ11]=isotermas_s(data)
% ISOTERMAS_S (isotermas en serie) Esta funcion calcula
% la profundidad de las isotermas de 15ºC y 20ºC de cada
% bloque de datos (identificados por un numero de mes o
% estacion).
% 
% Las variables de entrada son:
%
%      data = Matriz de Datos de Entrada
%             1era. Col., No. de Estacion.
%             2da.  Col., No. de Mes [OJO!!!]. 
%             3era. Col., Profundidad (negativa, en m).
%             4ta.  Col., Salinidad (ups).
%             5ta.  Col., Temperatura (ºC).
%
% Las variables de salida son:
%
% yi_temp15 = Profundidad de la isoterma de 15ºC
%             (por cada bloque de datos).
% yi_temp20 = Profundidad de la isoterma de 20ºC
%             (por cada bloque de datos).
%    answ11 = Indices de bloques de datos
%             (inicio/fin de cada bloque de datos).
%
% CALLS: find, size

% Diseñada y Testada en el Instituto Nacional de Pesca, para
% el programa de Variabilidad Climatica.
% 19/Oct/2005 Jonathan Cedeño, FIMCM-ESPOL (Ecuador).


% ------------------------- Indices

[a,b]=size(data);

j=1;
l=1;
for i=1:a-1
    if data(j,2)~=data(j+1,2)
        answ09(l,:)=j;
        l=l+1;
    end
    j=j+1;
end

[c,d]=size(answ09);

j=1;
for i=1:c-1
    answ10(j,:)=[answ09(j,1)+1,answ09(j+1,1)];
    j=j+1;
end

answ11=[1,answ09(1,1);answ10;answ09(c,1)+1,a];

% ------------------------- Isoterma 20ºC (calculada a traves de interpolacion lineal)

[e,f]=size(answ11);

answ12=answ11(:,2);
answ12=[0;answ12(1:e-1,1)]; 

j=1;
for i=1:e
    [u1,v1]=find(data(answ11(j,1):answ11(j,2),5)>20);
    [siz_u1,siz_v1]=size(u1);
    x1=data(siz_u1+answ12(j,1),5);
    xi=20;                 % Isoterma de 20ºC
    x2=data(siz_u1+answ12(j,1)+1,5);
    y1=data(siz_u1+answ12(j,1),3);
    y2=data(siz_u1+1+answ12(j,1),3);
    yi_temp20(j,:)=[data(answ11(j,1),2),((xi*y2)-(x1*y2)+(y1*x2)-(y1*xi))/(x2-x1)];
    j=j+1;
end

% ------------------------- Isoterma 15ºC (calculada a traves de interpolacion lineal)

j=1;
for i=1:e
    if data(answ11(j,2),5)>15
        yi_temp15(j,:)=[data(answ11(j,1),2),NaN];
        j=j+1;
    else
        [u1,v1]=find(data(answ11(j,1):answ11(j,2),5)>15);
        [siz_u1,siz_v1]=size(u1);
        x1=data(siz_u1+answ12(j,1),5);
        xi=15;             % Isoterma de 15ºC
        x2=data(siz_u1+answ12(j,1)+1,5);
        y1=data(siz_u1+answ12(j,1),3);
        y2=data(siz_u1+1+answ12(j,1),3);
        yi_temp15(j,:)=[data(answ11(j,1),2),((xi*y2)-(x1*y2)+(y1*x2)-(y1*xi))/(x2-x1)];
        j=j+1;
    end
end
