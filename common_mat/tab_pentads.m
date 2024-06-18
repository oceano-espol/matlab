function tab=tab_pentads(time,data)
% function tab=tab_pentads(time,data)
%
% TAB_PENTADS

% jcedeno@udec.cl

% Trabajada a partir de las salidas de <pentads>, que ajusta 73 pentadas
% por anno.

jdvec=datevec(time);
jdvec=jdvec(:,1:3);

yrini=jdvec(1,1);   yrfin=jdvec(end,1);
yr=[yrini:1:yrfin]';

% eje de meses
ix=find(jdvec(:,1)==1996);
mo_m1=[time(ix),jdvec(ix,:)];
% ---
ix=find(jdvec(:,1)==1997);
mo_zr=[time(ix),jdvec(ix,:)];
% ---
ix=find(jdvec(:,1)==1998);
mo_p1=[time(ix),jdvec(ix,:)];

for i=1:length(yr),
    ix=find(jdvec(:,1)==yr(i));
    if length(ix)==73,
        block_ct(i,:)=data(ix,:)';
    else
        block_ct(i,:)=ones(1,73).*NaN;
    end
end

% ensamble de bloques
% block_lf = [50:end]
% block_rg = [ 1:49]

block_lf=[ones(1,73).*NaN;block_ct(1:end-1,:)];
block_rg=[block_ct(2:end,:);ones(1,73).*NaN;];

dt=[block_lf(:,50:end),block_ct,block_rg(:,1:49)];
mo=[mo_m1(50:end,:);mo_zr;mo_p1(1:49,:)];

tab.mo=mo;
tab.yr=yr;
tab.dt=dt;

