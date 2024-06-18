function rms=ts_rms(x)
% function rms=ts_rms(x)
%
% TS_RMS Root Mean Square (NaN)
%        Estima la media cuadrática. 
%        Si encuentra valores NaN, los ignora utilizando <nanmean(x.^2)>

% 10\aug\2015, jcedeno@udec.cl

rms = sqrt(nanmean(x.^2));