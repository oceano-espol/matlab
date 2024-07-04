function [angle,radius]=cart2poly(x,y)
%function [angle,radius]=cart2poly(x,y)
%
% CART2POLY Convertidor de coordenadas Cartesianas a Polares [2]
%           referidas al 0 geográfico (o sea, 90 cartesiano)
%
% EDITED 11/APR/2010, Jonathan Cedeño, INOCAR


for i=1:length(x(:,1))
    if isnan(y(i))==0 | isnan(x(i))==0,
        if x(i)>0 & y(i)>0
            angle(i,:)=atan(x(i)/y(i))*(180/pi);
            disp('1'),
        elseif x(i)<0 & y(i)>0
            angle(i,:)=360+(atan(x(i)/y(i))*(180/pi));
            disp('2'),
        elseif x(i)<0 & y(i)<0
            angle(i,:)=270-(atan(y(i)/x(i))*(180/pi));
            disp('3'),
        elseif x(i)>0 & y(i)<0
            angle(i,:)=180+(atan(y(i)/x(i))*(180/pi));
            disp('4'),
        elseif x(i)==0 & y(i)>0,
            angle(i,:)=0;
            disp('5'),
        elseif x(i)==0 & y(i)<0,
            angle(i,:)=180;
            disp('6'),
        elseif x(i)>0 & y(i)==0,
            angle(i,:)=90;
            disp('7'),
        elseif x(i)<0 & y(i)==0,
            angle(i,:)=270;
            disp('8'),
        end
        radius(i,:)=(x(i)^2+y(i)^2)^(1/2);
    else
        radius(i,:)=NaN;         angle(i,:)=NaN;
    end
end
