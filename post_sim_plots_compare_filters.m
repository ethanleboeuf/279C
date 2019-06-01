%% Plotting Results from Sim with UKF
close all
n = length(t);
n_filt = size(mu_EKF, 1);
set(0,'DefaultLineMarkerSize',5)


mu_EKF(:, 1:4) = quat_corr(mu_EKF(:,1:4));
mu_p_EKF(:, 1:4) = quat_corr(mu_p_EKF(:, 1:4));
mu_UKF(:, 1:4) = quat_corr(mu_UKF(:,1:4));
mu_p_UKF(:, 1:4) = quat_corr(mu_p_UKF(:, 1:4));

[q_UKF] = quat_corr(q_out_UKF(:, 1:4));
q_UKF = [q_UKF q_out_UKF(:, 5:7)];

[q_EKF] = quat_corr(q_out_EKF(:, 1:4));
q_EKF = [q_EKF q_out_EKF(:, 5:7)];

figure()
err_EKF = zeros(n_filt, 1);
err_UKF = zeros(n_filt, 1);
for ii = 1:n_filt
    err_EKF(ii) = norm(mu_EKF(ii, :) - q_EKF(1+(ii-1)*dt_EKF/dt, :));
    err_UKF(ii) = norm(mu_UKF(ii, :) - q_UKF(1+(ii-1)*dt_EKF/dt, :));
end
plot(t(1:dt_EKF/dt:end), err_EKF)
hold on
plot(t(1:dt_EKF/dt:end), err_UKF)
xlabel('time, seconds')
ylabel('Absolute Error')
legend('EKF', 'UKF')
hold off

figure()
plot(t(1:dt_EKF/dt:end), err_EKF - err_UKF)
hold on
xlabel('time, seconds')
ylabel('Absolute Error')
hold off
mean(err_EKF(2:end) - err_UKF(2:end))
