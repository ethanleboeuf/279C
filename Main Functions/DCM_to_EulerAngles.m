function [theta, phi, psi] = DCM_to_EulerAngles(DCM)
% DCM to 313 Rotation matrix
n = size(DCM, 3);
theta = zeros(n, 1);
phi = zeros(n, 1);
psi = zeros(n, 1);
for ii = 1:3
    for jj = 1:3
        if DCM(ii, jj) > 1
            DCM(ii, jj) = floor(DCM(ii,jj));
        end
    end
end
for ii = 1:n
    theta(ii) = real(acosd(DCM(3,3,ii)));
    phi(ii) = -atan2d(DCM(3,1,ii),DCM(3,2,ii));
    psi(ii) = atan2d(DCM(1,3,ii),DCM(2,3,ii));
end

