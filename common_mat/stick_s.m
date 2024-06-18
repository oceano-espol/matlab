function stick_s(t,x,y,stretch,offset)
%function stick_s(t,x,y,stretch,offset) makes a stick plot from x and y
%at points t along the horizontal axis.
%t must be a column vector.
%x and y may be matrices but must have the same number of rows as t.
%stretch is a stretching factor in units of x/t.
%offset is a vertical offset in units of x.
%
%D. Rudnick January 23, 1996.
%modified September 9, 1997 - x-axis units are now t rather than stretch*t.

if nargin < 5
   offset=0;
end
if nargin < 4
   stretch=1;
end
[n,m]=size(x);
tp=nan*ones(3*n,m);
xp=nan*ones(3*n,m);
tp(1:3:3*n,:)=t*ones(1,m);
tp(2:3:3*n,:)=tp(1:3:3*n,:)+x/stretch;
xp(1:3:3*n,:)=offset*ones(n,1)*(0:m-1);
xp(2:3:3*n,:)=xp(1:3:3*n,:)+y;
plot(tp,xp);
set(gca,'DataAspectRatio',[1 stretch 1]);



