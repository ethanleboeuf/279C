clear all
close all
set(0,'DefaultLineLineWidth',1.5)
set(0,'DefaultLineMarkerSize',15)
set(0,'DefaultAxesFontSize',22)
set(0,'DefaultTextFontSize',26)
%% Problem Set 1 Problem 9
constants
%% Initial Conditions
mu1 = 328900.56^-1; % From NASA
omega = sqrt((mu.earth + mu.moon + mu.sun)/dis.sun^3);

%% solving L1
syms x
eqn = x - (1-mu1)/(x+mu1)^2 + mu1/(x-1+mu1)^2 == 0;
digitsOld = digits(100);
L1 = vpasolve(eqn,x,[0,1]);

highPrecisionL1 = double(L1) ;
digits(digitsOld)

%% Initial r and v
r = [.98900883730044109; 0; 0.000802140914099732];
v = [0; 0.010697471710460349-3.24199547e-3; 0]; % be careful changing. Very sensitive.
state_sc_earth = [r; v; mu1];
%% solving the orbit


tstart = 0;
tint = 25*omega;
% tend = 3600*24*176.9228*omega; % convert to nondimensional time
tend = 3600*24*365*omega; % convert to nondimensional time

options = odeset('RelTol', 1e-3, 'AbsTol', 1e-6); 
[t_out, y_out] = ode113(@orbit_prop, [tstart:tint:tend]', state_sc_earth, options); 

%% Plotting
figure()
plot(y_out(:,1)*dis.sun, y_out(:,2)*dis.sun,'k','LineWidth',3)
hold on
% plot(y_out(:,7), y_out(:,8))
scatter(double(L1)*dis.sun,0,100,'filled','r')
% scatter(mu1*dis.sun,0,25,'filled')
scatter((1-mu1)*dis.sun,0,100,'filled','b')
title('Halo Orbit around L1 Point in the Rotating Barycenter Frame')
xlabel('x position, km')
ylabel('y position, km')
% axis equal
grid on
legend('Halo Orbit', 'L1 Point', 'Earth')
hold off
(y_out(1,1) - y_out(end,1))*dis.sun; %check on final error in the distance



figure()
subplot(3,1,1)
plot3(y_out(:,1)*dis.sun,y_out(:,2)*dis.sun,y_out(:,3)*dis.sun,'k','LineWidth',3)
view([0 -90 0])
hold on
scatter3(double(L1)*dis.sun,0,0,100,'filled','r')
xlabel('x, km')
zlabel('z, km')
grid on
hold off

subplot(3,1,2)
plot3(y_out(:,1)*dis.sun,y_out(:,2)*dis.sun,y_out(:,3)*dis.sun,'k','LineWidth',3)
hold on
scatter3(double(L1)*dis.sun,0,0,100,'filled','r')
view([90 0 0])
ylabel('y, km')
zlabel('z, km')
grid on
hold off

subplot(3,1,3)
plot3(y_out(:,1)*dis.sun,y_out(:,2)*dis.sun,y_out(:,3)*dis.sun,'k','LineWidth',3)
view([0 0 90])
hold on
scatter3(double(L1)*dis.sun,0,0,100,'filled','r')
xlabel('x, km')
ylabel('y, km')
grid on
hold off

sgtitle(['Different views of the Halo Orbit around the {\color{red}L1} point'])
% 
% hold on
% scatter3(double(L1)*dis.sun,0,0,100,'filled','r')
% title('Halo Orbit')
% xlabel('x position, km')
% ylabel('y position, km')
% zlabel('z position, km')
% axis equal
% grid on
% hold off
