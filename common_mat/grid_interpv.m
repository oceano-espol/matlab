function [c_v,v,x_outv,y_outv]=grid_interpv(xyz,dx,dy)
%function [c_v,v,x_outv,y_outv]=grid_interpv(xyz,dx,dy)
% Esta funcion encuentra la matriz <c> resultante de la interpolacion
% de los datos de xyz a una distancia dx (en longitud) y dy (en latitud).
%
% El resultado de los valores interpolados (c) a puntos especificados
% por x_out & y_out es presentado en formato de serie de tiempo.
%
% Las variables de entrada son:
%
%    xyz = Matriz de datos de entrada.
%          1era. col., Longitud [grad.]
%          2da.  col., Latitud [grad.]
%          3era. col., Variable oceanografica [¿?]
%     dx = Espaciamiento en el eje x (longitud) [grad.]
%     dx = Espaciamiento en el eje y (latitud) [grad.]
%
% Las variables de salida son:
%
%      c = Matriz de salida correspondiente a la variable
%          oceanografica interpolada.
%      v = Valores max. y min. de la longitud y latitud
%          cargadas en la matriz xyz(:,1:2).
%  x_out = Longitud interpolada a dx.
%  y_out = Latitud interpolada a dy.
%
% CALLS: min, max, meshgrid, griddata, reshape
%
% USED BY: datamap, coastmap

% Esta rutina esta basada en la funcion <xyz2mat>, la cual genera ciertos problemas
% cuando se trabaja con pocos datos en una region relativamente grande.
% 
% 24/Jul/2005 Jonathan Cedeño, FIMCM-ESPOL (Ecuador).
%
% Testada por el curso de Oceanografia Fisica (1er. Termino, 2005) de la
% Escuela Superior Politecnica del Litoral.


x_in=xyz(:,1);                      % Longitud (x)
y_in=xyz(:,2);                      % Latitud (y)
z_in=xyz(:,3);                      % Dato (z)

xmin=min(x_in); xmax=max(x_in);
ymin=min(y_in); ymax=max(y_in);

lx=xmin:dx:xmax;
ly=ymin:dy:ymax;

[XI,YI]=meshgrid(lx,ly);

[x_outm,y_outm,c]=griddata(x_in,y_in,z_in,XI,YI,'linear'); 
% Interpolacion en la grilla de datos por el metodo 'linear' de MATLAB. 
% Tambien puede utilizarse los metodos 'cubic', 'nearest' y 'v4'.

[ii,jj]=size(x_outm);
x_outv=reshape(x_outm,(ii*jj),1);
y_outv=reshape(y_outm,(ii*jj),1);
c_v=reshape(c,(ii*jj),1);

v=[min(x_outv),max(x_outv),min(y_outv),max(y_outv)];