function [hb,vb] = datamap_mt(x,y,c,dx,dy,v,cax,ramp,edge,usermap)
%Function [hb,vb] = datamap_mt(X,Y,C,dX,dY,V,Cax,Ramp,Edge,Usermap) - PCOLOR data with land map.
%  For an XYZ matrix = [Lon,Lat,Value], gives a pseudocolor plot of 2-D scalar
%  data over the domain V = [MinLon,MaxLon,MinLat,MaxLat], and a land mask 
%  superimposed. 
%
%  The mandatory Cax vector will determine whether a colorbar will be added 
%  and what kind of color pallette scaling will occur over the image: 
%
%  If                pallette scaling is   colorbar is   for example:
%  ===============   ===================   ===========   ===================
%  Cax = [lo,hi]     as given by [lo,hi]   plotted       [-30,50], [-50,-30]
%  Cax = [hi,lo]     as given by [lo,hi]   not plotted   [50,-30], [-30,-50]
%  Cax =    1        [min,max] of data     plotted       
%  Cax =    0        [min,max] of data     not plotted   
%
%  If an integer Ramp ~= 0 is specified, the colors are ramped (interpolated) 
%  across the bins, giving a smoothed effect more suitable for presentation. 
%  If Ramp == 0, or is not specified (DEFAULT), the bins are constant-colored  
%  with faceted edges, giving a more accurate rendering of the actual data. 
%  Warning: Ramping causes data gaps to appear larger in the display unless 
%  they are first filled or interpolated.
%
%  Continents are filled by default and cover the data (oceanographic applications).
%  If either or both of dX,dY are negative, the data cover the filled continents and
%  a continental (unfilled) outline covers the data (meteorological applications).
%
%  The default color pallette is <cth> = "cold-to-hot". If the user desires an
%  alternate pallette, he/she issues the appropriate COLORMAP command after the
%  call to DATAMAP [e.g., >> colormap('gray')].        
%
%  If a colobar is summoned, the user will be queried to input the orientation
%  ('vert' or 'horiz'). A simple <CR> will trigger the default ('vert'). 
%  
%  The last parameter is also optional, Edge = 'k' (default) or = 'w'. 
%  If Edge = 'k', the facet edges are invisible on the screen plot and appear 
%  as black lines when printed, elseif Edge = 'w', the converse is true.
%  Edge = 'none' suppresses edges. For dense grids this may be like Ramp = 1
%  but more efficient.
%
%  Uses calls to XYZ2MAT and COASTMAP

% Best guess at a grid & label interval for coastmap
%
% Edited by Jonathan Cedeño at Jun/06/2007
% jcedeno@espol.edu.ec

x=x'; y=y';

maplast = 0;
if (dx>0 & dy>0), maplast = 1; 
else; dx = abs(dx); dy = abs(dy); end

vv = v; if vv(1) >= vv(2); vv(2) = vv(2)+360; end
sz = (abs(diff(vv(1:2))) + abs(diff(vv(3:4))));
if sz >= 200, dxdy = 20*floor((diff(vv(1:2)) + diff(vv(3:4)))/200);
elseif sz >= 100, dxdy = 10*floor((diff(vv(1:2)) + diff(vv(3:4)))/100);
elseif sz >= 50, dxdy = 5*floor((diff(vv(1:2)) + diff(vv(3:4)))/50);
else dxdy = 5; % dxdy = 2;
end

% %  Fix a cross-Greenwich situation if it exists
% if v(2) <= v(1) & v(2) <= 20
%     jj = find(xyz(:,1)<=v(2)); xyz(jj,1) = xyz(jj,1) + 360;
% end

% [c,vv,x,y] = xyz2mat(xyz,dx,dy); 
% [c,vv,x,y] = grid_interp(xyz,dx,dy);

% Parse the input arguments
if nargin < 8; ramp = 0; edge = 'k'; end
if nargin == 8;
	if isstr(ramp); edge = ramp; ramp = 0; else; edge = 'k'; end
end

nx=length(x); dx = mean(diff(x));
ny=length(y); dy = mean(diff(y)); 

% Pad the leftmost columns and bottommost rows
[nr,nc] = size(c);
c=flipud(c); c=[c',nan*ones(nc,1)]';
c=fliplr(c); c=[c,nan*ones(nr+1,1)];
if ramp ~= 0
	for k=1:nc+1
		jj=findis(c(:,k)); 
		if jj(1)>1; c(jj(1),k)=c(jj(1)-1,k); end
	end
	c(nr+1,:)=c(ny,:);
	for k=1:nr+1
		jj=findis(c(k,:));
		if jj(1)>1; c(k,jj(1))=c(k,jj(1)-1); end
	end
	c(:,nc+1)=c(:,nx);
end
c=fliplr(c); c=flipud(c);
x=[x(1)-dx,x,x(nx)+dx];
y=[y(1)-dy,y,y(ny)+dy];

% Augment the data matrix to avoid truncation of raster plot
% and calculate grid definition vectors required by PCOLOR
[nr,nc]=size(c);
cc=[c nan*ones(nr,1)]; cc=[cc' nan*ones(nc+1,1)]';
x1=x(1)-.5*dx; x2=x(nx+1)+.5*dx; xx=x1:dx:x2;
y1=y(1)-.5*dy; y2=y(ny+1)+.5*dy; yy=y1:dy:y2;
if ramp ~= 0
	for k=1:nr; jg=find(isnan(cc(k,:))==0); cc(k,max(jg)+1)=cc(k,max(jg)); end
	for k=1:nc; jg=find(isnan(cc(:,k))==0); cc(max(jg)+1,k)=cc(max(jg),k); end
	y1=y(1); y2=y(ny+1)+dy; yy=y1:dy:y2;
	x1=x(1); x2=x(nx+1)+dx; xx=x1:dx:x2;
end
[nr,nc]=size(cc);

% Execute plot & options
% Pcolor plot
length(xx);
length(yy);
hpc = pcolor(xx,yy,cc); set(hpc,'edgecolor',edge)
%get(hpc)
%set(hpc)

% Construct a "cold-to-hot" color pallette
cth=flipud(hsv(256));
cth=cth(fix(32:3.5:255),:);

% Set color options
if ramp ~= 0; shading('interp'); end
colormap(cth);    % pallette = c2h, cth, gray, etc.

% if v(2)-v(1)<=6 & v(4)-v(3)<=6, dxdy=1; end ORIGINAL
if v(2)-v(1)<=10 & v(4)-v(3)<=10, dxdy=1; end

% Plot the land mask
if nargin <= 9
    if maplast == 1;
        hold on, coastmap(v,1,dxdy); else, hold on, coastmap(v,'nofill',dxdy); 
    end
elseif nargin == 10
    if strcmp(usermap,'coast_c3bac')==1,
        if maplast == 1;
            hold on, coastmap(v,1,[20,5],usermap); else, hold on, coastmap(v,'nofill',[20,5],usermap);
        end
    else
        if maplast == 1;
            hold on, coastmap(v,1,dxdy,usermap); else, hold on, coastmap(v,'nofill',dxdy,usermap);
        end
    end
end

% Replot the axes box to black if  <edge> = 'w'
if strcmp(edge,'w'), plot([v(1),v(2),v(2),v(1),v(1)],[v(3),v(3),v(4),v(4),v(3)],'-k'), end

barpos = 'vert';  % OJO!!! CAMBIAR SGUN LAS NECESIDADES, 'vert' / 'horiz'

if length(cax) == 1
	if cax == 1; hb=colorbar(barpos); vb=get(hb,'position'); end
else
	if cax(1) < cax(2); caxis(cax);	hb=colorbar(barpos); vb=get(hb,'position');	else, ...
            caxis(fliplr(cax)); end
end

hold off