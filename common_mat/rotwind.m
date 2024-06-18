function [uu,vv]=rotwind(u,v,th)
% function [uu,vv]=rotwind(u,v,th)
% 
% ROTWIND Wind rotation 
%
% <th> angle, refered to North

if th>=-90 && th<=180,
    th2=90-th;
elseif th<-90 && th>-180,
    th2=-270-th;
end

uu=cos(th2*(pi/180))*sqrt(u^2+v^2);
vv=sin(th2*(pi/180))*sqrt(u^2+v^2);