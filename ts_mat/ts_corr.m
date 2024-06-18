function r=ts_corr(x,y)
% function r=ts_corr(x,y)
%
% TS_CORR Correlacion (NaN)
%         Estima la correlacion con la funcion <corrcoef>
%         Si encuentra valores NaN, los ignora utilizando <igNaN>

% 10\aug\2015, jcedeno@udec.cl

% [!] rules
%     x / y deben ser vectores columna

ix=find(isnan([x;y])==1);

if sum(ix)~=0,
    % ignoring nan ---
    ty=igNaN([x,y]);
else
    ty=[x,y];
end

r = corrcoef(ty(:,1),ty(:,2));
r = r(2,1);