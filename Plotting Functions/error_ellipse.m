function [z] = error_ellipse(mu, sigma, P)

 
alpha = -2 * log(1 - P);
alpha2 = sqrt(abs(-2 * log((1-P) * sqrt(det(sigma)))));
[V, D] = eig(sigma * alpha);
t = linspace(0, 2*pi);

a = (V * sqrt(D)) * [cos(t(:))'; sin(t(:))'];
z = a + mu * ones(1, length(t));

w = [alpha2 * cos(t); alpha2 * sin(t)];
xcheck = sqrtm(sigma) * w + mu * ones(1, length(t));

end


