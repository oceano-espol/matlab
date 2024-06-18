function [x,y] = rot2d(xi,yi,teta)
%ROT2D   2D rotation
%   [X,Y] = ROT2D(XI,YI,TETA)
%   Rotates matriz xi and yi with angle teta 
%
%   input:
%      XI, YI   initial positions
%      TETA     angle to rotate (deg)
%
%   output:
%      X, Y   rotated positions
%
%   example:
%      x=1; y=1;
%      plot([0 x], [0 y]); hold on
%      [x,y]=rot2d(x,y,40);
%      plot([0 x], [0 y],'r'), axis equal
%
%   MMA 13-1-2003, martinho@fis.ua.pt
%   Revision 10-2003
%
%   See also ROT3D

if nargin ~= 3
   error('rot2d must have x,y and teta as input arguments');
   return
end
if size(xi)~=size(yi)
   error('xi and yi must have same size');
   return
end

teta=teta*pi/180;
[th,r]=cart2pol(xi,yi);
% [x,y]=pol2cart(th+teta,r);
[x,y]=pol2cart(teta,r);      % 8/apr/2015, ed.
