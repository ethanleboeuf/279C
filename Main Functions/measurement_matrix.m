function [Ct] = measurement_matrix(q, V, gyro_flag)

C_block = zeros(3, 7, size(V, 2));
Ct = zeros((size(V, 2) + gyro_flag)* 3, 7); % plus 1 because of omega
for ii = 1:size(V, 2)
    C_block(:, :, ii) = C_block_vect(q, V(:, ii));
    Ct(1 + 3*(ii-1) : 3 + 3*(ii-1), :) = C_block(:, :, ii);
end

if gyro_flag
    Ct(1 + 3*size(V, 2) : 3 + 3*size(V, 2), :) = [zeros(3, 4) eye(3)];
end
end
