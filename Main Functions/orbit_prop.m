function [statedot] = orbit_prop(t, state)
% state is [r_3 v_3 mu]
%   although required by form, t will be unused


statedot = zeros(7,1);
x = state(1);
y = state(2);
z = state(3);
xdot = state(4);
ydot = state(5);
zdot = state(6);

mu = state(7);

rho1 = sqrt((x + mu)^2 + y^2 + z^2);
rho2 = sqrt((x - (1-mu))^2 + y^2 + z^2);

statedot(1) = xdot;
statedot(2) = ydot;
statedot(3) = zdot;

statedot(4) = x + 2*ydot - (1 - mu)*(x + mu)/rho1^3 - ...
    mu*(x - (1 - mu))/rho2^3;
statedot(5) = y - 2*xdot - (1 - mu)*(y)/rho1^3 - ...
    mu*(y)/rho2^3;
statedot(6) = -(1 - mu)*z/rho1^3 - mu*z/rho2^3;
for ii = 4:6
    if abs(statedot(ii)) < 1e-15
        statedot(ii) = 0;
    end
end
end

