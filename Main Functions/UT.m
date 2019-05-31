function [x_ut, w] = UT(mu, sigma, lambda)

if nargin < 3
    lambda = 2;
end
n = length(mu);

w = zeros(2*n+1, 1);
mu = reshape(mu, n, 1);
m = real(sqrtm((n+lambda) * sigma));
X = mu * ones(1, n);
x_ut = [mu, X + m, X - m];
w(1) = lambda / (lambda + n);
w(2: end) = 1 / (2 * (n + lambda));
end

