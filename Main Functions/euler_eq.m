function [state_dot] = euler_eq(state)
% state = [w; I]

state_dot = zeros(length(state), 1);
state_dot(1) = -state(2)*state(3) * (state(6) - state(5))/state(4);
state_dot(2) = -state(1)*state(3) * (state(4) - state(6))/state(5);
state_dot(3) = -state(1)*state(2) * (state(5) - state(4))/state(6);

end

