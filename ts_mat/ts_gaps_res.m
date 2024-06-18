function res=ts_gaps_res(data)
% function res=ts_gaps_res(data)
% 
% GAPS_RES Informacion resumen de Gaps
%
% Variables de entrada:
%
%        data = (1) tiempo (julianos)
%               (2) data
% 
% Variables de salida:
%
%          res = resumen de los segmentos de datos
%               1     2    3     4
%               id  ini  end  long
%               id ---> (0) tiene NaN
%                       (1) NO tiene NaN
%
% keywords: resume

if length(data(1,:))~=2,
    error('la dimension de columnas es incorecta. revisar SVP')
end

x=data(:,1);    % tiempo
y=data(:,2);    % datos

id_NaN=isnan(y);
id_0s=find(id_NaN==0); y_0s=y(id_0s,1);     % [0] no_NaN
id_1s=find(id_NaN==1); y_1s=y(id_1s,1);     % [1] si_NaN

% [2] buscando los indices de bloques de datos ----------------------------
% con la definicion a continuacion, cualquier valor diferente a 0 marca 
% el inicio de cada bloque.
% ...
block_1=[1;diff(id_NaN)];
id_block_ini=find(block_1~=0);
id_block_fin=[id_block_ini(2:length(id_block_ini(:,1)))-1;length(y)];

for i=1:length(id_block_ini),
    if sum(isnan(y(id_block_ini(i):id_block_fin(i))))>0,
        id_block(i,1)=0;    % [0] El bloque contiene NaNs
    else
        id_block(i,1)=1;    % [1] El bloque NO contiene NaNs
    end
end

% <res> resumen de los bloques de datos
%  1   2   3    4
% ID INI FIN LONG
% ...
res=[id_block,id_block_ini,id_block_fin,id_block_fin-id_block_ini+1]; pause(0.5)

% [id_block,id_block_ini,id_block_fin,id_block_fin-id_block_ini+1]
% 
% ans =
% 
%      0     1     3     3
%      1     4    23    20
