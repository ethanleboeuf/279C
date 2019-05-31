function [mu, sigma] = UT_inv(x_ut, w)
n = length(w);
mu = zeros(size(x_ut, 1), 1);
sigma = zeros(size(x_ut, 1));

for ii = 1:n
    mu = mu + w(ii) * x_ut(:, ii); 
end
for ii = 1:n
    sigma = sigma + w(ii) * (x_ut(:, ii) - mu)*(x_ut(:, ii) - mu)';
end
end

