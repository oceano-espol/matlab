function hp_x=ts_lanczos_hp(x,T1)
% function hp_x=ts_lanczos_hp(x,T1)
%
% TS_LANCZOS_HP Resumen de pasos en la ejecucion del filtro Coseno-Lanczos,
%               con la funcion de transferencia incluida (para el caso
%               pasa-banda).
%
% Variables de entrada:
%
%     x = datos originales (sin el eje de tiempo)
%    T1 = Periodo de corte T1
%
% Variables de salida:
%
%  hp_x = datos filtrados (highpass)

% 22/dec/2014, jcedeno@udec.cl

p1 = filtrocl(T1,T1*3);
lp_x = filtrado(x,p1);
hp_x = x-lp_x;