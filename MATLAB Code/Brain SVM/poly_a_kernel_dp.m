function output = poly_a_kernel_dp(col_vec1, col_vec2, power)
% Power is an integer greater than or equal to 1
    output = (transpose(col_vec1)*col_vec2) .^ power;
end