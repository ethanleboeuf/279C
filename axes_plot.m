function axes_plot(A, sc)

n = size(A,3);
prin_x = zeros(3, n);
prin_y = zeros(3, n);
prin_z = zeros(3, n);

body_x = zeros(3, n);
body_y = zeros(3, n);
body_z = zeros(3, n);
for ii = 1:n
    prin_x(:, ii) = [A(1,1,ii); A(2,1,ii); A(3,1,ii)];
    prin_y(:, ii) = [A(1,2,ii); A(2,2,ii); A(3,2,ii)];
    prin_z(:, ii) = [A(1,3,ii); A(2,3,ii); A(3,3,ii)];
    
    body_x(:, ii) = sc.R' * prin_x(:, ii);
    body_y(:, ii) = sc.R' * prin_y(:, ii);
    body_z(:, ii) = sc.R' * prin_z(:, ii);
end

specific_axis_plot(prin_x, 'x')
specific_axis_plot(prin_y, 'y')
specific_axis_plot(prin_z, 'z')

specific_axis_plot(body_x, 'bx')
specific_axis_plot(body_y, 'by')
specific_axis_plot(body_z, 'bz')
% specific_axis_plot(prin_x, 'x')
% hold on
% specific_axis_plot(body_x, 'bx')
% hold off

end

