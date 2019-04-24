clear all
close all

%% Pset 3 ONE RUN - Most Plots
sc = init_sc();
sc = body_inertia_func(sc);
I_vec = [sc.Ip(1,1); sc.Ip(2,2); sc.Ip(3,3)];

w = [.001; 5; 0.001] * pi()/180;
% C = [.892539 .157379 -.422618; -.275451 0.932257 -.234570; .357073 0.325773 .875426];
C = eye(3);
q_init = DCM_to_quat(C);

%% Simulate Rotation DCM
state_init = [C(:); w; I_vec];
tstart = 0;
tint = .5;
tend = 5000;

options = odeset('RelTol', 1e-10, 'AbsTol', 1e-11); 
[t_out, y_out] = ode113(@DCM_kin, [tstart:tint:tend]', state_init, options); 

[A] = out2mat(y_out(:, 1:9));
w_out = y_out(:, 10:12)';
%% Plots

ang_momentum_I_plot(w_out, sc, A)
ang_velocity_I_plot(w_out, A)
axes_plot(A, sc)