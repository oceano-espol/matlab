function out=ts_binavg(pres,temp,sal)
% out=ts_binavg(pres,temp,sal)

% x=data(:,1);    % pressure
% y=data(:,2);    % temperature

x=pres;    % pressure
y=temp;    % temperature

xbin = [0:2:floor(max(x))]'; 
xmid = [0.5*(xbin(1:end-1)+xbin(2:end))]';

mxbin=[xbin(1:end-1),xbin(2:end)], pause,

for i=1:length(mxbin)
    ix=find(x>=mxbin(i,1) & x<mxbin(i,2));
    bin(i,:)=nanmean(y(ix));
end

% col 1, pres; col 2, temp
out=[xmid',bin];