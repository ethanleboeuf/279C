function [q] = quat_corr(q)

for ii = 1:size(q, 1)
    if q(ii, 4) < 0
        q(ii, 1:4) = q(ii, 1:4) * -1;
    end
end
end

