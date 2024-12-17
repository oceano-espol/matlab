function [hb,vb] = datamap2(xyz,dx,dy,v,cax,ramp,edge)
%Function [hb,vb] = datamap2(XYZ,dX,dY,V,Cax,Ramp,Edge) - PCOLOR data with land map.
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
%  Continents are filled by default. If either or both of dX,dY are negative,
%  only continental outlines are shown.
%
%  The last parameter is also optional, Edge = 'k' (default) or = 'w'. 
%  If Edge = 'k', the facet edges are invisible on the screen plot and appear 
%  as black lines when printed, elseif Edge = 'w', the converse is true. 
%
%  Uses calls to XYZ2MAT and COASTMAP

% 02/Nov/05 Editada para su uso en MATLAB 6.5. 
%           Jonathan Cedeño, FIMCM-ESPOL. 

barpos = 'vert';

if(dx>0 & dy>0); cfill = 1; else cfill = 0; dx=abs(dx); dy=abs(dy); end

% [c,vv,x,y] = xyz2mat(xyz,dx,dy);
[c,vv,x,y] = grid_interp(xyz,dx,dy);

% Parse the input arguments
if nargin < 6; ramp = 0; edge = 'k'; end
if nargin == 6;
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

% Construct a "cold-to-hot" color pallette
cth=flipud(hsv(256));
cth=cth(fix(32:3.5:255),:);

% Execute plot & options

% Pcolor plot
length(xx);
length(yy);
hpc = pcolor(xx,yy,cc); set(hpc,'edgecolor',edge)

if length(cax) == 1
	if cax == 1; hb=colorbar(barpos); vb=get(hb,'position'); end
else
	if cax(1) < cax(2); 
		caxis(cax);
		hb=colorbar(barpos); 
		vb=get(hb,'position');
	else
		caxis(fliplr(cax));
	end
end

if ramp ~= 0; shading('interp'); end
colormap(cth);   % pallette = c2h, cth, gray, etc.

% Plot the land mask
hold on
% coastmap_g5(v,1)
coastmap2(v,1)
hold off 