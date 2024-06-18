function out=ts_var364(xy)
% function out=ts_var364(xy)
% 
% TS_VAR364 Varianza en segmentos de 364 puntos
%           Esta funcion resume la estimacion de la varianza en segmentos
%           de 364 puntos, con una tolerancia del 80% de datos perdidos.
%
%           [1] Estos requerimientos se ajustan específicamente al estudio
%           "Variabilidad Interanual de las Ondas Intraestacionales de
%           Kelvin en el Pacífico Ecuatorial Oriental"
%
%           [2] Editado desde ts_var120 para estimar la varianza en una
%           ventana movil de 364 dias (un año)
%
% Variables de entrada:
%
%    xy = (1) tiempo (dias julianos)
%         (2) datos (e.g., nivel medio del mar, en cm)
%             OJO: para la tesis, se estima la varianza intraestacional a
%             partir del ISL (nivel medio intraestacional).
%
% Variables de salida
%
%   out = (1) tiempo ivr (dias julianos)
%         (2) ivr (varianza intraestacional, en cm^2)

% -------------------------------------------------------------------------
% ------------------------ ATENCIÓN ---------------------------------------

% estima la varianza intraestacional en segmentos de 364 puntos. así, el
% recorte de la serie está ajustado para que especificamente pierda 182
% puntos en los extremos de los datos, así como para que centre el eje de
% tiempo en el punto 182 de cada segmento.

% [OLD] estima la varianza intraestacional en segmentos de 120 puntos. así, el
% recorte de la serie está ajustado para que especificamente pierda 60
% puntos en los extremos de los datos, así como para que centre el eje de
% tiempo en el punto 60 de cada segmento.

% ------------------------ ATENCIÓN ---------------------------------------
% -------------------------------------------------------------------------

time=xy(182:length(xy(:,1))-182,1);
j=1;
for i=182:length(xy(:,1))-182,
    ty=xy(j:j+363,2);
    ty_lst=ts_lost(ty);
    if ty_lst<=20, ivr(j,:)=var(ty); else ivr(j,:)=NaN; end
    clear ty ty_lst
    j=j+1; 
end

out=[time,ivr];



