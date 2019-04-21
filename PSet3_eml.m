clear all
close all
set(0,'DefaultAxesFontSize',22)
set(0,'DefaultTextFontSize',26)
%% Problem Set 3
%% Initialize Spacecraft
sc = init_sc();
sc = body_inertia_func(sc);
I_vec = [sc.Ip(1,1); sc.Ip(2,2); sc.Ip(3,3)];
w = [.001; .001; 5] * pi()/180;

% C = [.892539 .157379 -.422618; -.275451 0.932257 -.234570; .357073 0.325773 .875426];
C = eye(3);
q_init = DCM_to_quat(C);


%% Simulate Rotation DCM
state_init = [C(:); w; I_vec];
tstart = 0;
tint = .5;
tend = 1000;

options = odeset('RelTol', 1e-5, 'AbsTol', 1e-8); 
[t_out, y_out] = ode113(@DCM_kin, [tstart:tint:tend]', state_init, options); 


%% Computing Angular Momentum
[A] = out2mat(y_out(:, 1:9));
w_out = y_out(:, 10:12)';

%% Plotting
ang_momentum_I_plot(w_out, sc, A)
ang_velocity_I_plot(w_out, A)
% axes_plot(A, sc)


figure('units','normalized','outerposition',[0 0 1 1])
scatter3(y_out(:,10), y_out(:, 11), y_out(:, 12))
hold on
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Body Axes \omega Vector')
hold off

%% NEW ROTATIONS
C = eye(3);
w = [.01; 6; 0.01] * pi()/180;

%% Simulate Rotation DCM
state_init = [C(:); w; I_vec];
tstart = 0;
tint = .5;
tend = 5000;

options = odeset('RelTol', 1e-5, 'AbsTol', 1e-8); 
[t_out, y_out] = ode113(@DCM_kin, [tstart:tint:tend]', state_init, options); 


%% Computing Angular Momentum
[A] = out2mat(y_out(:, 1:9));
w_out = y_out(:, 10:12)';
%% Plotting (Problem 4)

ang_momentum_I_plot(w_out, sc, A)
ang_velocity_I_plot(w_out, A)
% axes_plot(A, sc)

figure('units','normalized','outerposition',[0 0 1 1])
scatter3(y_out(:,10), y_out(:, 11), y_out(:, 12))
hold on
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Body Axes \omega Vector')
hold off


%% Momentum Wheel Testing

w = [.001; 6; .001] * pi()/180;
% C = [.892539 .157379 -.422618; -.275451 0.932257 -.234570; .357073 0.325773 .875426];
C = eye(3);

Ir = 90; %from SMAD
r_w = [1; 1; 0]/norm([1;1;0]);
wr = 1;  %from SMAD
state_init = [C(:); w; I_vec; wr; Ir; r_w];
tstart = 0;
tint = .5;
tend = 5000;

options = odeset('RelTol', 1e-5, 'AbsTol', 1e-8); 
[t_out, y_out] = ode113(@DCM_kin_wheel, [tstart:tint:tend]', state_init, options); 

[A] = out2mat(y_out(:, 1:9));
w_out = y_out(:, 10:12)';
ang_momentum_I_plot(w_out, sc, A)
ang_velocity_I_plot(w_out, A)
% figure('units','normalized','outerposition',[0 0 1 1])
% scatter3(y_out(:,10), y_out(:, 11), y_out(:, 12))
% hold on
% xlabel('x axis')
% ylabel('y axis')
% zlabel('z axis')
% title('Angular Momentum Vector over Time')
% hold off

% Ir * wr > (I_vec(3) - I_vec(2))*w(2)
% Ir * wr > (I_vec(1) - I_vec(3))*w(2)

%% Simulate Rotation Quaternions
state_init = [q_init; w; I_vec];
tstart = 0;
tint = .5;
tend = 1000;

options = odeset('RelTol', 1e-5, 'AbsTol', 1e-8); 
[t_out, y_out] = ode113(@quat_kin, [tstart:tint:tend]', state_init, options); 


%% Plot Rotation
% figure()
% % u = zeros(size(y_out,1),1);
% % w = zeros(size(y_out,1),1);
% % v = zeros(size(y_out,1),1);
% % quiver3(u,w,v, y_out(:,1), y_out(:,2), y_out(:,3))
% scatter3(y_out(:,1), y_out(:,2), y_out(:,3))
% hold on
% xlabel('x axis')
% ylabel('y axis')
% zlabel('z axis')
% title('Angular Velocity Vector over Time')
% hold off
for ii = 1:size(y_out,1)
    mag_q(ii) = norm(y_out(ii, 1:4));
end
figure()
plot(t_out(:), mag_q)