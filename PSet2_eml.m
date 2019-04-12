clear all
close all

%% Pset 2
%% Initialize Spacecraft
sc = init_sc();
sc = body_inertia_func(sc);
I_vec = [sc.I(1,1); sc.I(2,2); sc.I(3,3)];
w = [7; 1; 7] * pi()/180;
state_init = [w; I_vec];
%% Calculate Kinetic Energy for Ellipsoids
Lvec = sc.I * w;
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
[fig] = polhode_ellipsoid_plots(w, sc.I, y_out(:,1:3));

%% Axial - Symmetric
I_vec(2) = I_vec(1);
state_init = [w; I_vec];

tstart = 0;
tint = .5;
tend = 1000; % convert to nondimensional time

options = odeset('RelTol', 1e-5, 'AbsTol', 1e-8); 
[t_out, y_out] = ode113(@euler_eq, [tstart:tint:tend]', state_init, options); 
figure()
scatter3(y_out(:,1), y_out(:,2), y_out(:,3))
hold on
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Axi-Symmetric Motion - Numeric')
hold off

y_out = axi_sym_euler(t_out, w, sc.I);

figure()
scatter3(y_out(:,1), y_out(:,2), y_out(:,3))
hold on
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Axi-Symmetric Motion - Analytical')
hold off
