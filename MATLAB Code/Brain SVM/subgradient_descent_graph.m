function [w, b] = subgradient_descent_graph(x, y, c, type, pow_gam, b, A, subject)
% margin = 2/|w|
% offset = b/|w|


    dim = height(x);
    size = width(x);
    step_ratio = 1/c;
    w = zeros(dim, 1);
    b = 0.01;
    grad_w = zeros(dim, 1);
    grad_b = 0;
    accuracy = [0;0;0;0];
    
    j=subject;
    %figure(1)
    %close(1)
    %figure(1)
    %scatter(A(j).s_o2(1,1:500,1),A(j).s_o2(1,1:500,4));
    %hold on
    %scatter(A(j).d_o2(1,1:500,1),A(j).d_o2(1,1:500,4));
    %plot([.5 .5], [.51 .51])
    
    for asdfasdf = 1:10
        
        for loopy = 1:100
            grad_w = w;
            for i = 1:size
                switch type
                    case 'poly_a'
                        grad_w = grad_w - (c/size)*(y(i)*x(:,i)*poly_a_kernel_indicator(w,x(:,i),b,y(i),pow_gam));

                    case 'poly_b'
                        grad_w = grad_w - (c/size)*(y(i)*x(:,i)*poly_b_kernel_indicator(w,x(:,i),b,y(i),pow_gam));

                    case 'rbf'
                        grad_w = grad_w - (c/size)*(y(i)*x(:,i)*rbf_kernel_indicator(w,x(:,i),b,y(i),pow_gam));

                end
            end
            w = w - grad_w*step_ratio;
        end
        
        
        prev = accuracy;
        accuracy = test_SVM_accuracy(w, b, x, y, type, pow_gam)
        step_ratio = step_ratio*.96;
        
%         if transpose(prev - accuracy)*(prev - accuracy) < .00001^2
%            if accuracy(2) - accuracy(1) < .50
%                if accuracy(2) - accuracy(1) > .02
%                     break
%                end
%            end
%         end
        
    end
    %children = get(gca, 'children');
    %delete(children(1));
    plot([0 0.9], [b/w(2) -0.9*w(1)/w(2)-b/w(2)])
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