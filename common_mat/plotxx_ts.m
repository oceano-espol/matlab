function [ht,hs]=plotxx_ts(tp,sl,dp)
%function [ht,hs]=plotxx_ts(tp,sl,dp)
%
% PRUEBA!!!

line(sl,dp,'Color','r'), hs=gca;
set(hs,'XColor','r','YColor','k')

hs_pos=get(hs,'Position'); % store position of first axes
ht=axes('Position',hs_pos,...
    'XAxisLocation','top','YAxisLocation','right','Color','none');

line(tp,dp,'Parent',ht,'Color','b'),
set(ht,'XColor','b','YColor','k'),