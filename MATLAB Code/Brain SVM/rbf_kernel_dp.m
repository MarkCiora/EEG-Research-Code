function output = rbf_kernel_dp(col_vec1, col_vec2, gamma)
% Gamma > 0
output = zeros(width(col_vec1), 1);
for i = 1:width(col_vec1)
    output(width(col_vec1)) = exp(-gamma * transpose(col_vec2 - col_vec1(i,:)) * (col_vec2 - col_vec1(i,:));
end
end