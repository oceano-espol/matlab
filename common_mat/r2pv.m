function p=r2pv(r,n)
%
% 	p=r2pv(r,n)
%
% r = estimated correlation coefficient (IE |r| <= 1)
%   = (1/n)*(x'*y) for col vectors x,y of length n
% n = no. samples used
% p = P-value based on |r| (two sided) with rho=0 (null case)
%
% NOTES: following Cramer, p.400, convert r to a t and use what we have for t 
if n < 3
    error('n < 3');
end
if r==1. 
    p=0; 
    return;
end
t=sqrt(n-2)*r/(sqrt(1-r*r)); 	% this is t with n-2 d.f.
t=abs(t);						% use |t| for two sided P-value
p=2*(1-tcdf(t,n-2));