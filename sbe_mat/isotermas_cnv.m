function [yi_temp20,yi_temp15,yi_ml]=isotermas_cnv(data)
%function isotermas_cnv(data)
% Prueba!!!

[i_siz,j_siz]=size(data);

% ------------------------- Isoterma 20ºC (calculada a traves de interpolacion lineal)

if sum(data(:,3)>20)==0
    yi_temp20=[NaN],
else
    [u1,v1]=find(data(:,3)>20);
    [siz_u1,siz_v1]=size(u1);
    x1=data(siz_u1,3);
    xi=20;                 % Isoterma de 20ºC
    x2=data(siz_u1+1,3);
    y1=data(siz_u1,1);
    y2=data(siz_u1+1,1);
    yi_temp20=[((xi*y2)-(x1*y2)+(y1*x2)-(y1*xi))/(x2-x1)];
end

% ------------------------- Isoterma 15ºC (calculada a traves de interpolacion lineal)

if sum(data(:,3)<15)==0
    yi_temp15=[NaN];
else
    [u1,v1]=find(data(data(:,3)>15));
    [siz_u1,siz_v1]=size(u1);
    x1=data(siz_u1,3);
    xi=15;             % Isoterma de 15ºC
    x2=data(siz_u1+1,3);
    y1=data(siz_u1,1);
    y2=data(siz_u1+1,1);
    yi_temp15=[((xi*y2)-(x1*y2)+(y1*x2)-(y1*xi))/(x2-x1)];
end

% ------------------------- Capa de Mezcla (calculada a traves de interpolacion lineal)

if data(1,3)==0
    yi_ml=[NaN];
else
    delta_ml=data(1,3)-0.5;
    [u1,v1]=find(data(:,3)>delta_ml);
    [siz_u1,siz_v1]=size(u1);
    x1=data(siz_u1,3);
    xi=delta_ml;                 % T-0.5 (capa de mezcla)
    x2=data(siz_u1+1,3);
    y1=data(siz_u1,1);
    y2=data(siz_u1+1,1);
    yi_ml=[((xi*y2)-(x1*y2)+(y1*x2)-(y1*xi))/(x2-x1)];
end


