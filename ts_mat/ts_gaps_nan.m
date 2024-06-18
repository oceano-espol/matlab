function res=ts_gaps_nan(data)
% function res=ts_gaps_nan(data)
% 
% GAPS_NAN ID de segmentos donde no hay datos (NaN)
%      *Trabajada a partir de <ts_gaps_res>, pero optimizada
%       para entregar en <res> solo la info relevante a los segmentos
%       donde hay brechas, y con fechas como vector (datevec).
%
% Variables de entrada:
%
%        data = (1) tiempo (julianos)
%               (2) data
% 
% Variables de salida:
%
%          res = segmentos en donde no existen datos (NaN)
%                    1       2    3    4    5    6    7    8     9
%               pos(i)  pos(f)  yri  moi  dyi  yrf  mof  dyf  long
%
%               id ---> (0) tiene NaN
%                       (1) NO tiene NaN
%
% keywords: resume

% 30\apr\2015, jcedeno@udec.cl


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
res=[id_block,id_block_ini,id_block_fin,id_block_fin-id_block_ini+1];

%% added 30\apr\2015

ix=find(res(:,1)==0);
res=res(ix,2:4);

dvec_i=datevec(data(res(:,1),1));
dvec_f=datevec(data(res(:,2),1));

res=[res(:,1:2),dvec_i(:,1:3),dvec_f(:,1:3),res(:,3)];

