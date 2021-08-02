function I = rbf_kernel_indicator(w,x,b,y,gamma)
    if 1 - y*(rbf_kernel_dp(w,x,gamma) + b) > 0
        I = 1;
    else
        I = 0;
    end
end