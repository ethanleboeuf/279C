function [A] = det_method(M, V)
%det_method Takes in M and V matrices and outputs attitude
%   Given M matrix of independent measurements in xyz and V matrix of modelled
%   directions in 123

n = size(M, 2);

A = zeros(3);
% Cases, n = 2, n = 3, n > 3
if n == 2
    
    % Real Method
    pm = M(:, 1);
    qm = cross(M(:,1), M(:,2))/norm(cross(M(:,1), M(:,2)));
    rm = cross(pm, qm);
    
    pv = V(:, 1);
    qv = cross(V(:,1), V(:,2))/norm(cross(V(:,1), V(:,2)));
    rv = cross(pv, qv);
    
    % Ficticious
%     m1 = (M(:,1) + M(:,2))/2;
%     m2 = (M(:,1) - M(:,2))/2;
%     pm = m1;
%     qm = cross(m1, m2)/norm(cross(m1, m2));
%     rm = cross(pm, qm);
%     
%     pv = V(:, 1);
%     qv = cross(V(:,1), V(:,2))/norm(cross(V(:,1), V(:,2)));
%     rv = cross(pv, qv);
    A = [pm qm rm] * inv([pv qv rv]);
    
elseif n == 3
    A = M * inv(V);
elseif n > 3
    A = (M*V')*inv(V*V');
else
    A = zeros(3);
end

end

