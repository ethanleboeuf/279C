%% Plotting Results from Sim
close all
n = length(t);
% R = zeros(3, n);
% T = zeros(3, n);
% N = zeros(3, n);
% 
% R(:, :) = RTN_out(:, 1, :);
% T(:, :) = RTN_out(:, 2, :);
% N(:, :) = RTN_out(:, 3, :);
% specific_triad_plot(R, T , N, 'RTN')
% 
[A] = out2mat(dcm_out(:, 1:9));
w_out = dcm_out(:, 10:12)';
ang_momentum_I_plot(w_out, sc, A)
ang_velocity_I_plot(w_out, A, sc)
axes_plot(A, sc)
% 
% figure(2)
% unit_sun = zeros(3, n);
% for ii = 1 : n
%     unit_sun(1:3, ii) = Inert_pos_out(ii, 4:6)/norm(Inert_pos_out(ii, 4:6));
% end
% hold on
% scatter(unit_sun(1, :), unit_sun(2, :), 'k', 'filled')
% hold off
% figure()
% scatter3(Inert_pos_out(1:10:end,1), Inert_pos_out(1:10:end,2), Inert_pos_out(1:10:end,3), '.', 'b')
% hold on 
% scatter3(Inert_pos_out(1:10:end,4), Inert_pos_out(1:10:end,5), Inert_pos_out(1:10:end,6), '.', 'r')
% scatter3(Inert_pos_out(1:10:end,7), Inert_pos_out(1:10:end,8), Inert_pos_out(1:10:end,9), '.', 'g')
% xlabel('I')
% ylabel('J')
% zlabel('K')
% hold off

figure()
magM = zeros(n, 1);
for ii = 1:n
    magM(ii) = norm(M(ii, :));
end
plot(t/3600/24, magM)
hold on
grid on
xlabel('Time, days')
ylabel('Gravity Gradient Torque, Nm')
title('Gravity Gradient Torque over one Orbit around L1')
hold off

figure()
subplot(3,1,1)
plot(t/3600/24, M(:, 1), 'k', 'LineWidth', 3)
hold on
xlabel('time, days')
ylabel('M_x, Nm')
grid on
hold off

subplot(3,1,2)
plot(t/3600/24, M(:, 2), 'k', 'LineWidth', 3)
hold on
xlabel('time, days')
ylabel('M_y, Nm')
grid on
hold off

subplot(3,1,3)
plot(t/3600/24, M(:, 3), 'k', 'LineWidth', 3)
hold on
xlabel('time, days')
ylabel('M_z, Nm')
grid on
hold off