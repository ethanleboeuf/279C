function [At] = dynamics_matrix_MEKF(w)



wx = w(1);
wy = w(2);
wz = w(3);

w_cross = [0, wz, -wy;-wz, 0, wx;wy, -wx, 0];

At = [w_cross, -1*eye(3)];

end

