clear
close all

%% Script to Run the Sim

sc = init_sc();
sc = body_inertia_func(sc);
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

% w0 = [2; 1; 2.5] * pi()/180; % initial angular velocity
w0 = [omega/100 ; omega; omega/100];

% DCM =[.892539 .157379 -.422618; -.275451 0.932257 -.234570; .357073 0.325773 .875426];
DCM = sc.R'*[-1 0 0; 0 -1 0; 0 0 1];
% DCM = [0.999999671094767 0 -8.110550887097017e-04; 0 1 0; 8.110550887097016e-04 0 0.999999671094768];


% Using this as a switch case parameter
% 0 = deterministic att det
% 1 = q method
% 2 = angular velocity and kinematic equations
att_det_method = 1;


sim('SOHO_sim_v7.slx')