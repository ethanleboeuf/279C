function [fig] = plane2vec(vec, fig, init_point)
    figure(fig)
    syms x y z
    eqn = vec(1) * (x - init_point(1)) + vec(2) * (y - init_point(2)) ...
        + vec(3) * (z - init_point(3)) == 0;
    plane = solve(eqn,z);
    
    fsurf(plane, [-.5 .5],'FaceColor' ,'none')
end

