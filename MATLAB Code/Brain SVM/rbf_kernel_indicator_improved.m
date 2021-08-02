function I = rbf_kernel_indicator_improved(u,Ki,b,y,power)
    if 1 - y*(rbf_kernel_dp(u,Ki,power) + b) > 0
        I = 1;
    else
        I = 0;
    end
end