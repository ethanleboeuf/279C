function [w] = axi_sym_euler(t, w_1, I)
L_vec = I * w_1;
theta = acosd(dot([0;0;1], L_vec) / norm(L_vec));
I_vec = [I(1,1); I(2,2); I(3,3)];

phi_dot = I_vec(3) * w_1(3) / I_vec(1) / cosd(theta);
psi_dot = phi_dot * cosd(theta) * (I_vec(1) - I_vec(3)) / I_vec(3);
psi = 0;
phi = 0;

w = zeros(length(t), 3);
for ii = 1:length(t)
    psi = psi + psi_dot * t(ii);
    phi = phi + phi_dot * t(ii);
    w(ii, 1) = phi_dot * sind(theta) * sind(psi);
    w(ii, 2) = phi_dot * sind(theta) * cosd(psi);
    w(ii, 3) = phi_dot * cosd(theta) + psi_dot;
end

end

