function r=rinv(p,n)
%
% 	r_0=rinv(p,n) computes the value of r_0 giving P(|r| <= r_0)=p
%			where r is the sample correlation coeff,
% 			r=(1/n)*(x'*y)/(std(x)*std(y)) for col vectors x,y of length n
% n = no. samples used
% p = probability in expression above
%
% USAGE: to get a r_0 so that P(|r| > r_0)= .01 use r_0=rinv(1-.01,n)
%
% NOTES: following Cramer, p.401, find t_p giving P(|t| >= t_p) = p
%			so 1-p/2 in each tail, and P(|t| < t_p)=1-p
%			the x-formed t has n-2 d.f.
if n < 3
   disp('n is too small');
   r=1;
   return;
end
if p==1
   r=1;	% all the values must be <= 1
else
   q=1-p; % q is the total tail
   t_q = tinv(1-q/2,n-2);			% P(t <= t_p) = 1-p/2 ; 1-p/2 in lower tail
	t_q = abs(t_q);					%  
	r = t_q/(sqrt(t_q*t_q +n -2)); 
end