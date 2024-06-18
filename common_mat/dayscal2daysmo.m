function days_mo=dayscal2daysmo(dayscal)
% function days_mo=dayscal2daysmo(dayscal)
%
% DAYSCAL2DAYS_MO Buscador de dias calendarios y su equivalente en 
% dia-mes.

load('c:\J577\zmatlab\common_mat\days_ref.mat')

% whos
%   Name                   Size            Bytes  Class     Attributes
% 
%   days_ref_leap        366x3              8784  double              
%   days_ref_noleap      365x3              8760  double  

% <days_ref_leap> y <days_ref_leap>, tienen tres columnas
%                           1   2   3
%                   dia_calen mes dia 

% -------------------------------------------------------------------------
% ------------- Trabajamos con un año-tipo NO BISIESTO --------------------
% -------------------------------------------------------------------------

for i=1:length(dayscal(:,1)),
    id_daysmo(i,:)=find(days_ref_noleap(:,1)==dayscal(i));
end

days_mo=days_ref_noleap(id_daysmo,2:3);