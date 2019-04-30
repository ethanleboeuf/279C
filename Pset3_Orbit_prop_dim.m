clear
close all
clc

%% AA279C Orbit Propagator

%% Initial Conditions/Constants
% Orbit parameters
constants % access constants (mu, distance to earth, etc.)

omega = (sqrt((mu.earth + mu.moon + mu.sun)/dis.sun^3));
mu1 = 328900.56^-1; % From NASA
r0 = [.98900883730044109; 0; 0.000802140914099732]*dis.sun;
v0 = [0; 0.010697471710460349-2.895683e-3; 0] * dis.sun * omega; % be careful changing. Very sensitive.
% state_sc_earth = [r; v; omega; mu.sun; mu.earth; mu1];
% Set time

tstart = 0;
tint = omega;
tend = 3600*24*365*omega; % convert to nondimensional time
wt = [tstart:tint:tend];
% DCM Rotational Parameters
w0 = [2; 1; 2.5] * pi()/180; % initial angular velocity
sc = init_sc();
sc = body_inertia_func(sc);
I_vec = [sc.Ip(1,1); sc.Ip(2,2); sc.Ip(3,3)];
% DCM = [0.892539 0.157379 -0.422618;-0.275451 0.932257 -0.234570;0.357073 0.325773 0.875426]';
% C = [.892539 .157379 -.422618 -.275451 0.932257 -.234570 .357073 0.325773 .875426];
DCM = eye(3);
C = eye(3);
rot_state = [C(:); w0; I_vec];
%% solving L1 point
syms x
eqn = x - (1-mu1)/(x+mu1)^2 + mu1/(x-1+mu1)^2 == 0;
digitsOld = digits(100);
L1 = vpasolve(eqn,x,[0,1]);
highPrecisionL1 = double(L1);
digits(digitsOld);
sim('SOHO_sim_v1.slx')

%% Quaternion Kinematics
% w_q = q_out(:,5:7)';
% % 
% 
% 
%% Plotting
% [A] = out2mat(dcm_out(:, 1:9));
% ang_momentum_I_plot(w_q, sc, A)
% ang_velocity_I_plot(w_q, A, sc)

figure()
scatter3(Inert_out(:,1), Inert_out(:,2), Inert_out(:,3), '.', 'b')
hold on 
scatter3(Inert_out(:,4), Inert_out(:,5), Inert_out(:,6), '.', 'r')
scatter3(Inert_out(:,7), Inert_out(:,8), Inert_out(:,9), '.', 'g')
hold off
%% Plotting
figure()
plot(BC_Rot_out(:,1), BC_Rot_out(:,2),'k','LineWidth',3)
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

figure('units','normalized','outerposition',[0 0 1 1])
scatter3(dcm_out(:,10), dcm_out(:, 11), dcm_out(:, 12))
hold on
xlabel('x, rad/s')
ylabel('y, rad/s')
zlabel('z, rad/s')
title('Principal Axes $\vec{\omega}$', 'Interpreter', 'latex')
hold off
