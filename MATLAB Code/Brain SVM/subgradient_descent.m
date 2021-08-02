function [w, b] = subgradient_descent(x, y, c, type, pow_gam)
% margin = 2/|w|
% offset = b/|w|


    dim = height(x);
    size = width(x);
    step_ratio = .01/c;
    w = zeros(dim, 1);
    b = 0;
    grad_w = zeros(dim, 1);
    grad_b = 0;
    accuracy = [0;0;0;0];
    
    while 1 == 1
        for loopy = 1:10
            grad_w = w;
            grad_b = 0;

            for i = 1:size
                switch type
                    case 'poly_a'
                        grad_w = grad_w - (c/size)*(y(i)*x(:,i)*poly_a_kernel_indicator(w,x(:,i),b,y(i),pow_gam));
                        grad_b = grad_b - (c/size)*(y(i)*poly_a_kernel_indicator(w,x(:,i),b,y(i),pow_gam));

                    case 'poly_b'
                        grad_w = grad_w - (c/size)*(y(i)*x(:,i)*poly_b_kernel_indicator(w,x(:,i),b,y(i),pow_gam));
                        grad_b = grad_b - (c/size)*(y(i)*poly_b_kernel_indicator(w,x(:,i),b,y(i),pow_gam));

                    case 'rbf'
                        grad_w = grad_w - (c/size)*(y(i)*x(:,i)*rbf_kernel_indicator(w,x(:,i),b,y(i),pow_gam));
                        grad_b = grad_b - (c/size)*(y(i)*rbf_kernel_indicator(w,x(:,i),b,y(i),pow_gam));

                end
            end
            w = w - grad_w*step_ratio;

        end
        
        b = b - grad_b*step_ratio;
        
        prev = accuracy;
        accuracy = test_SVM_accuracy(w, b, x, y, type, pow_gam)
        if transpose(prev - accuracy )*(prev - accuracy) < .005^2 / 2
            break
        end
        
    end
end

%     grad_w = w;
%     grad_b = 0;
%     for i = 1:size
%         grad_w = grad_w - (c/size)*(y(i)*x(i)*SVM_indicator(w,x(i),b,y(i)));
%         grad_b = grad_b - (c/size)*(y(i)*SVM_indicator(w,x(i),b,y(i)));
%     end
%     w = w - grad_w*step_ratio;
%     b = b - grad_b*step_ratio;
%     j = j + 1;
%     if j > 1000000
%         break
%     end