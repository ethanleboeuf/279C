clear
close all
clc

%% Initialize SC
sc = init_sc();
sc = body_inertia_func(sc);
I_vec = [sc.Ip(1,1); sc.Ip(2,2); sc.Ip(3,3)];
Ix_sat = I_vec(1);
Iy_sat = I_vec(2);
Iz_sat = I_vec(3);
constants % access constants (mu, distance to earth, etc.)

omega = (sqrt((mu.earth + mu.moon + mu.sun)/dis.sun^3));
mu1 = 328900.56^-1; % From NASA
r0 = [.98900883730044109; 0; 0.000802140914099732]*dis.sun;
v0 = [0; 0.010697471710460349-2.895683e-3; 0] * dis.sun * omega;
% w0 = [2; 1; 2.5] * pi()/180; % initial angular velocity
% w0 = [0 ; 0; omega];
% w0 = [.01; 2; .01] * pi()/180; % initial angular velocity

% DCM =[.892539 .157379 -.422618; -.275451 0.932257 -.234570; .357073 0.325773 .875426];
DCM = [0.999999671094767 0 -8.110550887097017e-04; 0 1 0; 8.110550887097016e-04 0 0.999999671094768];
%% Gravity Gradient Torque

% I made some changes in here. I included sun and earth positions in the
% inertia out so we can get the exact gravity gradient for each of them
% since mu1 is not actually the gravitational parameter and is instead a
% mass ratio type thing


sim('SOHO_sim_v3.slx')
size = length(Inert_pos_out);
x = Inert_pos_out(:,1);
y = Inert_pos_out(:,2);
z = Inert_pos_out(:,3);

x_s = Inert_pos_out(:,4);
y_s = Inert_pos_out(:,5);
z_s = Inert_pos_out(:,6);

x_e = Inert_pos_out(:,7);
y_e = Inert_pos_out(:,8);
z_e = Inert_pos_out(:,9);

xyz =[x,y,z];
xyz_p = zeros(size,3);
% Rotate inertial coord to principal axes frame
[C] = out2mat(dcm_out);
for i = 1:size
   xyz_p(i,:) =  xyz(i,:)*C(:,:,i);
end

x_p = xyz_p(:,1);
y_p = xyz_p(:,2);
z_p = xyz_p(:,3);

R_s = sqrt(((x - x_s).^2)+((y - y_s).^2)+((z - z_s).^2));
R_e = sqrt(((x - x_e).^2)+((y - y_e).^2)+((z - z_e).^2));

cx_s = x_p./R_s;
cy_s = y_p./R_s;
cz_s = z_p./R_s;

cx_e = x_p./R_e;
cy_e = y_p./R_e;
cz_e = z_p./R_e;

M_earth = zeros(size,3);
M_sun = zeros(size,3);
for ii = 1:size
% Torque from earth 
M_earth(ii,:) = (3*mu.earth./((R_e(ii)).^3)).*[((Iz_sat - Iy_sat).*cy_e(ii).*cz_e(ii))',...
    ((Ix_sat - Iz_sat).*cz_e(ii).*cx_e(ii))',...
    ((Iy_sat - Ix_sat).*cx_e(ii).*cy_e(ii))'];
% Torque from sun
M_sun(ii,:) = (3*mu.sun./((R_s(ii)).^3)).*[((Iz_sat - Iy_sat).*cy_s(ii).*cz_s(ii))',...
    ((Ix_sat - Iz_sat).*cz_s(ii).*cx_s(ii))',...
    ((Iy_sat - Ix_sat).*cx_s(ii).*cy_s(ii))'];
end
% Combined torque
M_script = M_earth + M_sun;

