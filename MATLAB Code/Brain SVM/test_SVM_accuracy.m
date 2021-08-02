function accuracy = test_SVM_accuracy(w, b, x, y, type, pow_gam)
    size = width(x);
    dim = height(x);
    accuracy = [0;0;0;0];
    
    for i = 1:size
        switch type
            case 'poly_a'
                if (poly_a_kernel_dp(x(:,i),w,pow_gam) + b) * y(i) >= 1
                    accuracy(1) = accuracy(1) + 1;
                end
                if (poly_a_kernel_dp(x(:,i),w,pow_gam) + b) * y(i) > 0
                    accuracy(2) = accuracy(2) + 1;
                end
                if (poly_a_kernel_dp(x(:,i),w,pow_gam) + b) * y(i) < 0
                    accuracy(3) = accuracy(3) + 1;
                end
                if (poly_a_kernel_dp(x(:,i),w,pow_gam) + b) * y(i) <= -1
                    accuracy(4) = accuracy(4) + 1;
                end
            case 'poly_b'
                if (poly_b_kernel_dp(x(:,i),w,pow_gam) + b) * y(i) >= 1
                    accuracy(1) = accuracy(1) + 1;
                end
                if (poly_b_kernel_dp(x(:,i),w,pow_gam) + b) * y(i) > 0
                    accuracy(2) = accuracy(2) + 1;
                end
                if (poly_b_kernel_dp(x(:,i),w,pow_gam) + b) * y(i) < 0
                    accuracy(3) = accuracy(3) + 1;
                end
                if (poly_b_kernel_dp(x(:,i),w,pow_gam) + b) * y(i) <= -1
                    accuracy(4) = accuracy(4) + 1;
                end
            case 'rbf'
                if (rbf_kernel_dp(x(:,i),w,pow_gam) + b) * y(i) >= 1
                    accuracy(1) = accuracy(1) + 1;
                end
                if (rbf_kernel_dp(x(:,i),w,pow_gam) + b) * y(i) > 0
                    accuracy(2) = accuracy(2) + 1;
                end
                if (rbf_kernel_dp(x(:,i),w,pow_gam) + b) * y(i) < 0
                    accuracy(3) = accuracy(3) + 1;
                end
                if (rbf_kernel_dp(x(:,i),w,pow_gam) + b) * y(i) <= -1
                    accuracy(4) = accuracy(4) + 1;
                end
        end
        
    end
    
    accuracy = accuracy / size;
    
end