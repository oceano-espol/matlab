function [bp_x,hp_x,lp_x]=ts_lanczos_bp(x,T1,T2)
% function [bp_x,hp_x,lp_x]=ts_lanczos_bp(x,T1,T2)
%
% TS_LANCZOS_BP Resumen de pasos en la ejecucion del filtro Coseno-Lanczos,
%               con la funcion de transferencia incluida (para el caso
%               pasa-banda).
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

%               Jcedeno, 12/01/14

p1 = filtrocl(T1,T1*3);   p2 = filtrocl(T2,T2*3);

lp_x = filtrado(x,p2);
hp_x = x-lp_x;
bp_x = filtrado(hp_x,p1);