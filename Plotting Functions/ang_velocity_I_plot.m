function ang_velocity_I_plot(w, A, sc)

n = size(A,3);
L_vec_b = zeros(3, n);
L_vec_I = zeros(3, n);
w_I = zeros(3, n);
for ii = 1:n
    L_vec_b(:, ii) = sc.Ip * w(:, ii);
    L_vec_I(:, ii) = A(:,:,ii)' * L_vec_b(:, ii);
    w_I(:,ii) = A(:,:,ii)' * w(:, ii);
end

fig = figure('units','normalized','outerposition',[0 0 1 1]);
% scatter3(w_I(1,:), w_I(2,:), w_I(3,:),'filled')
scatter3(w_I(1,:), w_I(2,:), w_I(3,:),'.')
hold on
% [fig] = plane2vec(L_vec_I(:,1), fig, w_I(:,1));% ONLY USE FOR FIGURES
% NEEDED FOR PAPER TAKES FOREVER TO RUN
xlabel('I, rad/s')
ylabel('J, rad/s')
zlabel('K, rad/s')
title('Angular Velocity Vector over Time')
% legend('Angular Velocity', 'Angular Momentum Plane')
% xlim([min(w_I(1,:)),max(w_I(1,:))])
hold off

end

