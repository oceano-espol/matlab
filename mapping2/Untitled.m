lc_bati_dharma_20120630
%
% lc_bati_dharma_20120630
% Instrucciones para plotear un grafico de batimetría del Pacífico Sureste,
% a pedido de Dharma Reyes (UdeC programa de postgrado de Oceanografia).

% c:\J577\zmatlab\conce13\bati_dharma

% whos
%   Name               Size              Bytes  Class     Attributes
% 
%   ans                1x35                 70  char                
%   bat            97556x1              780448  double              
%   lat_d          97556x1              780448  double              
%   lon_d          97556x1              780448  double              
%   mat2min_c        707x175            989800  double              
%   mat2min_v          1x4                  32  double              
%   mat2min_x          1x175              1400  double              
%   mat2min_y          1x707              5656  double              
%   vv                 1x4                  32  double

% -------------------------------------------------------------------------
% Los datos de batimetria fueron descargados del archivo ------------------
% C:\J577\zmatlab\mapping2\ETOPO2v2g_f4.nc --------------------------------
% Resolucion original, dos minutos. Puesta en formato "matriz" con la -----
% funcion <xyz2mat>, con 0.034 minutos de resolución [dx=dy=2.04]. --------
% (ver C:\J577\zmatlab\mapping2\Calculador de grilla xyz2mat.xls) ---------
% -------------------------------------------------------------------------

