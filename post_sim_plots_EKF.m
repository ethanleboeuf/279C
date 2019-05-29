%% Plotting Results from Sim with EKF
close all
n = length(t);
set(0,'DefaultLineMarkerSize',5)

mu_EKF(:, 1:4) = quat_corr(mu_EKF(:,1:4));
mu_p(:, 1:4) = quat_corr(mu_p(:, 1:4));
q_det = quat_corr(q_det);
[q] = quat_corr(q_out(:, 1:4));
for ii = 1:size(mu_EKF, 1)
    z(:,:,ii) = error_ellipse(0, sigma_EKF(4,4,ii), .95);
    z_high(ii) = max(z(2, :, ii)) + mu_EKF(ii, 4);
    z_min(ii) = min(z(2, :, ii))+ mu_EKF(ii, 4);
end

figure()
subplot(4,1,1)
plot([t; t(end)+dt], [NaN; mu_EKF(:, 1)])
hold on
plot(t, q(:, 1),'--')
% plot(t(2:end), q_det(1:end-1, 1), 'b:')
grid on
legend('Estimate', 'Ground Truth', 'location','ne')
title('q_1 vs time')
xlabel('time, seconds')
ylabel('quaternion')
hold off


subplot(4,1,2)
plot([t; t(end)+dt], [NaN; mu_EKF(:, 2)])
hold on
plot(t, q(:, 2),'--')
% plot(t(2:end), q_det(1:end-1, 2), 'b:')
grid on
title('q_2 vs time')
xlabel('time, seconds')
ylabel('quaternion')
hold off

subplot(4,1,3)
plot([t; t(end)+dt], [NaN; mu_EKF(:, 3)])
hold on
plot(t, q(:, 3),'--')
% plot(t(2:end), q_det(1:end-1, 3), 'b:' )
grid on
title('q_3 vs time')
xlabel('time, seconds')
ylabel('quaternion')
hold off

subplot(4,1,4)
plot([t; t(end)+dt], [NaN; mu_EKF(:, 4)])
hold on
plot(t, q(:, 4),'--')
% plot(t(2:end), q_det(1:end-1, 4), 'b:')
grid on
title('q_4 vs time')
xlabel('time, seconds')
ylabel('quaternion')
hold off



figure()
scatter([t; t(end)+dt], [NaN; mu_p(:, 4)], 'filled')
hold on
scatter([t; t(end)+dt], [NaN; mu_EKF(:, 4)], 'filled')
plot(t, q(:, 4), 'k')
% plot(t, q_det(:, 4), 'b')
plot(t(2:end), z_high(1:end-1), 'b', 'HandleVisibility', 'off')
plot(t(2:end), z_min(1:end-1), 'b')
% for ii = 1:size(z, 3)-1
%     plot(z(1, :, ii) + t(ii+1), z(2, :, ii) + mu_EKF(ii,4))
% end
grid on
xlabel('time, seconds')
ylabel('q_4')
legend('Pre-fit', 'Post-fit', 'Ground Truth', '95% Confidence Bound')
hold off

figure()
plot(t(2:end), abs(mu_p(1:end-1, 4) - q(2:end, 4)))
hold on
plot(t(2:end), abs(q_det(1:end-1, 4) - q(2:end, 4)))
xlabel('time, seconds')
ylabel('Absolute Error')
if att_det_method == 1
    legend('EKF', 'q - method')
else
    legend('EKF', 'Deterministic Method')
end
hold off

figure()
plot(t(2:end), abs(mu_p(1:end-1, 4) - q(2:end, 4)) -abs(q_det(1:end-1, 4) - q(2:end, 4)) )
hold on
xlabel('time, seconds')
ylabel('Absolute Error')
hold off

figure()
plot(t, q_out(:, 5))
hold on
plot(t, mu_p(:, 5))
hold off

