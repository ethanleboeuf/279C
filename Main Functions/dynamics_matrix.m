function [At] = dynamics_matrix(dt, q, I, w)

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);

Ix = I(1);
Iy = I(2);
Iz = I(3);

wx = w(1);
wy = w(2);
wz = w(3);

A11 = 1; A21 = (dt/2)*wz; A31 = -(dt/2)*wy; A41 = (dt/2)*wx;
A51 = (dt/2)*q4; A61 = -(dt/2)*q3; A71 = (dt/2)*q2; A12 = -(dt/2)*wz;
A22 = 1; A32 = (dt/2)*wx; A42 = (dt/2)*wy; A52 = (dt/2)*q3; A62 = (dt/2)*q1;
A72 = -(dt/2)*q1; A13 = (dt/2)*wy; A23 = -(dt/2)*wx; A33 = 1;
A43 = (dt/2)*wz; A53 = -(dt/2)*q2; A63 = (dt/2)*q1; A73 = (dt/2)*q4;
A14 = -(dt/2)*wx; A24 = -(dt/2)*wy; A34 = -(dt/2)*wz; A44 = 1; 
A54 = -(dt/2)*q1; A64 = -(dt/2)*q4; A74 = -(dt/2)*q3; A15 = 0; A25 = 0;
A35 = 0; A45 = 0; A55 = 1; A65 = -(dt*wz*(Iz - Iy))/Ix; 
A75 = -(dt*wy*(Iz - Iy))/Ix; A16 = 0; A26 = 0; A36 = 0; A46 = 0; 
A56 = -(dt*wz*(Ix - Iz))/Iy; A66 = 1; A76 = -(dt*wx*(Ix - Iz))/Iy; A17 = 0;
A27 = 0; A37 = 0; A47 = 0; A57 = -(dt*wy*(Iy - Ix))/Iz; 
A67 = -(dt*wx*(Iy - Ix))/Iz; A77 = 1;

At = [A11 A21 A31 A41 A51 A61 A71;...
    A12 A22 A32 A42 A52 A62 A72;...
    A13 A23 A33 A43 A53 A63 A73;...
    A14 A24 A34 A44 A54 A64 A74;...
    A15 A25 A35 A45 A55 A65 A75;...
    A16 A26 A36 A46 A56 A66 A76;...
    A17 A27 A37 A47 A57 A67 A77];

end

