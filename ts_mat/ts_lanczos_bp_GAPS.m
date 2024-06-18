function [bp_x,hp_x,lp_x]=ts_lanczos_bp_GAPS(x,T1,T2)
% function [bp_x,hp_x,lp_x]=ts_lanczos_bp_GAPS(x,T1,T2)
%
% TS_LANCZOS_BP_GAPS Filtro Coseno-Lanczos pasabanda (con gaps),
%                    Similar a <TS_LANCZOS_BP>, pero se incluye el loop 
%                    para trabajar con datos que tienen GAPS. 
%
% Variables de entrada:
%
%     x = datos originales (sin el eje de tiempo)
%    T1 = Periodo de corte T1
%    T2 = Periodo de corte T2
%         *T2 > T1
%
% Variables de salida:
%
%  bp_x = datos filtrados (bandpass)
%  hp_x = datos filtrados (highpass)
%  lp_x = datos filtrados (lowpass)
%
% CALLS: ts_gaps_res, ts_lanczos_bp

%               Jcedeno, 12/01/14

% [1] usamos <ts_gaps_res> para obtener la informacion de bloques de datos
%     que contienen GAPS.
%
%   --->   res = ts_gaps_res(data)
%          res = resumen de los segmentos de datos
%               1     2    3     4
%               id  ini  end  long
%               id ---> (0) tiene NaN
%                       (1) NO tiene NaN

res=ts_gaps_res([x,x]);

% [2] usamos <ts_lanczos_bp> para filtrar los bloques de datos libres de
%     NaNs (identificados como 1s).

bp_x=x; hp_x=x; lp_x=x;

for i=1:length(res(:,1)),
    if res(i,1)==1, % bloques libres de nans
        [bp_x(res(i,2):res(i,3),1),hp_x(res(i,2):res(i,3),1),...
            lp_x(res(i,2):res(i,3),1)]=ts_lanczos_bp(x(res(i,2):res(i,3),...
            1),T1,T2);
    end
end
    
