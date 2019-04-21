clear all
close all
set(0,'DefaultAxesFontSize',22)
set(0,'DefaultTextFontSize',26)
%% Problem Set 3
%% Initialize Spacecraft
sc = init_sc();
sc = body_inertia_func(sc);
I_vec = [sc.Ip(1,1); sc.Ip(2,2); sc.Ip(3,3)];
w = [.1; .1; 5] * pi()/180;

C = [.892539 .157379 -.422618; -.275451 0.932257 -.234570; .357073 0.325773 .875426];
q_init = DCM_to_quart(C);


%% Simulate Rotation DCM
state_init = [C(:); w; I_vec];
tstart = 0;
tint = .5;
tend = 100;

options = odeset('RelTol', 1e-5, 'AbsTol', 1e-8); 
[t_out, y_out] = ode113(@DCM_kin, [tstart:tint:tend]', state_init, options); 


%% Computing Angular Momentum
[A] = out2mat(y_out(:, 1:9));
L_vec_b = zeros(3, size(y_out, 1));
L_vec_I = zeros(3, size(y_out, 1));
w_I = zeros(3, size(y_out, 1));
prin_x = zeros(3, size(y_out,1));
prin_y = zeros(3, size(y_out,1));
prin_z = zeros(3, size(y_out,1));
for ii = 1:size(y_out,1)
    L_vec_b(:, ii) = sc.Ip * y_out(ii, 10:12)';
    L_vec_I(:, ii) = A(:,:,ii)' * L_vec_b(:, ii);
    w_I(:,ii) = A(:,:,ii)' * y_out(ii, 10:12)';
    prin_x(:, ii) = [A(1,1,ii); A(2,1,ii); A(3,1,ii)];
    prin_y(:, ii) = [A(1,2,ii); A(2,2,ii); A(3,2,ii)];
    prin_z(:, ii) = [A(1,3,ii); A(2,3,ii); A(3,3,ii)];
end

%% Plotting (Problem 4)
figure('units','normalized','outerposition',[0 0 1 1])
scatter3(L_vec_I(1,:), L_vec_I(2,:), L_vec_I(3,:))
hold on
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Angular Momentum Vector over Time')
hold off

fig = figure('units','normalized','outerposition',[0 0 1 1]);
scatter3(w_I(1,:), w_I(2,:), w_I(3,:), 'Filled')
hold on
[fig] = plane2vec(L_vec_I(:,1), fig, w_I(:,1));
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Angular Velocity Vector over Time')
legend('Angular Velocity', 'Angular Momentum Plane')
hold off

% figure('units','normalized','outerposition',[0 0 1 1])
% u = zeros(size(y_out,1),1);
% w = zeros(size(y_out,1),1);
% v = zeros(size(y_out,1),1);
% for ii = 1:5:size(y_out,1)
%     clrs = [ii / size(y_out,1), ii / size(y_out,1), ii / size(y_out,1)];
%     quiver3(0,0,0, prin_x(1,ii)', prin_x(2,ii)', prin_x(3,ii)','color',clrs)
%     hold on
%     quiver3(0,0,0, prin_y(1,ii)', prin_y(2,ii)', prin_y(3,ii)','color',clrs)
%     quiver3(0,0,0, prin_z(1,ii)', prin_z(2,ii)', prin_z(3,ii)','color',clrs)
% end
% hold off

figure('units','normalized','outerposition',[0 0 1 1])
scatter3(y_out(:,10), y_out(:, 11), y_out(:, 12))
hold on
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Angular Momentum Vector over Time')
hold off

%% NEW ROTATIONS
C = eye(3);
w = [.01; 6; 0.01] * pi()/180;

%% Simulate Rotation DCM
state_init = [C(:); w; I_vec];
tstart = 0;
tint = .5;
tend = 100;

options = odeset('RelTol', 1e-5, 'AbsTol', 1e-8); 
[t_out, y_out] = ode113(@DCM_kin, [tstart:tint:tend]', state_init, options); 


%% Computing Angular Momentum
[A] = out2mat(y_out(:, 1:9));
L_vec_b = zeros(3, size(y_out, 1));
L_vec_I = zeros(3, size(y_out, 1));
w_I = zeros(3, size(y_out, 1));
prin_x = zeros(3, size(y_out,1));
prin_y = zeros(3, size(y_out,1));
prin_z = zeros(3, size(y_out,1));
for ii = 1:size(y_out,1)
    L_vec_b(:, ii) = sc.Ip * y_out(ii, 10:12)';
    L_vec_I(:, ii) = A(:,:,ii)' * L_vec_b(:, ii);
    w_I(:,ii) = A(:,:,ii)' * y_out(ii, 10:12)';
    prin_x(:, ii) = [A(1,1,ii); A(2,1,ii); A(3,1,ii)];
    prin_y(:, ii) = [A(1,2,ii); A(2,2,ii); A(3,2,ii)];
    prin_z(:, ii) = [A(1,3,ii); A(2,3,ii); A(3,3,ii)];
end

%% Plotting (Problem 4)
figure('units','normalized','outerposition',[0 0 1 1])
scatter3(L_vec_I(1,:), L_vec_I(2,:), L_vec_I(3,:))
hold on
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Angular Momentum Vector over Time new')
hold off

fig = figure('units','normalized','outerposition',[0 0 1 1]);
scatter3(w_I(1,:), w_I(2,:), w_I(3,:), 'Filled')
hold on
[fig] = plane2vec(L_vec_I(:,1), fig, w_I(:,1));
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Angular Velocity Vector over Time')
legend('Angular Velocity', 'Angular Momentum Plane')
hold off

% figure('units','normalized','outerposition',[0 0 1 1])
% u = zeros(size(y_out,1),1);
% w = zeros(size(y_out,1),1);
% v = zeros(size(y_out,1),1);
% for ii = 1:5:size(y_out,1)
%     clrs = [ii / size(y_out,1), ii / size(y_out,1), ii / size(y_out,1)];
%     quiver3(0,0,0, prin_x(1,ii)', prin_x(2,ii)', prin_x(3,ii)','color',clrs)
%     hold on
%     quiver3(0,0,0, prin_y(1,ii)', prin_y(2,ii)', prin_y(3,ii)','color',clrs)
%     quiver3(0,0,0, prin_z(1,ii)', prin_z(2,ii)', prin_z(3,ii)','color',clrs)
% end
% hold off

figure('units','normalized','outerposition',[0 0 1 1])
scatter3(y_out(:,10), y_out(:, 11), y_out(:, 12))
hold on
xlabel('x axis')
ylabel('y axis')
zlabel('z axis')
title('Angular Momentum Vector over Time')
hold off

%% Simulate Rotation Quaternions
% state_init = [q_init; w; I_vec];
% tstart = 0;
% tint = .5;
% tend = 1000;
% 
% options = odeset('RelTol', 1e-5, 'AbsTol', 1e-8); 
% [t_out, y_out] = ode113(@quat_kin, [tstart:tint:tend]', state_init, options); 
% 
% 
% %% Plot Rotation
% % figure()
% % % u = zeros(size(y_out,1),1);
% % % w = zeros(size(y_out,1),1);
% % % v = zeros(size(y_out,1),1);
% % % quiver3(u,w,v, y_out(:,1), y_out(:,2), y_out(:,3))
% % scatter3(y_out(:,1), y_out(:,2), y_out(:,3))
% % hold on
% % xlabel('x axis')
% % ylabel('y axis')
% % zlabel('z axis')
% % title('Angular Velocity Vector over Time')
% % hold off
% for ii = 1:size(y_out,1)
%     mag_q(ii) = norm(y_out(ii, 1:4));
% end
% figure()
% plot(t_out(:), mag_q)