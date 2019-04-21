function ang_momentum_I_plot(w, sc, A)
n = size(A,3);
L_vec_b = zeros(3, n);
L_vec_I = zeros(3, n);
w_I = zeros(3, n);
for ii = 1:n
    L_vec_b(:, ii) = sc.Ip * w(:, ii);
    L_vec_I(:, ii) = A(:,:,ii)' * L_vec_b(:, ii);
    w_I(:,ii) = A(:,:,ii)' * w(:, ii);
end

L = norm(L_vec_I(:,1));
figure('units','normalized','outerposition',[0 0 1 1])
scatter3((L_vec_I(1,:)- L_vec_I(1,1)), (L_vec_I(2,:)- L_vec_I(2,1)),...
    (L_vec_I(3,:)- L_vec_I(3,1)))
hold on
xlabel('\Delta_x')
ylabel('\Delta_y')
zlabel('\Delta_z')
title('Differnce in Angular Momentum Vector over Time Compared to Initial')
hold off

end

