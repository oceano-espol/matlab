function out=ts_var12(xy)
% function out=ts_var12(xy)
% 
% TS_VAR12  Varianza en segmentos de 12 puntos
%           Esta funcion resume la estimacion de la varianza en segmentos
%           de 12 puntos, con una tolerancia del 80% de datos perdidos.
%
%           [1] Estos requerimientos se ajustan específicamente al estudio
%           "Variabilidad Interanual de las Ondas Intraestacionales de
%           Kelvin en el Pacífico Ecuatorial Oriental"
%
%           [2] Editado desde ts_var120 para estimar la varianza en una
%           ventana movil de 12 meses
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

% estima la varianza intraestacional en segmentos de 12 puntos. así, el
% recorte de la serie está ajustado para que especificamente pierda 6
% puntos en los extremos de los datos, así como para que centre el eje de
% tiempo en el punto 6 de cada segmento.

% [OLD] estima la varianza intraestacional en segmentos de 120 puntos. así, el
% recorte de la serie está ajustado para que especificamente pierda 60
% puntos en los extremos de los datos, así como para que centre el eje de
% tiempo en el punto 60 de cada segmento.

% ------------------------ ATENCIÓN ---------------------------------------
% -------------------------------------------------------------------------

amp=12; hamp=6;

time=xy(hamp:length(xy(:,1))-hamp,1);
j=1;
for i=hamp:length(xy(:,1))-hamp,
    ty=xy(j:j+amp-1,2);
    ty_lst=ts_lost(ty);
    if ty_lst<=20, ivr(j,:)=var(ty); else ivr(j,:)=NaN; end
    clear ty ty_lst
    j=j+1; 
end

out=[time,ivr];



