function [C_block] = C_block_vect(q, v_eci)
% For state of [q; w]
q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);

vx = v_eci(1);
vy = v_eci(2);
vz = v_eci(3);

C11 = 2 * q1 * vx + 2 * q2 * vy + 2 * q3 * vz;
C12 = -2 * q2 * vx + 2 * q1 * vy + 2 *q3 * vz;
C13 = -2 * q3 * vx + 2 * q4 * vy + 2 *q1 * vz;
C14 = 2 * q4 * vx + 2 * q3 * vy - 2 *q2 * vz;
Cend = zeros(1, 3);

C21 = 2 * q2 * vx - 2 * q1 * vy + 2 * q4 * vz;
C22 = 2 * q1 * vx + 2 * q2 * vy + 2 * q3 * vz;
C23 = -2 * q4 * vx - 2 * q3 * vy + 2 * q2 * vz;
C24 = -2 * q3 * vx + 2 * q4 * vy + 2 * q1 * vz;
Cend = zeros(1, 3);

C31 = 2 * q3 * vx - 2 * q4 * vy - 2 * q1 * vz;
C32 = 2 * q4 * vx + 2 * q3 * vy - 2 * q2 * vz;
C33 = 2 * q1 * vx + 2 * q2 * vy + 2 * q3 * vz;
C34 = 2 * q2 * vx - 2 * q1 * vy + 2 * q4 * vz;
Cend = zeros(1, 3);

C_block = [C11 C12 C13 C14 Cend;...
            C21 C22 C23 C24 Cend;...
            C31 C32 C33 C34 Cend];

end

