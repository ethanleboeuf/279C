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
mu1 = 328900.56^-1; % From NASA, Barycenter GM
omega = (sqrt((mu.earth + mu.moon + mu.sun)/dis.sun^3));
r0 = [.98900883730044109; 0; 0.000802140914099732]; % initial position
v0 = [0; 0.010697471710460349-3.24371e-3; 0]; % initial velocity
w0 = [2; 1; 2.5] * pi()/180; % initial angular velocity
DCM = eye(3);
%% Gravity Gradient Torque
sim('SOHO_sim_v1.slx')
x = Inert_out(:,1);
y = Inert_out(:,2);
z = Inert_out(:,3);
xyz =[x;y;z];
% xyz_p = 
R = sqrt((x.^2)+(y.^2)+(z.^2));
cx = x./R;
cy = y./R;
cz = z./R;
M = (3*mu1./(R.^3)).*[(Iz_sat - Iy_sat).*cy.*cz;(Ix_sat - Iz_sat).*cz.*cx;(Iy_sat - Ix_sat).*cx.*cy];

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

