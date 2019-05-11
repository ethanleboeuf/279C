function [sc] = body_inertia_func(sc)
%% Inertia Tensor
% close all
% clear
% clc
format long
%% Constants
% Fuel Tank
m_f = 762.738; % mass of fuel tank
% m_f = 3000;
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
M = m_f + m_b + 2*m_sp + m_p;
% CM location
x_cm = (2 * m_sp * h_sp/2 + m_f*h_f/2 + m_b*h_b/2 + m_p*(h_b + h_p/2))/...
    (2 * m_sp + m_f + m_b + m_p);
y_cm = (m_sp * (w_sp/2 + w_f) - m_sp *(w_sp/2 + w_b) + m_f*w_f/2 - m_b*w_b/2 + m_p*(0))/...
    (2 * m_sp + m_f + m_b + m_p);
z_cm = 0;
%% Inertia calcs
% X-dim
d_xf = w_f/2;
I_xf = (1/12)*m_f*(w_f^2 + b_f^2) ; % fuel tank
I_xf_cm = I_xf + m_f*(d_xf - y_cm)^2;
d_xb = w_b/2;
I_xb = (1/12)*m_b*(w_b^2 + b_b^2) ; % base tank
I_xb_cm = I_xb + m_b*(d_xb + y_cm)^2;
d_xsp = (w_b + 0.5*w_sp);
I_xsp = (1/12)*m_sp*(w_sp^2 + b_sp^2); % solar panel
I_xsp1_cm = I_xsp + m_sp*(d_xsp - y_cm)^2;
I_xsp2_cm = I_xsp + m_sp*(d_xsp + y_cm)^2;
I_xp = (1/12)*m_p*(w_p^2 + b_p^2); % payload
I_xp_cm = I_xp + m_p*(y_cm)^2;
% Total X-dim
I_x = I_xf + I_xb + 2*I_xsp + I_xp;
I_x_cm = I_xf_cm + I_xb_cm + I_xsp1_cm + I_xsp2_cm + I_xp_cm;
% Y-dim
d_yf = h_f/2;
I_yf = (1/12)*m_f*(b_f^2 + h_f^2);
I_yf_cm = I_yf + m_f*(d_yf - x_cm)^2;
d_yb = h_b/2;
I_yb = (1/12)*m_b*(b_b^2 + h_b^2);
I_yb_cm = I_yb + m_b*(d_yb - x_cm)^2;
d_ysp = h_sp/2;
I_ysp = (1/12)*m_sp*(b_sp^2 + h_sp^2);
I_ysp_cm = I_ysp + m_sp*(d_ysp - x_cm)^2; 
d_yp = (h_p/2) + h_b;
I_yp = (1/12)*m_p*(b_p^2 + h_p^2);
I_yp_cm = I_yp + m_p*(d_yp - x_cm)^2;
% Total Y-dim
I_y = I_yf + I_yb + 2*I_ysp + I_yp;
I_y_cm = I_yf_cm + I_yb_cm + 2*I_ysp_cm + I_yp_cm;
% Z-dim
d_zf = sqrt(((h_f/2)^2) + ((w_f/2)^2));
I_zf = (1/12)*m_f*(h_f^2 + w_f^2);
I_zf_cm = I_zf + m_f*((d_yf - x_cm)^2 + (d_xf - y_cm)^2);
d_zb = sqrt(((h_b/2)^2) + ((w_b/2)^2));
I_zb = (1/12)*m_b*(h_b^2 + w_b^2);
I_zb_cm = I_zb + m_b*((d_xb + y_cm)^2 + (d_yb - x_cm)^2);
d_zsp = sqrt((h_sp/2)^2 + ((w_sp+2*w_b)/2)^2);
I_zsp = (1/12)*m_sp*(h_sp^2 + w_sp^2);
I_zsp1_cm = I_zsp + m_sp*((d_xsp - y_cm)^2 + (d_ysp - x_cm)^2);
I_zsp2_cm = I_zsp + m_sp*((d_xsp + y_cm)^2 + (d_ysp - x_cm)^2);
d_zp = h_b + (h_p/2);
I_zp = (1/12)*m_p*(h_p^2 + w_p^2);
I_zp_cm = I_zp + m_p*((y_cm)^2 + (d_yp - x_cm)^2);
% Total Z-dim
I_z = I_zf + I_zb + 2*I_zsp + I_zp;
I_z_cm = I_zf_cm + I_zb_cm + I_zsp1_cm + I_zsp2_cm + I_zp_cm;
% Products of Inertia
I_xyf = 0;
I_xyf_cm = I_xyf + m_f*(x_cm - d_yf)*(y_cm - d_xf);
I_xyb = 0;
I_xyb_cm = I_xyb + m_b*(x_cm - d_yb)*(d_xb + y_cm);
I_xysp1 = 0;
I_xysp1_cm = I_xysp1 + m_sp*(x_cm - d_ysp)*(y_cm - d_xsp);
I_xysp2 = 0;
I_xysp2_cm = I_xysp2 + m_sp*(x_cm - d_ysp)*(d_xsp + y_cm);
I_xyp = 0; % equal to zero because it doesn't move in the y direction
I_xyp_cm = m_p*(x_cm - d_yp)*(y_cm);
I_xy = I_xyf + I_xyb + I_xysp1 + I_xysp2 + I_xyp; 
I_xy_cm = I_xyf_cm + I_xyb_cm + I_xysp1_cm + I_xysp2_cm + I_xyp_cm; 
I_yz = 0; % x-y plane symmetric
I_yz_cm = 0;
I_xz = 0; % x-y plane symmetric
I_xz_cm = 0;
I_yx = I_xy;
I_yx_cm = I_xy_cm;
I_zx = I_xz;
I_zx_cm = I_xz_cm;
I_zy = I_yz;
I_zy_cm = I_yz_cm;
I_yz = 0; % x-y plane symmetric
I_xz = 0; % x-y plane symmetric
% CM Inertia
I_cm_x = I_x - M*x_cm^2;
I_cm_y = I_y - M*y_cm^2;
I_cm_z = I_z - M*z_cm^2;
I_cm_xy = I_xy - M*x_cm*y_cm;
I_cm_xz = I_xz - M*x_cm*z_cm;
I_cm_yz = I_yz - M*y_cm*z_cm;
I_cm_yx = I_cm_xy;
I_cm_zx = I_cm_xz;
I_cm_zy = I_cm_yz;

%% Body Axes Inertia Tensor
I_b_cm = [I_x_cm,-I_xy_cm,-I_xz_cm;-I_yx_cm,I_y_cm,-I_yz_cm;-I_zx_cm,-I_zy_cm,I_z_cm];
%% Principal Axes Inertia Tensor
[R,I_p] = eig(I_b_cm); % R - eigenvectors/rotation matrix, D - eigenvalues/inertia tensor principal axes

R = [R(:,2) R(:,1) R(:,3)];
I_p = [I_p(2,2) 0 0; 0 I_p(1,1) 0; 0 0 I_p(3,3)];
sc.R = R;
sc.Ip = I_p;
sc.Ib_cm = I_b_cm;
sc.CM = [x_cm, y_cm, z_cm];
end
