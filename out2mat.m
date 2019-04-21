function [A] = out2mat(data)
A = zeros(3, 3, size(data,1));
for ii = 1:size(data,1)
    A(:, :, ii) = reshape(data(ii, 1:9), [3,3]);
end

end

