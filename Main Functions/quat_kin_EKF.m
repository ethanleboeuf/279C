function [state_dot] = quat_kin_EKF(t, state, M_act)
% state = [q1 q2 q3 q4 w1 w2 w3 I1 I2 I3]

state_dot = zeros(length(state),1);
wx = state(5);
wy = state(6);
wz = state(7);
%% Kinematic Equations
Omega = [0 wz -wy wx; -wz 0 wx wy; wy -wx 0 wz; -wx -wy -wz 0];
err = 1 - norm(state(1:4));
state_dot(1:4) = 1/2 * Omega * state(1:4); %+ 0.05 * err * state(1:4);

%% Euler Equations
state_dot(5) = -wy*wz * (state(10) - state(9))/state(8) - M_act(1) / state(8);
state_dot(6) = -wx*wz * (state(8) - state(10))/state(9) - M_act(2) / state(8);
state_dot(7) = -wx*wy * (state(9) - state(8))/state(10) - M_act(3) / state(8);

end

