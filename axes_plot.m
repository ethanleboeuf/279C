function axes_plot(A, sc)

n = size(A,3);
prin_x = zeros(3, n);
prin_y = zeros(3, n);
prin_z = zeros(3, n);

body_x = zeros(3, n);
body_y = zeros(3, n);
body_z = zeros(3, n);
for ii = 1:n
   
    prin_x(:, ii) = A(1, :, ii)';
    prin_y(:, ii) = A(2, :, ii)';
    prin_z(:, ii) = A(3, :, ii)';
    
    body_x(:, ii) = sc.R' * prin_x(:, ii);
    body_y(:, ii) = sc.R' * prin_y(:, ii);
    body_z(:, ii) = sc.R' * prin_z(:, ii);
end
specific_triad_plot(prin_x, prin_y , prin_z, 'Principal')
specific_triad_plot(body_x, body_y , body_z, 'Body')


end

