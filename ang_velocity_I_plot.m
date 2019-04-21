function ang_velocity_I_plot(w, A)

n = size(A,3);
w_I = zeros(3, n);
for ii = 1:n
    w_I(:,ii) = A(:,:,ii)' * w(:, ii);
end

fig = figure('units','normalized','outerposition',[0 0 1 1]);
scatter3(w_I(1,:), w_I(2,:), w_I(3,:), 'Filled')
hold on
% [fig] = plane2vec(L_vec_I(:,1), fig, w_I(:,1));% ONLY USE FOR FIGURES
% NEEDED FOR PAPER TAKES FOREVER TO RUN
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Angular Velocity Vector over Time')
% legend('Angular Velocity', 'Angular Momentum Plane')
hold off

end

