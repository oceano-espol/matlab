function [y,a,b]=my_boxcar(x,L)
%function [y,a,b]=my_boxcar(x,L)
% Butterworth filter, uses 'butter.m' to filter the data.
% See Furevik (2001) p. 12-16
% 
% In:  <x> is a vector with the data, <o> is the order of the filter,
%      <Ls> is the sampling period and <L1 / l2> is the length of the filter
%      (cutoff freq. fc=1/L).
%      If the filter requirement is band-pass type, especify L1 & L2.
%      If the filter requirement is low-pass or high-pass type, 
%      especify only one value (L1).
% Out: <y> is a vector with the filtered data.
% 
% May 2005, Saeunn
% 08/Jul/2007, Jonathan Cedeño

b=boxcar(L)/L; a=1; y=filtfilt(b,a,x);