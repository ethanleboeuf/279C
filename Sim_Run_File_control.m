clear
close all

%% Script to Run the Sim

sc = init_sc();
sc = body_inertia_func(sc);
Rot = sc.R;
I_vec = [sc.Ip(1,1); sc.Ip(2,2); sc.Ip(3,3)];
Ix_sat = I_vec(1);
Iy_sat = I_vec(2);
Iz_sat = I_vec(3);
% Convert sc struct to arrays
subsections = {'rect';'base';'fuel';'sp1';'sp2'};
count = 1;
for subsect = subsections'
    faces = fieldnames(sc.(subsect{1}));
    for face = faces'
        areas(count) = sc.(subsect{1}).(face{1}).area;
        bcs(count,:) = sc.(subsect{1}).(face{1}).bc;
        normals(count,:) = sc.R * sc.(subsect{1}).(face{1}).normal;
        count = count+1;
    end
end

constants % access constants (mu, distance to earth, etc.)

omega = (sqrt((mu.earth + mu.moon + mu.sun)/dis.sun^3));
mu1 = 328900.56^-1; % From NASA
r0 = [.98900883730044109; 0; 0.000802140914099732]*dis.sun;
v0 = [0; 0.010697471710460349-2.895683e-3; 0] * dis.sun * omega;

w0 = [3; 2; 2.5] * pi()/180; % initial angular velocity
% w0 = [omega/100 ; omega; omega/100];
% w0 = [3; 0.2; 0.2]*pi/180;

% DCM =[.892539 .157379 -.422618; -.275451 0.932257 -.234570; .357073 0.325773 .875426];
% DCM = sc.R'*[-1 0 0; 0 -1 0; 0 0 1];
DCM = sc.R'*[-1 0 0; 0 -1 0; 0 0 1];
% DCM = [0.999999671094767 0 -8.110550887097017e-04; 0 1 0; 8.110550887097016e-04 0 0.999999671094768];


% Using this as a switch case parameter
% 0 = deterministic att det
% 1 = q method
% 2 = angular velocity and kinematic equations
att_det_method = 0;
q0 = DCM_to_quat(DCM);
acc_gyro_bias = 0.5 * pi/180 / 60 / 60; % 0.003 to 1 deg/hr (SMAD) - will need to make this bigger to see any change
acc_gyro = 0.01 * pi/180 / 60 / 60; 
sun_err_bias = 1 * pi/180; % 0.005 to 3 deg, sun sensor error (SMAD)
sun_err_var = 0.01 * pi/180;
star_err_bias = 0.001 * pi/180; % 0.0003 to 0.01 deg, star tracker error (SMAD)
star_err_var = 0.0005 * pi/180;

% sun_err_var = 1 * pi/180;
% acc_gyro = 1 * pi/180 / 60 / 60; 
% star_err_var = 1 * pi/180;


%% Generate Random Noise and Run Sim
end_time = 2000;
dt = .1;
% num_noise = ceil(end_time / 10);
num_noise = 1000;
sun_noise = mvnrnd(zeros(num_noise, 3), sun_err_var*eye(3))';
star_noise = mvnrnd(zeros(num_noise, 3), star_err_var*eye(3))';
gyro_noise = mvnrnd(zeros(num_noise, 3), acc_gyro* eye(3))';

%% Control Constants
% kp = 0.1 ^ 2 / Iy_sat;
% kd = 2 * sqrt(Iy_sat * (1e-6 + kp));


sim('SOHO_sim_vcontrol.slx')