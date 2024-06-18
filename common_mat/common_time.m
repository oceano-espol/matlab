function [tmc,ix1,ix2]=common_time(tm1,tm2)
% function [ixc,ix1,ix2]=common_time(tm1,tm2)
%
% COMMON_TIME Estima los indices coincidentes de dos series de tiempo
%             basados en la fijación del periodo común entre ellos.
%             Básico para construir correlaciones.
%
% (old coincidence)
%
% keywords: common

% 21\apr.\2015, jcedeno@udec.cl

if tm1(1)>tm2(1),
    tmst=tm1(1);
elseif tm1(1)<tm2(1),
    tmst=tm2(1);
else
    tmst=tm1(1);
end

if tm1(end)<tm2(end),
    tmnd=tm1(end);
elseif tm1(end)>tm2(end),
    tmnd=tm2(end);
else
    tmnd=tm1(end);
end

% [datevec(tmst);datevec(tmnd)], pause,

% [tm1] para los indices del eje de tiempo 1
%       ...
ix1=find(tm1>=tmst & tm1<=tmnd);

% [tm2] para los indices del eje de tiempo 2
%       ...
ix2=find(tm2>=tmst & tm2<=tmnd);

% [tmc] time-axis common
%       ...
tmc=tm1(ix1);

