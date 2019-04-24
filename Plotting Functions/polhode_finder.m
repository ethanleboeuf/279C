function [fig] = polhode_finder(I, w, x_ke, x_L, y_ke, y_L)

Lvec = I * w;
L = norm(Lvec);
TwoT = dot(w, Lvec);

syms x y z
eqn = (I(1,1) - L^2/TwoT)*I(1,1)*x^2 + ...
    (I(2,2) - L^2/TwoT)*I(2,2)*y^2 + ...
    (I(3,3) - L^2/TwoT)*I(3,3)*z^2 == 0;

pol = solve(eqn,z);
fig = figure();
f(x,y) = pol(1);
g(x,y) = pol(2);

x_lo1 = min(x_ke(:));
x_lo2 = min(x_L(:));
x_lo = min([x_lo1, x_lo2]);

x_hi1 = max(x_ke(:));
x_hi2 = max(x_L(:));
x_hi = max([x_hi1, x_hi2]);

y_lo1 = min(y_ke(:));
y_lo2 = min(y_L(:));
y_lo = min([y_lo1, y_lo2]);

y_hi1 = max(y_ke(:));
y_hi2 = max(y_L(:));
y_hi = max([y_hi1, y_hi2]);

coordmax = max([y_hi,x_hi]);
coordmin = min([y_lo,x_lo]);

fsurf(f, [coordmin, coordmax], 'FaceColor' ,'none')
hold on
fsurf(g, [coordmin, coordmax], 'FaceColor' , 'none')
hold off
end

