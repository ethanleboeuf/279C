
close all
clear
clc

%% Euler Equations - Problem 2
Ix = 3517.982;
Iy = 5585.487;
Iz = 7248.903;
% all in deg/s
wx_i = 5;
wy_i = 5;
wz_i = 5;
w_I = [wx_i*(pi/180) wy_i*(pi/180) wz_i*(pi/180) Ix Iy Iz];
tstart = 0;
tint = 1;
tend = (2*360)/(wx_i);
tspan = [tstart:tint:tend];
options = odeset('RelTol',1e-3,'AbsTol',1e-6);
[t,w_next] = ode113(@euler_int, tspan, w_I, options);
wx = w_next(:,1);
wy = w_next(:,2);
wz = w_next(:,3);
I = [Ix,0,0;0,Iy,0;0,0,Iz];
w = [wx,wy,wz];
%% Rotational Kinetic Energy & Momentum Ellipsoid - Problem 3
L_vec = (I*w')'; % Momentum vector
L = norm(L_vec(1,:)); % Momentum magnitude
L2 = (L)^2; % Squared Angular Momentum
T = dot(w(1,:),L_vec(1,:)); % Rot Kinetic Energy
% Energy Ellipsoid
a_T = T./Ix;
b_T = T./Iy;
c_T = T./Iz;
[X_T,Y_T,Z_T] = ellipsoid(0,0,0,a_T,b_T,c_T);
% Momentum Ellipsoid
a_L = L2./(Ix^2);
b_L = L2./(Iy^2);
c_L = L2./(Iz^2);
[X_L,Y_L,Z_L] = ellipsoid(0,0,0,a_L,b_L,c_L);
% Plot Ellipsoid
figure
surf(X_T,Y_T,Z_T,'EdgeColor','none','FaceAlpha',0.5,'FaceColor','red');
hold on
surf(X_L,Y_L,Z_L,'EdgeColor','none','FaceAlpha',0.5,'FaceColor','blue');
xlabel('x')
ylabel('y')
zlabel('z')
title('Energy and Momentum Ellipsoid')
axis equal

%% 3D Polhode - Problem 4
% solve for polhode
syms x y z
eqn = (Ix - L2/T)*Ix*x^2 + (Iy - L2/T)*Iy*y^2 + (Iz - L2/T)*Iz*z^2 == 0;
polhode = solve(eqn,z);
f(x,y) = polhode(1);
g(x,y) = polhode(2);
% fix axes to match ellipsoids
X_lo1 = min(X_T(:)); % x-min
X_lo2 = min(X_L(:));
X_lo = min([X_lo1, X_lo2]);
X_hi1 = max(X_T(:)); % x-max
X_hi2 = max(X_L(:));
X_hi = max([X_hi1, X_hi2]);
Y_lo1 = min(Y_T(:)); % y-min
Y_lo2 = min(Y_L(:));
Y_lo = min([Y_lo1, Y_lo2]);
Y_hi1 = max(Y_T(:)); % y-max
Y_hi2 = max(Y_L(:));
Y_hi = max([Y_hi1, Y_hi2]);
coordmax = max([Y_hi,X_hi]);
coordmin = min([Y_lo,X_lo]);
% plot polhode
fsurf(f,[coordmin, coordmax], 'FaceColor' ,'none', 'HandleVisibility','off')
hold on
fsurf(g,[coordmin, coordmax], 'FaceColor' , 'none', 'HandleVisibility','off')
legend('Rotational Kinetic Energy', 'Angular Momentum','Location','Best');
hold off


%% 2D Polhode - Problem 5
% pol_x = solve(eqn,x);
% pol_y = solve(eqn,y);
% pol_z = solve(eqn,z);
% pol = [pol_x,pol_y,pol_z];
figure()
subplot(3,1,1)
surf(X_T, Y_T, Z_T, 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'FaceColor',...
    'red')
hold on
surf(X_L, Y_L, Z_L,'EdgeColor','none','FaceAlpha', 0.5, 'FaceColor',...
    'blue')
scatter3(wx, wy, wz,'k','filled')
view([0 -90 0])
hold on
xlabel('x')
zlabel('z')
grid on
hold off

subplot(3,1,2)
surf(X_T, Y_T, Z_T, 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'FaceColor',...
    'red')
hold on
surf(X_L, Y_L, Z_L,'EdgeColor','none','FaceAlpha', 0.5, 'FaceColor',...
    'blue')
scatter3(wx, wy, wz,'k','filled')
hold on
view([90 0 0])
ylabel('y')
zlabel('z')
grid on
hold off

subplot(3,1,3)
surf(X_T, Y_T, Z_T, 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'FaceColor',...
    'red')
hold on
surf(X_L, Y_L, Z_L,'EdgeColor','none','FaceAlpha', 0.5, 'FaceColor',...
    'blue')
scatter3(wx, wy, wz,'k','filled')
view([0 0 90])
hold on
xlabel('x')
ylabel('y')
grid on
hold off

sgtitle(['2-D Planes of Polhode with Ellipsoid'])


%% Angular Velocity Phase Angle - Problem 6
alpha = diff(w)./diff(t);


%% Euler integration function - Problem 1
function [w_next] = euler_int(t, w_I)

wx = w_I(1);
wy = w_I(2);
wz = w_I(3);
Ix = w_I(4);
Iy = w_I(5);
Iz = w_I(6);

w_next = zeros(1,6);

w_next(1) = -((Iz - Iy)*wy*wz)/Ix;
w_next(2) = -((Ix - Iz)*wz*wx)/Iy;
w_next(3) = -((Iy - Ix)*wx*wy)/Iz;

w_next = w_next';








end