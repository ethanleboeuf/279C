function omega_time_plots(t_out, w)

figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,1,1)
scatter(t_out, w(1, :))
xlabel('t, s')
ylabel('\omega_x, rad/s')
grid on
hold off

subplot(3,1,2)
scatter(t_out, w(2, :))
xlabel('t, s')
ylabel('\omega_y, rad/s')
grid on
grid on
hold off

subplot(3,1,3)
scatter(t_out, w(3, :))
xlabel('t, s')
ylabel('\omega_z, rad/s')
grid on
grid on
hold off

sgtitle(['Components of $$\vec{\omega}$$ vs. Time'], ...
    'FontSize', 26, 'Interpreter', 'latex')

end

