function [state_dot] = euler_eq(state, M_ext)
% state = [w; I]

state_dot = zeros(length(state), 1);
state_dot(1) = -state(2)*state(3) * (state(6) - state(5))/state(4)...
    + M_ext(1)/state(4);
state_dot(2) = -state(1)*state(3) * (state(4) - state(6))/state(5)...
    + M_ext(2)/state(5);
state_dot(3) = -state(1)*state(2) * (state(5) - state(4))/state(6)...
    + M_ext(3)/state(6);

end

