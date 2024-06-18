function [out,tout]=pentads(data,time)
% function [out,tout]=pentads(data,time)
%
% PENTADS promedios de cinco dias
%
% Variables de entrada:
%
%   data = [m x n], donde: m --> espacio (e.g.: posiciones, profundidad)
%                          n --> tiempo
%   time = [m x 1], dias julianos
%
% Variables de salida:
%
%    out = pentads (data averaged in five days)
%   tout = time pentads
%          [!] el tiempo reportado está centrado en el día 3

% 29/09/2014, jcedeno@udec.cl

% pentadas ajustadas al inicio/fin de año (73)

load('d:\J577\zmatlab\common_mat\mat_pentads.mat'),
% whos
%   Name             Size            Bytes  Class     Attributes
% 
%   ptds            73x2              1168  double              
%   ptds_bfin       73x2              1168  double              
%   ptds_bini       73x2              1168  double              
%   time_1985      365x5             14600  double 

time_vec=datevec(time);
time=[time,time_vec(:,1:3)];

yr_ini=time(1,2);   yr_fin=time(end,2);
yr_st=[yr_ini:1:yr_fin]';

[nm,nn]=size(data);

k=1;
for i=1:length(yr_st),
    ix1=find(time(:,2)==yr_st(i));
    ty_dt=data(:,ix1);
    ty_tm=time(ix1);
    % averaging...
    bini=datenum([ones(73,1).*yr_st(i),ptds_bini,...
        zeros(73,1),zeros(73,1),zeros(73,1)]);
    bfin=datenum([ones(73,1).*yr_st(i),ptds_bfin,...
        zeros(73,1),zeros(73,1),zeros(73,1)]);
    for j=1:73,
        ty_tout1(j,:)=mean([bini(j):1:bfin(j)]);
        ix2=find(ty_tm>=bini(j) & ty_tm<=bfin(j));
        if isempty(ix2)==1,
            ty_out1(:,j)=ones(nm,1).*NaN;
        else
            ty_out1(:,j)=nanmean(ty_dt(:,ix2),2);
        end
        ix2=[];
    end
    out(:,k:k+72)=ty_out1;
    tout(1,k:k+72)=ty_tout1';
    k=k+73; 
    ix1=[]; ty_dt=[]; ty_tm=[];
    bini=[]; bfin=[];
end
        
