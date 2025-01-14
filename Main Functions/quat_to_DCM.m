function [DCM] = quat_to_DCM(q)
n = size(q, 2);
DCM = zeros(3, 3, n);
for ii = 1:n
    DCM(:, :, ii) = ((q(4, ii)^2 - norm(q(1:3, ii))^2)*eye(3) ...
        + 2 * q(1:3, ii) * q(1:3, ii)'...
        - 2 * q(4, ii) * ...
        [0, -q(3, ii), q(2, ii); q(3, ii), 0, -q(1, ii); ...
        -q(2, ii), q(1, ii), 0]);
end
end

