clear all
close all
set(0,'DefaultAxesFontSize',22)
set(0,'DefaultTextFontSize',26)
%% Problem Set 3
%% Initialize Spacecraft
sc = init_sc();
sc = body_inertia_func(sc);
I_vec = [sc.Ip(1,1); sc.Ip(2,2); sc.Ip(3,3)];
w = [3; 3; 3] * pi()/180;

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

    
u = zeros(size(y_out,1),1);
w = zeros(size(y_out,1),1);
v = zeros(size(y_out,1),1);

h = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'testAnimated.gif';
for n = 1:size(y_out,1)
    
    quiver3(0,0,0, prin_x(1,n)', prin_x(2,n)', prin_x(3,n)', 'b')
    hold on
    drawnow 
      % Capture the plot as an image 
      frame = getframe(h); 
      im = frame2im(frame); 
      [imind,cm] = rgb2ind(im,256); 
      % Write to the GIF File 
      if n == 1 
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
      else 
          imwrite(imind,cm,filename,'gif','WriteMode','append'); 
      end 
end