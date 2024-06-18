function [y,a,b]=my_butter(x,o,Ls,L1,L2)
%function [y,a,b]=my_butter(x,o,Ls,L)
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

% if nargin == 4
%     L2='lowpass';
% end

if strcmp(L2,'lowpass')
    Wo=[2*Ls/L1]; [b,a]=butter(o,Wo,'low');     y=filtfilt(b,a,x);
elseif strcmp(L2,'highpass')
    Wo=[2*Ls/L1]; [b,a]=butter(o,Wo,'high');    y=filtfilt(b,a,x);
elseif isnumeric(L2)
    Wo=[(2*Ls)/L2,(2*Ls)/L1]; [b,a]=butter(o,Wo);   y=filtfilt(b,a,x);
end

% [b,a]=butter(o,Wo); y=filtfilt(b,a,x);

% Codigo Original
% [b,a]=butter(o,2*Ls/L); y=filtfilt(b,a,x);