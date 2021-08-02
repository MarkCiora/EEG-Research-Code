function n_sum = ApEn_internal(x,m,r)
    N = height(x);
    n_sum = 0;
    for i = 1:N - m + 1
        for j = 1:N - m + 1
            flag = 1;
            for k = 1:m
                if (x(i + k - 1) - x(j + k - 1))^2 > r^2
                    flag = 0;
                    break
                end
            end
            if flag == 1
                n_sum = n_sum + 1;
            end
        end
    end
   n_sum = n_sum / ((N - m + 1)^2);
end