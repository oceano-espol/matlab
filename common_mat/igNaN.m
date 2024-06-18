function x=igNaN(x)
% function x=igNaN(x)
%
% IGNAN Ignore NaNs

t = isnan(x);
somenan = any(any(t));

if somenan
    t = ~any(t,2);
    x = x(t,:);
end

