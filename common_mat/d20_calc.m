function [d20]=d20_calc(dp,tp)
% function [d20,d15]=d20_calc(dp,tp)
% D20_CALC Estimacion de la prof. de la isoterma de 20°C
%   d20, isotherm, isotermas
%
% Las variables de entrada son:
%
%   dp = depth
%   tp = temperature

% *basada en <isotermas_sp>*
%
% 19/oct/2005, jcedeno@espol.edu.ec
% 29/apr/2015, jcedeno@udec.cl

[iso_i,iso_j]=size(tp);

j=1;
for i=1:iso_j
    temp=[dp,tp(:,i)];
    ix=find(isnan(temp(:,2))==1);
    length(ix), pause,
    if sum(ix)==iso_i
        d20(j,1)=NaN;
    else
        if sum(temp(:,2)>=20)==0    % error check!
            d20(j,1)=NaN;
        else
            [ii20,~]=find(temp(:,2)>20);
            [siz_ii20,~]=size(ii20);
            x1=temp(siz_ii20,2);
            xi=20;
            x2=temp(siz_ii20+1,2);
            y1=temp(siz_ii20,1);
            y2=temp(siz_ii20+1,1);
            d20(j,1)=((xi*y2)-(x1*y2)+(y1*x2)-(y1*xi))/(x2-x1);
        end
    end
    j=j+1;
end

return

j=1;
for i=1:iso_j;
    temp=[dp,tp(:,i)];
    if temp(:,2)>15
        d15(j,1)=NaN;
    else
        [ii20,~]=find(temp(:,2)>15);
        [siz_ii20,~]=size(ii20);
        x1=temp(siz_ii20,2);
        xi=15;
        x2=temp(siz_ii20+1,2);
        y1=temp(siz_ii20,1);
        y2=temp(siz_ii20+1,1);
        d15(j,1)=((xi*y2)-(x1*y2)+(y1*x2)-(y1*xi))/(x2-x1);
    end
end
