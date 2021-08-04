function [w, b] = subgradient_descent(x, y, c, b)
% margin = 2/|w|
% offset = b/|w|


    dim = height(x);
    size = width(x);
    step_ratio = 1/c;
    w = zeros(dim, 1);
    grad_w = zeros(dim, 1);
    
        
    for loopy = 1:100
        grad_w = w;
        for i = 1:size
            grad_w =    grad_w - (c/size)*(y(i)*x(:,i)*...
                        linear_indicator(w,x(:,i),b,y(i)));
        end
        w = w - grad_w*step_ratio;
    end
        
end