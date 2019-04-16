%% Inertia Tensor
close all
clear
clc
format long
%% Constants
% Fuel Tank
m_f = 762.738; % mass of fuel tank
w_f = 1.85;
b_f = 2.7;
h_f = 0.7;
% Base Section
m_b = 381.369; % mass of base
w_b = 1.85;
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
I_xf = (1/12)*m_f*(w_f^2 + b_f^2); % fuel tank
d_xf = w_f/2;
I_xb = (1/12)*m_b*(w_b^2 + b_b^2); % base tank
d_xb = w_b/2;
I_xsp = (1/12)*m_sp*(w_sp^2 + b_sp^2); % solar panel
d_xsp = 0.5*(w_b + w_sp);
I_xp = (1/12)*m_p*(w_p^2 + b_p^2); % payload
% Total X-dim
I_x = (I_xf + m_f*d_xf^2) + (I_xb + m_b*d_xb^2) + 2*(I_xsp + m_sp*d_xsp^2) + I_xp;
% Y-dim
I_yf = (1/12)*m_f*(b_f^2 + h_f^2);
d_yf = h_f/2;
I_yb = (1/12)*m_b*(b_b^2 + h_b^2);
d_yb = h_b/2;
I_ysp = (1/12)*m_sp*(b_sp^2 + h_sp^2);
d_ysp = h_sp/2;
I_yp = (1/12)*m_p*(b_p^2 + h_p^2);
d_yp = (h_p/2) + h_b;
% Total Y-dim
I_y = (I_yf + m_f*d_yf^2) + (I_yb + m_b*d_yb^2) + 2*(I_ysp + m_sp*d_ysp^2) + (I_yp + m_p*d_yp^2);
% Z-dim
I_zf = (1/12)*m_f*(h_f^2 + w_f^2);
d_zf = sqrt(((h_f/2)^2) + ((w_f/2)^2));
I_zb = (1/12)*m_b*(h_b^2 + w_b^2);
d_zb = sqrt(((h_b/2)^2) + ((w_b/2)^2));
I_zsp = (1/12)*m_sp*(h_sp^2 + w_sp^2);
d_zsp = sqrt((h_sp/2)^2 + ((w_sp+w_b)/2)^2);
I_zp = (1/12)*m_p*(h_p^2 + w_p^2);
d_zp = h_b + (h_p/2);
% Total Z-dim
I_z = (I_zb + m_b*d_zb^2) + (I_zb + m_b*d_zb^2) + 2*(I_zsp + m_sp*(d_zsp^2)) + (I_zp + m_p*d_zp^2);
% Products of Inertia
I_xyf = m_f*w_f*b_f;
I_xyb = m_f*w_b*b_b;
I_xysp = m_f*w_sp*b_sp;
I_xyp = m_f*w_p*b_p;
I_xy = I_xyf + I_xyb + 2*I_xysp + I_xyp; 
I_yz = 0; % x-y plane symmetric
I_xz = 0; % x-y plane symmetric
I_yx = I_xy;
I_zx = I_xz;
I_zy = I_yz;
%% Body Axes Inertia Tensor
I_b = [I_x,-I_xy,-I_xz;-I_yx,I_y,-I_yz;-I_zx,-I_zy,I_z];
%% Principal Axes Inertia Tensor
[R,I_p] = eig(I_b); % R - eigenvectors/rotation matrix, D - eigenvalues/inertia tensor principal axes




