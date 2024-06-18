function r=ts_xcorr(data_1,data_2)
% function r=ts_xcorr(data_1,data_2),
%
% PRUEBA !!!

% Created on 23/aug/2013, jcedeno@udec.cl 
% Edited: 

% siz_d1=size(data_1); siz_d2=size(data_2);
% if siz_d1(1)*siz_d1(2)~=siz_d2(1)*siz_d2(2),
%     error('Las dimensiones no coinciden. Revisar SVP.')
% end

if length(data_1)~=length(data_2),
    error('Las dimensiones no coinciden. Revisar SVP.')
end

n=length(data_1(:,1));

d1_mean=jt_mean(data_1);    d2_mean=jt_mean(data_2);
d1_sd=jt_sd(data_1);        d2_sd=jt_sd(data_2);

%  d1_mean=mean(data_1);    d2_mean=mean(data_2);
%  d1_sd=std(data_1);        d2_sd=std(data_2);


cov_d1d2=(1/(n-1))*sum((data_1-d1_mean).*(data_2-d2_mean));

r=cov_d1d2/(d1_sd*d2_sd);

% answ554=(1/(lengthy))*sum(tempy);

% for i=1:lengthy
%     tempy(i,:)=(data_1(i)-d1_mean)*(data_2(i)-d2_mean);
% end
% 
% answ554=(((1/(lengthy-1))*sum(tempy)))/(d1_sd*d2_sd);
