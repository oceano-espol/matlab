function [pc,evec,eval]=ts_eof(data)
% function [pc,evec,eval]=ts_eof(data)
%
% TS_EOF Analisis de componentes principales (PCA/EOF)
%        Estima los modos principales, vectores propios y valores propios
%        que conforman el análisis de componentes principales.
%        Debido a que trabaja con la matriz de covarianza, se requiere que
%        los datos sean anomalías, así como que estén debidamente
%        estandarizados.
%
% Variables de entrada:
% 
%   data = matriz de datos [m x n]
%          dimension [m] --> estaciones
%          dimension [n] --> tiempo (pasos de)
%
% Variables de salida:
%
%     pc = componentes principales
%   evec = vectores propios (eigenvectors)
%   eval = valores propios (eigenvalues)

% Inspirado en la clase de análisis de componentes principales del 14 de
% mayo del 2014. Curso de "Análisis Estadístico del Clima". Departamento
% de Geofísica, Universidad de Concepción.

% Created: 20/may/2014, jcedeno@udec.cl


[M,N]=size(data);

% if N<M,
%     error('las dimensiones no coinciden, revisar SVP'),
% end

mcov=(data*data')/(N-1);

% el sufijo <ns> significa "no ordenado"
% el sufijo <sr> significa "ordenado"
% ...
[evec_ns,eval_ns]=eig(mcov);

eval_ns=diag(eval_ns);
[~,ix]=sort(eval_ns);

pc_ns=data'*evec_ns; 

evec_sr=sortrows([ix,evec_ns],-1); evec_sr=evec_sr(:,2:length(evec_sr(1,:)));
eval_sr=sortrows([ix,eval_ns],-1); eval_sr=eval_sr(:,2:length(eval_sr(1,:)));

pc_sr=sortrows([ix,pc_ns'],-1);  pc_sr=pc_sr(:,2:length(pc_sr(1,:))); 
pc_sr=pc_sr';

evec=evec_sr; eval=eval_sr; pc=pc_sr;

