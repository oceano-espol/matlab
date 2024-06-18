function Pol=ts_SpectOverlap(data)
% function Pol=ts_SpectOverlap(data)
%
% TS_SPECTOVERLAP Espectro en el tiempo (overlapped)

% [1] definiendo indices
%     ...

% whos sleq_is18
%   Name              Size                Bytes  Class     Attributes
% 
%   sleq_is18      6767x480            25985280  double

j=1;
for i=1:6256,
    ix(i,:)=[j,j+511];
    j=j+1;
end

%%
% spectrum

h=waitbar(0,'Please wait...');
for i=1:length(ix),
    if i==1,
        ty=orpa_cohe(data(ix(i,1):ix(i,2),1),512,0);
        Pol.f=ty(:,1);
        Pol.x(:,i)=ty(:,2);
    else
        ty=orpa_cohe(data(ix(i,1):ix(i,2),1),512,0);
        Pol.x(:,i)=ty(:,2);
    end
    waitbar(i/length(ix),h),
end
close(h);

