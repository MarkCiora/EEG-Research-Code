function accuracy = test_SVM_accuracy_2(u, b, x, x_t, y, pow, type)
    size = width(x);
    dim = height(x);
    accuracy = [0;0;0;0];
    
    for i = 1:size
        switch type
            case 'poly_a'
                if (transpose(poly_a_kernel_dp(x_t,x(:,i),pow))*u + b) * y(i) >= 1
                    accuracy(1) = accuracy(1) + 1;
                end
                if (transpose(poly_a_kernel_dp(x_t,x(:,i),pow))*u + b) * y(i) > 0
                    accuracy(2) = accuracy(2) + 1;
                end
                if (transpose(poly_a_kernel_dp(x_t,x(:,i),pow))*u + b) * y(i) < 0
                    accuracy(3) = accuracy(3) + 1;
                end
                if (transpose(poly_a_kernel_dp(x_t,x(:,i),pow))*u + b) * y(i) <= -1
                    accuracy(4) = accuracy(4) + 1;
                end
            case 'rbf'
                if (transpose(diag(rbf_kernel_dp(x_t,x(:,i),pow)))*u + b) * y(i) >= 1
                    accuracy(1) = accuracy(1) + 1;
                end
                if (transpose(diag(rbf_kernel_dp(x_t,x(:,i),pow)))*u + b) * y(i) > 0
                    accuracy(2) = accuracy(2) + 1;
                end
                if (transpose(diag(rbf_kernel_dp(x_t,x(:,i),pow)))*u + b) * y(i) < 0
                    accuracy(3) = accuracy(3) + 1;
                end
                if (transpose(diag(rbf_kernel_dp(x_t,x(:,i),pow)))*u + b) * y(i) <= -1
                    accuracy(4) = accuracy(4) + 1;
                end
        end
    end
    
    accuracy = accuracy / size;
    
end