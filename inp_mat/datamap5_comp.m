function datamap5_comp(xyz,dx,dy,v,cax,ramp,edge)
%function datamap5_comp(xyz,dx,dy,v,cax,ramp,edge)
% Prueba!!!


datamap6(xyz,dx,dy,cax,ramp);
hold on; [c,v,x_out,y_out]=grid_interp(xyz,dx,dy);
[c1,c2]=contour(x_out,y_out,c,'k');clabel(c1,c2,'fontweight','bold');set(c2,'linewidth',1);
coastmap_ec(v,1);