function [p,q,vm]=ts_prob(x,n)
% function [p,q,vm]=ts_prob(x,n)
% 
% TS_PROB Probabilidades
%
% Obtiene las probabilidad (p) y la probabilidad de no ocurrencia 
% (q, 1-p) de ocurrencia de un evento.
%
% Por defecto, las frecuencias relativas son obtiendas con <hist>,
% ajustados a diez (10) intervalos de clase.

[fr,vm]=hist(x,n); p=fr./sum(fr); q=1-p;  p=p'; q=q';
