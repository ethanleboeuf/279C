%% Plotting Results from Sim
close all
n = length(t);
R = zeros(3, n);
T = zeros(3, n);
N = zeros(3, n);

R(:, :) = RTN_out(:, 1, :);
T(:, :) = RTN_out(:, 2, :);
N(:, :) = RTN_out(:, 3, :);
specific_triad_plot(R, T , N, 'RTN')

[A] = out2mat(dcm_out(:, 1:9));
axes_plot(A, sc)

figure()
scatter3(Inert_pos_out(1:10:end,1), Inert_pos_out(1:10:end,2), Inert_pos_out(1:10:end,3), '.', 'b')
hold on 
scatter3(Inert_pos_out(1:10:end,4), Inert_pos_out(1:10:end,5), Inert_pos_out(1:10:end,6), '.', 'r')
scatter3(Inert_pos_out(1:10:end,7), Inert_pos_out(1:10:end,8), Inert_pos_out(1:10:end,9), '.', 'g')
xlabel('I')
ylabel('J')
zlabel('K')
hold off