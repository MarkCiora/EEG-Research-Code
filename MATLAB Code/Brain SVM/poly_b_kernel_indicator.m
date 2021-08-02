function I = poly_b_kernel_indicator(w,x,b,y,power)
    if 1 - y*(poly_b_kernel_dp(w,x,power) + b) > 0
        I = 1;
    else
        I = 0;
    end
end