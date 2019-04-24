clear
close all
clc

%% AA279C Orbit Propagator

%% Initial Conditions/Constants
% Orbit parameters
constants % access constants (mu, distance to earth, etc.)
mu1 = 328900.56^-1; % From NASA
r0 = [.98900883730044109; 0; 0.000802140914099732]; % initial position
% v0 = [0; 0.010697471710460349-3.24199547e-3; 0]; % initial velocity
v0 = [0; 0.010697471710460349-3.24371e-3; 0]; % initial velocity
% Set time
omega = (sqrt((mu.earth + mu.moon + mu.sun)/dis.sun^3));
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
sim('Orbit_prop_279C_v2.slx')
sim('Kin_prop_279C_v1.slx')

%% RTN Frame
r = y_out(:,1:3);
v = y_out(:,4:6);
r_L1 = [highPrecisionL1,0,0];
n = length(r);
r_RTN = zeros(3, n);
r_RTN_mag = zeros(n,1);
R_RTN = zeros(3, n);
n_RTN = zeros(3, n);
n_RTN_mag = zeros(n,1);
N_RTN = zeros(3,n);
t_RTN = zeros(3,n);
t_RTN_mag = zeros(n,1);
T_RTN = zeros(3,n);
RTN = zeros(3,3,n);
for i = 1:n
    r_rel = r(i,:) - r_L1;
    R_RTN(:,i) = r_rel'./norm(r_rel');
    v_rel = v(i,:)' ;%- cross([0;0;omega],r_L1');
    N_RTN(:,i) = cross(r_rel',v_rel)./norm(cross(r_rel',v_rel));
    T_RTN(:,i) = cross(N_RTN(:,i),R_RTN(:,i));
    RTN(:, :, i) = [R_RTN(:,i) T_RTN(:,i) N_RTN(:,i)];
%     t_RTN_mag(i) = norm(t_RTN(:,i));
%     T_RTN(:,i) = t_RTN(:,i)./t_RTN_mag(i);
end


%% XYZ to RTN Rotation
R = zeros(3,3,n);
for ii = 1:length(t)
    R(1,:,ii) = [cos(t(ii)) sin(t(ii)) 0];
    R(2,:,ii) = [-sin(t(ii)) cos(t(ii)) 0];
    R(3,:,ii) = [0 0 1];
end

%% DCM Kinematics
w_dcm = y_dcm_out(:,10:12)';

%% Quaternion Kinematics
w_q = y_q_out(:,5:7);



%% Plotting
[A] = out2mat(y_dcm_out(:, 1:9));
ang_momentum_I_plot(w_dcm, sc, A)
ang_velocity_I_plot(w_dcm, A, sc)


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


figure('units','normalized','outerposition',[0 0 1 1])
scatter3(y_dcm_out(:,10), y_dcm_out(:, 11), y_dcm_out(:, 12))
hold on
xlabel('x, rad/s')
ylabel('y, rad/s')
zlabel('z, rad/s')
title('Principal Axes $\vec{\omega}$', 'Interpreter', 'latex')
hold off


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
