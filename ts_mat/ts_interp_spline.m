function [out,id2_1s,res_f]=ts_interp_spline(data,length_gap)
% function [out,id2_1s,res_f]=ts_interp_spline(data,length_gap)
%
% TS_INTERP_SPLINE Relleno de una serie de tiempo con splines
% 
% Variables de entrada:
%
%        data =    1    2
%               TIME DATA
%  length_gap = un numero que marca la longitud del segmento objetivo
%               [double]
%               'all' si se quiere llenar todos los vacios de la ST.
%               [strings]
% 
% Variables de salida:
%
%         out = datos interpolados de salida
%               1    2
%               TIME DATA
%      id2_1s = indicador inicio/fin de los segmentos rellenados
%               1    2
%               ini end
%          res = resumen de los segmentos de datos
%               1     2    3     4
%               id  ini  end  long
%               id ---> (0) tiene NaN
%                       (1) NO tiene NaN

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
        id_block(i,1)=0;    % El bloque contiene [0] NaNs
    else
        id_block(i,1)=1;    % El bloque NO contiene [1] NaNs
    end
end

% <res> resumen de los bloques de datos
%  1   2   3    4
% ID INI FIN LONG
% ...
res=[id_block,id_block_ini,id_block_fin,id_block_fin-id_block_ini+1]; % pause(0.5)

% [id_block,id_block_ini,id_block_fin,id_block_fin-id_block_ini+1]
% 
% ans =
% 
%      0     1     3     3
%      1     4    23    20

if isnumeric(length_gap)==1,
    
    id_ly=find(res(:,4)<=length_gap & res(:,1)==0);

    % added 13JAN2016, JT
    
    if isempty(id_ly)==0,
        
        j=1;
        for i=1:length(id_ly),
            % res(id_ly(i),4),
            if i==1,
                % [1:res(id_ly(i),4)],
                id2_1s(j:res(id_ly(i),4),1)=[res(id_ly(i),2):1:res(id_ly(i),3)]';
                j=res(id_ly(i),4);
            else
                % [res(id_ly(i),2):1:res(id_ly(i),3)], disp('saab'),
                % [j+1,j+res(id_ly(i),4)], pause,
                id2_1s(j+1:j+res(id_ly(i),4),1)=[res(id_ly(i),2):1:res(id_ly(i),3)]';
                j=res(id_ly(i),4)+j;
            end
        end
        
        y2_1s=y(id2_1s,1);      % nueva <y> con aquellos segmentos NaN menores o
        % igual a lo especificado en <length_gap>
        
        % ejecutando interpolacion---
        % YI = INTERP1(X,Y,XI)
        % ...
        for i=1:length(id2_1s),
            y_interp(i,:)=interp1(x(id_0s),y(id_0s),x(id2_1s(i)),'spline');
        end
        
        data_bckp=data;
        data(id2_1s,2)=y_interp;
        out=data;
        
    else
        
        error('la long. de los segmentos con NaNs es mayor que <length_gap>. revisar <res>'),
        
    end
    
else
    
    id_ly=find(res(:,1)==0); length(id_ly);
    
    j=1;
    for i=1:length(id_ly),
        % res(id_ly(i),4),
        if i==1,
            % [1:res(id_ly(i),4)],
            id2_1s(j:res(id_ly(i),4),1)=[res(id_ly(i),2):1:res(id_ly(i),3)]';
            j=res(id_ly(i),4);
        else
            % [res(id_ly(i),2):1:res(id_ly(i),3)], disp('saab'),
            % [j+1,j+res(id_ly(i),4)], pause,
            id2_1s(j+1:j+res(id_ly(i),4),1)=[res(id_ly(i),2):1:res(id_ly(i),3)]';
            j=res(id_ly(i),4)+j;
        end
    end
    
    y2_1s=y(id2_1s,1);      % nueva <y> con aquellos segmentos NaN menores o 
                            % igual a lo especificado en <length_gap>
                            
    % ejecutando interpolacion---
    % YI = INTERP1(X,Y,XI)
    % ...
    for i=1:length(id2_1s),
        % x(id2_1s(i)), disp('estonoesunpaseo'), pause,
        y_interp(i,:)=interp1(x(id_0s),y(id_0s),x(id2_1s(i)),'spline');
    end
    
    data_bckp=data;
    data(id2_1s,2)=y_interp;
    out=data;
    
end

res_f=ts_gaps_res(out);
