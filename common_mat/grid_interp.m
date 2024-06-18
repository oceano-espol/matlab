function [c,v,x_out,y_out]=grid_interp(xyz,dx,dy)
%function [c,v,x_out,y_out]=grid_interp(xyz,dx,dy)
% Esta funcion encuentra la matriz <c> resultante de la interpolacion
% de los datos de xyz a una distancia dx (en longitud) y dy (en latitud).
%
% El resultado de los valores interpolados (c_v) a puntos especificados
% por x_outv & y_outv es presentado en una matriz de tamaño 
% length(y_outv)*length(x_outv).
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
% La matriz <c> permite ademas que la funcion pcolor(c,x,y) genera un grafico
% de pseudo-color en un mapa correctamente orientado.  
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

x_out=x_outm(1,:);
y_out=y_outm(:,1)';
v=[min(x_out),max(x_out),min(y_out),max(y_out)];

