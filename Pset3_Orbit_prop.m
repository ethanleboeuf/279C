clear
close all
clc

%% AA279C Orbit Propagator

%% Initial Conditions/Constants
constants % access constants (mu, distance to earth, etc.)
mu1 = 328900.56^-1; % From NASA
r0 = [.98900883730044109; 0; 0.000802140914099732]; % initial position
% v0 = [0; 0.010697471710460349-3.24199547e-3; 0]; % initial velocity
v0 = [0; 0.010697471710460349-3.24371e-3; 0]; % initial velocity
% Set time
omega = (sqrt((mu.earth + mu.moon + mu.sun)/dis.sun^3));
tstart = 0;
tint = omega;
tint_sim = round(tint); % integer for simulink
tend = 3600*24*365*omega; % convert to nondimensional time
tend_sim = round(tend); % integer for simulink

%% solving L1 point
syms x
eqn = x - (1-mu1)/(x+mu1)^2 + mu1/(x-1+mu1)^2 == 0;
digitsOld = digits(100);
L1 = vpasolve(eqn,x,[0,1]);
highPrecisionL1 = double(L1);
digits(digitsOld)
sim('Orbit_prop_279C.slx')

%% Plotting
figure('units','normalized','outerposition',[0 0 1 1])
plot(y_out(:,1)*dis.sun, y_out(:,2)*dis.sun,'k','LineWidth',3)
hold on
% plot(y_out(:,7), y_out(:,8))
scatter(highPrecisionL1*dis.sun,0,100,'filled','r')
% scatter(mu1*dis.sun,0,25,'filled')
scatter((1-mu1)*dis.sun,0,100,'filled','b')
title('Halo Orbit around L1 Point in the Rotating Barycenter Frame')
xlabel('x position, km')
ylabel('y position, km')
% axis equal
grid on
legend('Halo Orbit', 'L1 Point', 'Earth')
hold off
(y_out(1,1) - y_out(end,1))*dis.sun %check on final error in the distance

% figure()
% subplot(3,1,1)
% plot3(y_out(:,1)*dis.sun,y_out(:,2)*dis.sun,y_out(:,3)*dis.sun,'k','LineWidth',3)
% view([0 -90 0])
% hold on
% scatter3(highPrecisionL1*dis.sun,0,0,100,'filled','r')
% xlabel('x, km')
% zlabel('z, km')
% grid on
% hold off
% 
% subplot(3,1,2)
% plot3(y_out(:,1)*dis.sun,y_out(:,2)*dis.sun,y_out(:,3)*dis.sun,'k','LineWidth',3)
% hold on
% scatter3(highPrecisionL1*dis.sun,0,0,100,'filled','r')
% view([90 0 0])
% ylabel('y, km')
% zlabel('z, km')
% grid on
% hold off
% 
% subplot(3,1,3)
% plot3(y_out(:,1)*dis.sun,y_out(:,2)*dis.sun,y_out(:,3)*dis.sun,'k','LineWidth',3)
% view([0 0 90])
% hold on
% scatter3(highPrecisionL1*dis.sun,0,0,100,'filled','r')
% xlabel('x, km')
% ylabel('y, km')
% grid on
% hold off
% 
% sgtitle(['Different views of the Halo Orbit around the {\color{red}L1} point'])
