%% Plotting Results from Sim with Controller
close all
n = length(t);
set(0,'DefaultLineMarkerSize',5)

q_err(:, 1:4) = quat_corr(q_err(:,1:4));


figure()
subplot(4,1,1)
plot([t; t(end)+dt], [NaN; q_err(:, 1)])
hold on
grid on
title('q_1 vs time')
xlabel('time, seconds')
ylabel('quaternion')
hold off


subplot(4,1,2)
plot([t; t(end)+dt], [NaN; q_err(:, 2)])
hold on
% plot(t(2:end), q_det(1:end-1, 2), 'b:')
grid on
title('q_2 vs time')
xlabel('time, seconds')
ylabel('quaternion')
hold off

subplot(4,1,3)
plot([t; t(end)+dt], [NaN; q_err(:, 3)])
hold on

% plot(t(2:end), q_det(1:end-1, 3), 'b:' )
grid on
title('q_3 vs time')
xlabel('time, seconds')
ylabel('quaternion')
hold off

subplot(4,1,4)
plot([t; t(end)+dt], [NaN; q_err(:, 4)])
hold on

% plot(t(2:end), q_det(1:end-1, 4), 'b:')
grid on
title('q_4 vs time')
xlabel('time, seconds')
ylabel('quaternion')
hold off

figure()
plot(t, M_act(:,1), t, M_act(:,2), t, M_act(:,3))
hold on
legend('x','y','z')
hold off
figure()
plot(t, q_out(:, 5))
figure()
plot(t, q_out(:, 6))
figure()
plot(t, q_out(:, 7))

% axes_plot(DCM_err, sc)
