clear all
close all
set(0,'DefaultAxesFontSize',22)
set(0,'DefaultTextFontSize',26)
%% Pset 2
%% Initialize Spacecraft
sc = init_sc();
sc = body_inertia_func(sc);
I_vec = [sc.Ip(1,1); sc.Ip(2,2); sc.Ip(3,3)];
w = [.01; 5; 0.01] * pi()/180;
state_init = [w; I_vec];
%% Calculate Kinetic Energy for Ellipsoids
Lvec = sc.Ip * w;
L = norm(Lvec);
TwoT = dot(w, Lvec);

%% Simulate Rotation
tstart = 0;
tint = .5;
tend = 1000;
options = odeset('RelTol', 1e-5, 'AbsTol', 1e-8); 
[t_out, y_out] = ode113(@euler_eq, [tstart:tint:tend]', state_init, options); 


%% Plot Rotation
figure()
% u = zeros(size(y_out,1),1);
% w = zeros(size(y_out,1),1);
% v = zeros(size(y_out,1),1);
% quiver3(u,w,v, y_out(:,1), y_out(:,2), y_out(:,3))
scatter3(y_out(:,1), y_out(:,2), y_out(:,3))
hold on
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Angular Velocity Vector over Time')
hold off

omegas = [y_out(:,1) y_out(:,2) y_out(:,3)];
[fig] = phase_omega_plots(omegas,t_out);


%% Plot Ellipsoid and Polhode
[fig] = polhode_ellipsoid_plots(w, sc.Ip, y_out(:,1:3));

%% Axial - Symmetric
I_vec(2) = I_vec(1);
state_init = [w; I_vec];

tstart = 0;
tint = .5;
tend = 1000; % convert to nondimensional time

options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10); 
[t_out, y_out_2] = ode113(@euler_eq, [tstart:tint:tend]', state_init, options); 
figure()
scatter3(y_out_2(:,1), y_out_2(:,2), y_out_2(:,3))
hold on
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Axi-Symmetric Motion - Numeric')
hold off

y_out_3 = axi_sym_euler(t_out, w, sc.Ip);

figure()
scatter3(y_out_3(:,1), y_out_3(:,2), y_out_3(:,3))
hold on
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Axi-Symmetric Motion - Analytical')
hold off
