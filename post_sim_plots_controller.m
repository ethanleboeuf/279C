%% Plotting Results from Sim with Controller
close all
n = length(t);
set(0,'DefaultLineMarkerSize',5)
set(0,'DefaultAxesFontSize',22)
set(0,'DefaultTextFontSize',26)
set(0,'DefaultLineLineWidth',3)
q_err(:, 1:4) = quat_corr(q_err(:,1:4));


figure()
subplot(4,1,1)
plot([t; t(end)+dt], [NaN; q_err(:, 1)])
hold on
grid on
title('q_{err1} vs time')
hold off


subplot(4,1,2)
plot([t; t(end)+dt], [NaN; q_err(:, 2)])
hold on
% plot(t(2:end), q_det(1:end-1, 2), 'b:')
grid on
title('q_{err2} vs time')
hold off

subplot(4,1,3)
plot([t; t(end)+dt], [NaN; q_err(:, 3)])
hold on

% plot(t(2:end), q_det(1:end-1, 3), 'b:' )
grid on
title('q_{err3} vs time')
hold off

subplot(4,1,4)
plot([t; t(end)+dt], [NaN; q_err(:, 4)])
hold on

% plot(t(2:end), q_det(1:end-1, 4), 'b:')
grid on
title('q_{err4} vs time')
xlabel('time, seconds')
hold off

figure()
plot(t, M_act(:,1), t, M_act(:,2), t, M_act(:,3))
hold on
legend('x','y','z')
xlabel('time, seconds')
ylabel('M_c, Nm')
title('Control Torques over Time')
hold off


% figure()
% plot(t, q_out(:, 5))
% figure()
% plot(t, q_out(:, 6))
% figure()
% plot(t, q_out(:, 7))

figure()
plot(t, abs(q_out(:, 1)), t, abs(q_out(:, 2)), t, abs(q_out(:, 3)), t, abs(q_out(:, 4)))
hold on
plot(t, abs(q_nom(:, 1)), 'r',t,abs(q_nom(:, 2)), 'r',t, abs(q_nom(:, 3)), 'r',t, abs(q_nom(:, 4)), 'r')
legend('q_{true1}','q_{true2}','q_{true3}','q_{true4}','q_{nom}') 
xlabel('time, seconds')
ylabel('quaternion values')
title('
hold off
% axes_plot(DCM_err, sc)