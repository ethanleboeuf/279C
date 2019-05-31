function q_err = quat_error(q_est0, q_nom0)

[q_est1] = quat_corr(q_est0);
[q_nom1] = quat_corr(q_nom0);

q_err = zeros(size(q_est1,1), 4);
for ii = 1:size(q_est1, 1)
    q_nom = q_nom1(ii, :);
    q_est = q_est1(ii, :);
    q_mat = [q_nom(4) q_nom(3) -q_nom(2) q_nom(1);...
            -q_nom(3) q_nom(4) q_nom(1) q_nom(2);...
            q_nom(2) -q_nom(1) q_nom(4) q_nom(3);...
            -q_nom(1) -q_nom(2) -q_nom(3) q_nom(4)];

    q_err(ii, :) = q_mat * [-q_est(1) -q_est(2) -q_est(3) q_est(4)]';
    q_err(ii, :) = quat_corr(q_err(ii,:));
end
end
