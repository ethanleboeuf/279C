
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
[t,w_dot] = ode113(@euler_int, tspan, w_I, options);
wx = w_dot(:,1);
wy = w_dot(:,2);
wz = w_dot(:,3);
I = [Ix,0,0;0,Iy,0;0,0,Iz];
w = [wx,wy,wz]';
%% Rotational Kinetic Energy & Momentum Ellipsoid - Problem 3
for i = 1:size(w, 2)
   L = (I*w(:, i))';
   L_mag(i) = norm(L); 
end
T2 = (wx.^2)*Ix + (wy.^2)*Iy + (wz.^2)*Iz; % Rot Kinetic Energy
L2 = (L_mag).^2; % Momentum
% Energy Ellipsoid
a_T = mean(T2./Ix);
b_T = mean(T2./Iy);
c_T = mean(T2./Iz);
[X_T,Y_T,Z_T] = ellipsoid(0,0,0,a_T,b_T,c_T);
% Momentum Ellipsoid
a_L = mean(L2./Ix);
b_L = mean(L2./Iy);
c_L = mean(L2./Iz);
[X_L,Y_L,Z_L] = ellipsoid(0,0,0,a_L,b_L,c_L);
% Plot Ellipsoid
figure
surf(X_T,Y_T,Z_T)
title('Energy Ellipsoid')
xlabel('x')
ylabel('y')
zlabel('z')
figure
surf(X_L,Y_L,Z_L)
title('Momentum Ellipsoid')
xlabel('x')
ylabel('y')
zlabel('z')

% figure
% plot3(wx, wy, wz)
% xlabel('w_x')
% ylabel('w_y')
% zlabel('w_z')
%% 3D Polhode - Problem 4


%% 2D Polhode - Problem 5

%% Euler integration function - Problem 1
function [w_dot] = euler_int(t, w_I)

wx = w_I(1);
wy = w_I(2);
wz = w_I(3);
Ix = w_I(4);
Iy = w_I(5);
Iz = w_I(6);

w_dot = zeros(1,6);

w_dot(1) = -((Iz - Iy)*wy*wz)/Ix;
w_dot(2) = -((Ix - Iz)*wz*wx)/Iy;
w_dot(3) = -((Iy - Ix)*wx*wy)/Iz;

w_dot = w_dot';








end