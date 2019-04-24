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
scatter3((L_vec_I(1,:)- L_vec_I(1,1))/L_vec_I(1,1)*100,...
    (L_vec_I(2,:)- L_vec_I(2,1))/L_vec_I(1,1)*100,...
    (L_vec_I(3,:)- L_vec_I(3,1))/L_vec_I(1,1)*100)
hold on
xlabel('\Delta_I, % Error')
ylabel('\Delta_J, % Error')
zlabel('\Delta_K, % Error')
title('Percent Error of Angular Momentum Vector from Initial Condition')
hold off

end

