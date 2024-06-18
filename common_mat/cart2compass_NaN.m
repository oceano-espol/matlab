function [theta,rho] = cart2compass_NaN(u,v)
%CART2COMPASS convert cartesian coordinates into
% speed and direction data (degN).
%    [THETA,RHO] = CART2COMPASS convert the vectors u and v
%      from a cartesian reference system into rho (e.g. speed) with
%      direction theta (degree North).
%
%   See also CART2POL
%

% Author: Arnaud Laurent
% Creation : March 20th 2009
% MATLAB version: R2007b
%

% for i=1:length(u(:,1)),
%     if isnan(u(i))==0 | isnan(v(i))==0,
%         [theta,rho] = cart2pol(u,v);
%     else
%         theta(i,:)=NaN; rho(i,:)=NaN;
%     end
% end

[theta,rho] = cart2pol(u,v);

theta = theta*180/pi;

idx = find(theta<0);
theta(idx) = 360 + theta(idx);

idx = find(theta>=0&theta<90);
theta_comp(idx,1) = abs(theta(idx) - 90);

idx = find(theta>=90&theta<=360);
theta_comp(idx,1) = abs(450 - theta(idx));

isNan = isnan(theta);
idx = find(isNan == 1);
theta_comp(idx,1) = NaN;

theta = theta_comp;
