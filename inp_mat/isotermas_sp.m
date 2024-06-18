function [index,answ_isoterm]=isotermas_sp(datos)
% function [index,answ_isoterm]=isotermas_sp(datos)
% Prueba!!!
%
% Las variables de entrada son:
%
% datos = Matriz de datos de entrada
%         1era. col., Profundidad
%         2da.  col., Salinidad
%         3era. col., Temperatura

[i,j]=find(datos(:,1)==0);

[in_g,in_h]=size(datos);
[in_i,in_j]=size(i); % pause,

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
    temp=[datos(index(j,1):index(j,2),1),datos(index(j,1):index(j,2),3)];
    [ii20,jj20]=find(temp(:,2)>20);
    [siz_ii20,siz_jj20]=size(ii20);
    x1=temp(siz_ii20,2);
    xi=20;
    x2=temp(siz_ii20+1,2);
    y1=temp(siz_ii20,1);
    y2=temp(siz_ii20+1,1);
    yi_20(j,1)=((xi*y2)-(x1*y2)+(y1*x2)-(y1*xi))/(x2-x1);
    if temp(:,2)>15
        yi_15(j,1)=NaN;
    else
        [ii20,jj20]=find(temp(:,2)>15);
        [siz_ii20,siz_jj20]=size(ii20);
        x1=temp(siz_ii20,2);
        xi=15;
        x2=temp(siz_ii20+1,2);
        y1=temp(siz_ii20,1);
        y2=temp(siz_ii20+1,1);
        yi_15(j,1)=((xi*y2)-(x1*y2)+(y1*x2)-(y1*xi))/(x2-x1);
    end
    j=j+1;
end

answ_isoterm=[yi_20,yi_15];