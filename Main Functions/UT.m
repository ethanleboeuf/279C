function [x_ut, w] = UT(mu, sigma, lambda)

if nargin < 3
    lambda = 2;
end
n = length(mu);
x_ut = zeros(3, 2*n+1);
w = zeros(2*n+1, 1);
sighalf = chol((lambda+n)*(sigma));
for ii = 1:2*n+1
    
    if ii == 1
        x_ut(:, ii) = mu;
        w(ii) = lambda / (lambda + n);
    elseif ii > 1 && ii <= n + 1
        x_ut(:, ii) = mu + sighalf(:, ii-1);
        w(ii) = 1 / (2*(lambda + n));
    elseif ii > n+1
        x_ut(:, ii) = mu - sighalf(:, ii - n-1);
        w(ii) = 1 / (2*(lambda + n));
    end
end

