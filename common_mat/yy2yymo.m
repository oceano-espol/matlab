function out=yy2yymo(date_timefrac)
% function out=yy2yymo(date_timefrac)
%
% YY2YYMO Convertidor de [yy + frac.] --> [yy,mo]
%        ¨Permite convertir el eje de tiempo mensual expresado en annos +
%         frección hacia un formato de anno + mes calendario.
%
% Variables de entrada:
%
%    date_timefrac = [anno + fraccion de anno]
% 
% Variables de salida:
%
%              out = [anno,mes]

%             parte de <common_mat>
% 2014/07/10, jcedeno@udec.cl


year_ini=floor(date_timefrac(1,1));
year_fin=floor(date_timefrac(length(date_timefrac(:,1)),1));

sec_years=[year_ini:1:year_fin]';

for i=1:length(sec_years),
    
    date_mo(i,:)=[1:1:12];
    date_yr(i,:)=[ones(1,12).*sec_years(i)];
    
end

out_ty1=reshape(date_yr',length(date_timefrac(:,1)),1);
out_ty2=reshape(date_mo',length(date_timefrac(:,1)),1);

out=[out_ty1,out_ty2];


