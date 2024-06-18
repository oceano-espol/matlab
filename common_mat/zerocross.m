function wave=zerocross(data,frequency,threshold)
% function wave=zerocross(data,frequency,threshold)
%
% ZEROCROSS Zero crossing analysis of wave data
%
%    ZERO_CROSSING (DATA, FREQUENCY)
%    ZERO_CROSSING (DATA, FREQUENCY, THRESHOLD)
%    RESULT = ZERO_CROSSING (...)
%    [RESULT, NAMES] = ZERO_CROSSING (...)
%
% DATA is the input array of water elevation (a time column will be
% ignored). It can also be an cell array data. Any linear trend or 
% mean will be removed. If PT data are used, the pressure attenuation
% must be corrected with PR_CORR before calling the present function.
% The optional third argument is the THRESHOLD for a crest or trough 
% to be considered; if not given, a value of 1% of Hmax is assumed.

% written by Urs Neumeier
% version 1.06
%
%   20\jan\2017, jcedeno@espol.edu.ec
%                modificaciones menores para su uso en el curso de ondas
%                marinas de ESPOL.

error(nargchk(2,3,nargin))          % check argument
if frequency <= 0
    error('Frequency must be greather than zero')
end
if iscell(data)
    for i=1:length(data)
        if nargin==2
            [res(i,:),names]=zero_crossing(data{i},frequency);
        else
            [res(i,:),names]=zero_crossing(data{i},frequency,threshold);
        end
    end
    return
end

if size(data,2)==2 & all(data(:,1)>720000) & all(data(:,2)<740000)
    data(:,1)=[];
end 
% the function was written for zero upward-crossing. 
% To have zero downward-crossing (recommended) leave the next line uncommented
data=-data;

names={'H_significant','H_mean','H_10','H_max','T_mean','T_s'}; % initialise output arguments
res=[NaN NaN NaN NaN NaN NaN];

data=detrend(data);                 % find zero crossing avoiding zero values 
d0=data(data~=0);
back0=1:length(data);
back0=back0(data~=0);
f=find(d0(1:end-1).*d0(2:end)<0);
crossing=back0(f);
if data(1)>0                        % reject first crossing if it is downward
    crossing(1)=[];
end
crossing=crossing(1:2:end);         % this are the zero up-ward crossing
wave=zeros(length(crossing)-1,4);   % calculate crest, trough and period of each wave
% wave is a 4 columns matrix with wave height, wave crest, wave trough and wave period
for i=1:length(crossing)-1
    wave(i,2)= max(data(crossing(i):crossing(i+1)));
    wave(i,3)= -min(data(crossing(i):crossing(i+1)));
end
if size(wave,1) >= 1   % if no wave was found, do nothing
    wave(:,4)=diff(crossing')/frequency;
    if nargin<3                         % define threshold for wave
        threshold=0.01*max(wave(:,2)+wave(:,3));
    else
        if threshold < 0
            error ('Wave threshold must not be negative')
        end
    end
    i=0;                                % remove waves that are too small
    while i < size(wave,1)              % by joining then to adjacent wave
        i=i+1;
        if wave(i,2)<threshold
            if i~=1
                wave(i-1,2:4)=[max(wave(i-1:i,2:3)) sum(wave(i-1:i,4))];
            end
            wave(i,:)=[];
        elseif wave(i,3)<threshold
            if i~=size(wave,1)
                wave(i,2:4)=[max(wave(i:i+1,2:3)) sum(wave(i:i+1,4))];
                wave(i+1,:)=[];
            else
                wave(i,:)=[];
            end
        end
    end

    % wave has 1: wave height, 2: wave crest (Hcm), 3: wave trough (Htm), 4: period.
    wave(:,1)= sum(wave(:,2:3)')';      % now we have all waves to be considered, calculation of height
    
end

% 1col. wave height, 2col. wave period
wave=[wave(:,1),wave(:,4)];

