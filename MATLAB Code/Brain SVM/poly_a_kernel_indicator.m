function I = poly_a_kernel_indicator(w,x,b,y,power)
    if 1 - y*(poly_a_kernel_dp(w,x,power) + b) > 0
        I = 1;
    else
        I = 0;
    end
end