function n_sum = ApEn2_internal(x,m,r)
    N = height(x);
    n_sum = 0;
    
    mean = zeros(N - m + 1, 1);
    for i = 1:N - m + 1
        mean(i) = sum(x(i:i + m - 1));
    end
    
    for i = 1:N - m + 1
        for j = 1:N - m + 1
            flag = 1;
            for k = 1:m
                if (x(i + k - 1) - x(j + k - 1) + mean(i) - mean(j))^2 > r^2
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