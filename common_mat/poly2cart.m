function [x,y]=poly2cart(angle,radius)
%function [x,y]=poly2cart(angle,radius)
%
% POLY2CART Convertidor de coordenadas Polares [2] a Cartesianas, 
%           referidas al 0 geografico (o sea, 90 cartesiano)
%
% EDITED 11/APR/2010, Jonathan Cedeño, INOCAR

for i=1:length(angle(:,1))
    if isnan(angle(i))==0 | isnan(radius(i))==0,
        if angle(i)>=0 & angle(i)<=90
            [y_1,x_1]=pol2cart(angle(i)*(pi/180),radius(i));
        elseif angle(i)>=270 & angle(i)<=360
            angle_t=angle(i)-360;
            [y_1,x_1]=pol2cart(angle_t*(pi/180),radius(i));
        elseif angle(i)>=180 & angle(i)<270
            angle_t=90-angle(i);
            [x_1,y_1]=pol2cart(angle_t*(pi/180),radius(i));
        elseif angle(i)>90 & angle(i)<180
            angle_t=angle(i)-180;
            [y_1,x_1]=pol2cart(angle_t*(pi/180),radius(i));
            y_1=y_1*-1; x_1=x_1*-1;
        end
        x(i,:)=str2double(num2str(x_1,'%7.4f'));
        y(i,:)=str2double(num2str(y_1,'%7.4f'));
    else
        x(i,:)=NaN; 	y(i,:)=NaN;
    end
end