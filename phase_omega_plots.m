function [fig] = phase_omega_plots(omegas,t)
fig = figure();

alpha_1 = diff(omegas(:,1))./diff(t);
alpha_2 = diff(omegas(:,2))./diff(t);
alpha_3 = diff(omegas(:,3))./diff(t);
for ii = 1:length(omegas(:,1)) - 1
    ave_1(ii) = mean([omegas(ii+1, 1), omegas(ii, 1)]);
    ave_2(ii) = mean([omegas(ii+1, 2), omegas(ii, 2)]);
    ave_3(ii) = mean([omegas(ii+1, 3), omegas(ii, 3)]);
end
subplot(3,1,1)
plot(ave_1, alpha_1)
hold on
xlabel('\omega_x')
ylabel('\alpha_x')
axis equal
hold off
subplot(3,1,2)
plot(ave_2, alpha_2)
hold on
xlabel('\omega_y')
ylabel('\alpha_y')
axis equal
hold off

subplot(3,1,3)
plot(ave_3, alpha_3)
hold on
xlabel('\omega_z')
ylabel('\alpha_z')
axis equal
hold off

sgtitle(['\alpha vs \omega Phase Plots'])
end
