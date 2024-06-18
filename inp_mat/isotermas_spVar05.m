function [index,answ_isoterm]=isotermas_spVar05(datos)
% function [index,answ_isoterm]=isotermas_spVar05(datos)
% Prueba!!!
%
% Las variables de entrada son:
%
% datos = Matriz de datos de entrada
%         1era. col., Profundidad
%         2da.  col., Salinidad
%         3era. col., Temperatura[i,j]=find(datos(:,3)==0);

[i,j]=find(datos(:,3)==0);

[in_g,in_h]=size(datos);
[in_i,in_j]=size(i);

j=1;
for count1=1:in_i-1;
    index(j,:)=[i(j,1),i(j+1,1)-1];
    j=j+1;
end

index=[index;i(j,1),in_g];

% ----------------------------------------------- Isotermas

[iso_i,iso_j]=size(index);

j=1;
for i=1:iso_i;
    temp=[datos(index(j,1):index(j,2),3),datos(index(j,1):index(j,2),5)];
    [ii20,jj20]=find(temp(:,2)>20);
    [siz_ii20,siz_jj20]=size(ii20);
    x1=temp(siz_ii20,2);
    xi=20;
    x2=temp(siz_ii20+1,2);
    y1=temp(siz_ii20,1);
    y2=temp(siz_ii20+1,1);
    yi_20(j,:)=[datos(index(j,1),1),datos(index(j,1),2),((xi*y2)-(x1*y2)+(y1*x2)-(y1*xi))/(x2-x1)]; % Isot. 20
    if temp(:,2)>15
        yi_15(j,:)=NaN; % Isot. 15
    else
        [ii20,jj20]=find(temp(:,2)>15);
        [siz_ii20,siz_jj20]=size(ii20);
        x1=temp(siz_ii20,2);
        xi=15;
        x2=temp(siz_ii20+1,2);
        y1=temp(siz_ii20,1);
        y2=temp(siz_ii20+1,1);
        yi_15(j,:)=((xi*y2)-(x1*y2)+(y1*x2)-(y1*xi))/(x2-x1); % Isot. 15
    end
    j=j+1;
end

temp=[];

% ---------------------------

j=1;
for i=1:iso_i;
    temp=[datos(index(j,1):index(j,2),3),datos(index(j,1):index(j,2),5)];
    delta_ml=datos(index(j,1),5)-0.5;
    [u1,v1]=find(temp(:,2)>delta_ml);
    [siz_u1,siz_v1]=size(u1);
    x1=temp(siz_u1,2);
    xi=delta_ml;                 % T-0.5 (capa de mezcla)
    x2=temp(siz_u1+1,2);
    y1=temp(siz_u1,1);
    y2=temp(siz_u1+1,1);
    yi_ml(j,:)=((xi*y2)-(x1*y2)+(y1*x2)-(y1*xi))/(x2-x1);
    j=j+1;
end

answ_isoterm=[yi_20,yi_15,yi_ml];
