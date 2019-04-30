function [statedot] = orbit_prop_dim(t, state)
% state is [r_3 v_3 mu]
%   although required by form, t will be unused

dis_sun = 149599650;

statedot = zeros(length(state),1);
x = state(1);
y = state(2);
z = state(3);
xdot = state(4);
ydot = state(5);
zdot = state(6);

w = state(7);
mu1 = state(8);
mu2 = state(9);
mu_sys = state(10);

Rx1 = - mu_sys*dis_sun;
Rx2 = (1-mu_sys)*dis_sun;

R1 = sqrt((x - Rx1)^2 + y^2 + z^2);
R2 = sqrt((x - Rx2)^2 + y^2 + z^2);

statedot(1) = xdot;
statedot(2) = ydot;
statedot(3) = zdot;

statedot(4) = x*w^2 + 2*ydot*w + mu1 * (Rx1 - x)/R1^3 + mu2 * (Rx2 - x)/R2^3;
statedot(5) = y*w^2 - 2*xdot*w - mu1 * (y)/R1^3 - mu2 * (y)/R2^3; 
statedot(6) = - mu1 * (z)/R1^3 - mu2 * (z)/R2^3;
for ii = 4:6
    if abs(statedot(ii)) < 1e-15
        statedot(ii) = 0;
    end
end
end

