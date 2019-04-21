function [state_dot] = DCM_kin_wheel(t, state)
% state = [C(:) w1 w2 w3 I1 I2 I3 wr Ir rx ry rz]

state_dot = zeros(length(state),1);
wx = state(10);
wy = state(11);
wz = state(12);
Ix = state(13);
Iy = state(14);
Iz = state(15);
wr = state(16);
Ir = state(17);
rx = state(18);
ry = state(19);
rz = state(20);

%% Kinematic Equations
Omega = [0 -wz wy; wz 0 -wx; -wy wx 0];
A = [state(1) state(4) state(7); state(2) state(5) state(8); state(3)...
    state(6) state(9)];
state_dot(1:9) = -Omega * A;

%% Euler Equations
state_dot(10) = (-wy*wz * (Iz - Iy) - Ir * wr * (wy*rz - wz*ry))/Ix;
state_dot(11) = (-wx*wz * (Ix - Iz) - Ir * wr * (wz*rx - wx*wz))/Iy;
state_dot(12) = (-wx*wy * (Iy - Ix) - Ir * wr * (wx*ry - wy*rx))/Iz;

end

