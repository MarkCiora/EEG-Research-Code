function [u K] = subgradient_descent_improved(x, y, c, type, pow, b, test_x, test_y)
% margin = 2/|w|
% offset = b/|w|


    dim = height(x);
    size = width(x);
    step_ratio = 1/c;
    u = zeros(size, 1);
    grad_u = u;
    %w = zeros(dim, 1);
    %grad_w = zeros(dim, 1);
    %grad_b = 0;
    accuracy = [0;0;0;0];
    pos_occurances = (sum(y) + size)/2;
    neg_occurances = size - pos_occurances;
    
    K = zeros(size, size);
    for i = 1:size
        for j = 1:size
            switch type
                case 'poly_a'
                    K(i,j) = poly_a_kernel_dp(x(:,i),x(:,j),pow);
                case 'rbf'
                    K(i,j) = rbf_kernel_dp(x(:,i),x(:,j),pow);
            end
        end    
    end
    
    
    for asdfasdf = 1:35
        for loopy = 1:25
            
            grad_u = zeros(size, 1);
            for i = 1:size
                for j = 1:size
                    grad_u(i) = grad_u(i) + u(j)*K(j,i);
                end
            end
            
            for i = 1:size
                switch type
                    case 'poly_a'
                        if y(i) == 1
                            grad_u = grad_u - (neg_occurances/size)*(c/size)*(y(i)*K(:,i)*poly_a_kernel_indicator_improved(u,K(:,i),b,y,pow));
                        end
                        if y(i) == -1
                            grad_u = grad_u - (pos_occurances/size)*(c/size)*(y(i)*K(:,i)*poly_a_kernel_indicator_improved(u,K(:,i),b,y,pow));
                        end
                    case 'rbf'
                        if y(i) == 1
                            grad_u = grad_u - (neg_occurances/size)*(c/size)*(y(i)*K(:,i)*rbf_kernel_indicator_improved(u,K(:,i),b,y,pow));
                        end
                        if y(i) == -1
                            grad_u = grad_u - (pos_occurances/size)*(c/size)*(y(i)*K(:,i)*rbf_kernel_indicator_improved(u,K(:,i),b,y,pow));
                        end
                end
            end
            
            u = u - grad_u*step_ratio;
        end
        %test = 1
        
        %prev = accuracy;
        %accuracy = test_SVM_accuracy_2(u, b, test_x, x, test_y, pow, type)
        step_ratio = step_ratio*.96;
        
%         if transpose(prev - accuracy)*(prev - accuracy) < .00001^2
%            if accuracy(2) - accuracy(1) < .50
%                if accuracy(2) - accuracy(1) > .02
%                     break
%                end
%            end
%         end
        
    end
end