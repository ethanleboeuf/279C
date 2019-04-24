function axes_plot_RTN(RTN, R)

n = size(R,3);
R_IJK = zeros(3, n);
T_IJK = zeros(3, n);
N_IJK = zeros(3, n);

for ii = 1:n

    R_IJK(:, ii) = R(:,:,ii)' * RTN(:, 1, ii);
    T_IJK(:, ii) = R(:,:,ii)' * RTN(:, 2, ii);
    N_IJK(:, ii) = R(:,:,ii)' * RTN(:, 3, ii);
end
specific_triad_plot(R_IJK, T_IJK , N_IJK, 'RTN')


end

