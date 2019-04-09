close all
clear
clc

%% Constants
% Base Section
m_b = 1144.107; % mass of base
w_b = 3.7;
b_b = 2.7;
h_b = 0.7;
% Solar Panels
m_sp = 47.947; % mass of each solar panel
w_sp = 2.9;
b_sp = 2.7;
h_sp = 0.03;
% Payload Section
m_p = 610; % mass of payload section
w_p = 1.85;
b_p = 1.85;
h_p = 3.6;
%% Inertia calcs
% X-dim
I_xb = (1/12)*m_b*(w_b)^2;
I_xsp = (1/12)*m_sp*(w_sp)^2;
d_xsp = 0.5*(w_b + w_sp);
I_xp = (1/12)*m_p*(w_p)^2;
% Total X-dim
I_x = I_xb + 2*(I_xsp + m_sp*(d_xsp^2)) + I_xp;
% Y-dim
I_yb = (1/12)*m_b*(b_b)^2;
I_ysp = (1/12)*m_sp*(b_sp)^2;
I_yp = (1/12)*m_p*(b_p)^2;
% Total Y-dim
I_y = I_yb + 2*(I_ysp) + I_yp;
% Z-dim
I_zb = (1/12)*m_b*(h_b)^2;
d_zb = 0.5*(h_b);
I_zsp = (1/12)*m_sp*(h_sp)^2;
d_zsp = 0.5*(h_sp);
I_zp = (1/12)*m_p*(h_p)^2;
d_zp = h_b + 0.5*(h_p);
% Total Z-dim
I_z = (I_zb + m_b*(d_zb^2)) + 2*(I_zsp + m_sp*(d_zsp^2)) + (I_zp + m_p*(d_zp^2));
% Products of Inertia
I_xy = 0; % z-x plane symmetric
I_xz = 0; % x-y plane symmetric
I_zy = 0; % z-x plane symmetric
I_yx = I_xy;
I_zx = I_xz;
I_yz = I_zy;
%% Inertia Tensor
I = [I_x,-I_xy,-I_xz;-I_yx,I_y,-I_yz;-I_zx,-I_zy,I_z];
%% Principal Axes
[V,D] = eig(I);



