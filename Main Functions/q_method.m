function [A, q] = q_method(W, V)
%q_method Takes in W and V matrices and outputs attitude
%   W and V are the unnormazized vectors. Make sure that you normalize them
%   before hand using W_i = sqrt(w_i) * u_b^i (page 427 in Wertz)

B = W * V';
S = B' + B;
Z = [B(2,3) - B(3,2); B(3,1) - B(1,3); B(1,2) - B(2,1)];
sig = trace(B);

K = [S - ones(3,1) * sig Z; Z' sig];

[vec, D] = eig(K);

[max_num,max_idx] = max(D(:));
[X Y]=ind2sub(size(D),max_idx);

q = vec(:, X);
A = quat_to_DCM(q);
end

