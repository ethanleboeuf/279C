clear all
close all
set(0,'DefaultAxesFontSize',22)
set(0,'DefaultTextFontSize',26)
%% Problem Set 3
%% Initialize Spacecraft
sc = init_sc();
sc = body_inertia_func(sc);
I_vec = [sc.Ip(1,1); sc.Ip(2,2); sc.Ip(3,3)];


C = [.892539 .157379 -.422618; -.275451 0.932257 -.234570; .357073 0.325773 .875426];
% C = [-0.772922388957927 0 -0.634500575766146; 0 1 0; 0.634500575766146...
%     0 -0.772922388957927]';
% w = [2; 1; 2.5] * pi()/180;
% w =  [0; 0; 3] * pi()/180;
% w = [0.001; 5; 0.001] * pi()/180;
% w = [5; 0.001; 0.001] * pi/180;
w = [2; 0; 0] * pi/180;
% C = eye(3);
q_init = DCM_to_quat(C);


%% Simulate Rotation DCM
state_init = [C(:); w; I_vec];
tstart = 0;
tint = .25;
tend = 1000;

options = odeset('RelTol', 1e-10, 'AbsTol', 1e-12); 
[t_out, y_out] = ode113(@DCM_kin, [tstart:tint:tend]', state_init, options); 


%% Computing Angular Momentum
[A] = out2mat(y_out(:, 1:9));
w_out = y_out(:, 10:12)';

%% Plotting
ang_momentum_I_plot(w_out, sc, A)
ang_velocity_I_plot(w_out, A, sc)
axes_plot(A, sc)


figure('units','normalized','outerposition',[0 0 1 1])
scatter3(y_out(:,10), y_out(:, 11), y_out(:, 12))
hold on
xlabel('x, rad/s')
ylabel('y, rad/s')
zlabel('z, rad/s')
title('Principal Axes $\vec{\omega}$', 'Interpreter', 'latex')
hold off

omega_time_plots(t_out, w_out)


% %% Momentum Wheel Testing
% w = [0.001; 6; 0.001] * pi()/180;
% w = [0;6;0] * pi()/180;
% w = [6; 0.001; 0.001] * pi()/180;
% C = [.892539 .157379 -.422618; -.275451 0.932257 -.234570; .357073 0.325773 .875426];
% C = eye(3);
% 
% Ir = 90; %from SMAD
% r_w = [0; 1; 0]/norm([1;0;0]);
% wr = 2*pi/10;  %from SMAD
% state_init = [C(:); w; I_vec; wr; Ir; r_w];
% tstart = 0;
% tint = .5;
% tend = 5000;
% 
% options = odeset('RelTol', 1e-10, 'AbsTol', 1e-12); 
% [t_out, y_out] = ode113(@DCM_kin_wheel, [tstart:tint:tend]', state_init, options); 
% 
% state_init = [C(:); w; I_vec; 2*pi; Ir; r_w];
% options = odeset('RelTol', 1e-5, 'AbsTol', 1e-8); 
% [t_out, y_out_2] = ode113(@DCM_kin_wheel, [tstart:tint:tend]', state_init, options); 
% 
% 
% [A] = out2mat(y_out(:, 1:9));
% w_out = y_out(:, 10:12)';
% 
% [A2] = out2mat(y_out_2(:, 1:9));
% w_out_2 = y_out_2(:, 10:12)';
% 
% % ang_momentum_I_plot(w_out, sc, A)
% % 
% % ang_velocity_I_plot(w_out, A, sc)
% % ang_velocity_I_plot(w_out_2, A2, sc)
% % axes_plot(A, sc)
% % 
% % figure('units','normalized','outerposition',[0 0 1 1])
% % scatter3(y_out(:,10), y_out(:, 11), y_out(:, 12))
% % hold on
% % xlabel('x, rad/s')
% % ylabel('y, rad/s')
% % zlabel('z, rad/s')
% % title('Principal Axes $\vec{\omega}$', 'Interpreter', 'latex')
% % hold off
% 
% Ir * wr > (I_vec(3) - I_vec(2))*w(2);
% Ir * wr > (I_vec(1) - I_vec(2))*w(2);

%% Simulate Rotation Quaternions
state_init = [q_init; w; I_vec];
tstart = 0;
tint = .25;
tend = 1000;

options = odeset('RelTol', 1e-10, 'AbsTol', 1e-12); 
[t_out, y_out] = ode113(@quat_kin, [tstart:tint:tend]', state_init, options); 
q = y_out(:, 1:4)';
w_q = y_out(:, 5:7)';
[DCM] = quat_to_DCM(q);

% ang_momentum_I_plot(w_q, sc, DCM)
ang_velocity_I_plot(w_q, DCM, sc)
% axes_plot(DCM, sc)

% omega_time_plots(t_out, w_q)
mag_q = zeros(1, size(y_out,1));
err_dcm = zeros(size(y_out,1),1);
for ii = 1:size(y_out,1)
    mag_q(ii) = norm(y_out(ii, 1:4));
    temp = (A(:,:,ii) - DCM(:,:,ii));
    err_dcm(ii) = norm(temp(:));
end
figure()
plot(t_out(:), mag_q - ones(1, length(mag_q)))
hold on
xlabel('Time, s')
ylabel('$$||\vec{q}|| - 1$$','Interpreter','latex')
title('Error of Quaternion Magnitude')
hold off

figure()
plot(t_out(:), err_dcm)
hold on
xlabel('Time, s')
ylabel('Relative Error')
title('A - DCM(q)')
hold off