function out=ts_dateyear(date_num,flag)
% function out=ts_dateyear(date_num,flag)
%
% variable de entrada:
%   datevec, [year,month,day]
%
% variable de salida:
%   out, date as year-fraction (decimal marks this fraction)

lx=length(date_num);
date_vec=datevec(date_num);

% date_num
% date_vec

if exist('flag','var')==1
    date_vec(:,4)=0;
    date_vec(:,5)=0;
    date_vec(:,6)=0;
    date_num=datenum(date_vec);
end

for i=1:lx
    % getting dates as year+decimal (all one-year)
    ty_outres=decdays(date_vec(i,1));
    % searching
    ix=find(ty_outres(:,4)==date_num(i));
    % saving
    out(i,:)=ty_outres(ix,5);    
end

function outres=decdays(year)
% check if year is/not is leap year
% <isleap>
% 
% dcyear
%  1, year
%  2, month
%  3, day
%  4, dnum
%  5, ddcy ***

if isleap(year)==0
    % is not a leap-year
    dnum=[datenum(year,1,1):1:datenum(year,12,31)]';
    dvec=datevec(dnum); dvec=dvec(:,1:3);
    ddcy=[0:1/365:1]'; ddcy=ddcy(1:end-1);
    ddcy=year+ddcy;
else
    % is a leap-year 
    dnum=[datenum(year,1,1):1:datenum(year,12,31)]';
    dvec=datevec(dnum); dvec=dvec(:,1:3);
    ddcy=[0:1/366:1]';  ddcy=ddcy(1:end-1);
    ddcy=year+ddcy;
end

outres=[dvec,dnum,ddcy];