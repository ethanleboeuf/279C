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
w0 = [2; 1; 2.5] * pi()/180; % initial angular velocity

% DCM = eye(3);
DCM =[.892539 .157379 -.422618; -.275451 0.932257 -.234570; .357073 0.325773 .875426];
%% Gravity Gradient Torque

% I made some changes in here. I included sun and earth positions in the
% inertia out so we can get the exact gravity gradient for each of them
% since mu1 is not actually the gravitational parameter and is instead a
% mass ratio type thing


sim('SOHO_sim_v1.slx')
x = Inert_out(:,1);
y = Inert_out(:,2);
z = Inert_out(:,3);

x_s = Inert_out(:,4);
y_s = Inert_out(:,5);
z_s = Inert_out(:,6);

x_e = Inert_out(:,7);
y_e = Inert_out(:,8);
z_e = Inert_out(:,9);

xyz =[x y z];

R_s = sqrt(((x - x_s).^2)+((y - y_s).^2)+((z - z_s).^2));
R_e = sqrt(((x - x_e).^2)+((y - y_e).^2)+((z - z_e).^2));

cx_s = x./R_s;
cy_s = y./R_s;
cz_s = z./R_s;

cx_e = x./R_e;
cy_e = y./R_e;
cz_e = z./R_e;

% M = (3*mu1./(R.^3)).*[(Iz_sat - Iy_sat).*cy.*cz;(Ix_sat - Iz_sat).*cz.*cx;(Iy_sat - Ix_sat).*cx.*cy];

M_earth = (3*mu.earth./(R_e.^3)).*[((Iz_sat - Iy_sat).*cy_e.*cz_e)';...
    ((Ix_sat - Iz_sat).*cz_e.*cx_e)';...
    ((Iy_sat - Ix_sat).*cx_e.*cy_e)'];

%% K coefficients of Moments of Inertia
Ix_k = linspace(0,1e4);
Iy_k = linspace(0,1e4);
Iz_k = linspace(0,1e4);
k_R = (Iz_k-Iy_k)/Ix_k;
k_T = (Iz_k-Ix_k)/Iy_k;
k_N = (Iy_k-Ix_k)/Iz_k;
k_R_sat = (Iz_sat-Iy_sat)/Ix_sat;
k_T_sat = (Iz_sat-Ix_sat)/Iy_sat;
figure
plot(k_T_sat,k_R_sat,'o')
plot(k_T,k_R)
hold on
eqn1 = k_R.*k_T;
eqn2 = 1 + 3.*k_T + k_R.*k_T;

