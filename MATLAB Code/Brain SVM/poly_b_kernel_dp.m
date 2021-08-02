function output = poly_b_kernel_dp(col_vec1, col_vec2, power)
% Power is an integer greater than 1
    output = (transpose(col_vec1)*col_vec2 + 1) ^ power;
end