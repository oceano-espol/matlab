function multiplot(x,y,offset,sym,lbl)
%function multiplot(x,y,offset,sym,lbl)
% 
% MULTIPLOT Plots multiple data columns on the same plot with Y-offsets.
% Each data column is demeaned and graphed as an x-oriented strip plot
% below the previous strip (data column) by an amount delta-Y = OFFSET. 
% If OFFSET is scalar, offsets are uniform. If vector, each strip will 
% have unique offset. X contains the x-axis values. 
%   
% Useful for multiple time series of correlated time series with common
% units. SYM (e.g.,'-b') = plot symbol and line color to be used for 
% the data. LBL (if used) is a string array with as many rows as there 
% are columns in Y, each row containing an identifying ASCII string to 
% be written above & to the right of the user coordinate returned by a
% mouseclick ([x,y]=GINPUT). If LBL is missing, the GINPUTting of labels 
% will be skipped. Missing data should be coded = NaN. 

[nr,nc]=size(y);

% Determine the plot dimensions and set axes
xmin=floor(x(1));xmax=ceil(x(length(x)));
ymin=floor(min(y(findnot(y(:,nc)),nc)))-(nc-1)*offset;
ymax=ceil(max(y(findnot(y(:,1)),1)));

% Demean the data and apply offsets
y=y-ones(nr,1)*meanmiss(y);
off=0:offset:(nc-1)*offset;
y=y-ones(nr,1)*off;[xx,yy]=size(y)

% Set arrays for x-axes (lines where x=0) of strips and plot
ax=ones(nc,1)*[xmin xmax];
ay=[-off' -off'];

for i=1:nc
    plot(x,y(:,i),sym{i}), hold on,
end

plot(ax',ay','-k')
% plot(x,y,sym,ax',ay','-k')
% axis([xmin,xmax,ymin,ymax]);

% % GINPUT plot labels if LBL exists
% if nargin<4;return;end
% for k=1:nc
%  [xx,yy]=ginput(1);
%  text(xx,yy,lbl(k,:))
% end 


function jj=findnot(x)
% FINDNOT finds the indices of the matrix X where the values ­ NaN.

jj=find(~isnan(x)==1);