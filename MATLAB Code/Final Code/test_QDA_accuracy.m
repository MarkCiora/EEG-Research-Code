function QDA_acc = test_QDA_accuracy(in, x, y)
    m = in.m;
    P = in.P;
    S = in.S;
    S_inv = 1/S;
    
    dim = height(x);
    size = width(x);
    
    correct = 0;
    y_guess = y;
    for i = 1:size
        for k = 1:2
            TEMP = transpose(x(:,i))*S_inv(:,:,k)*x(:,i);
            TEMP = TEMP - 2*transpose(x(:,i))*S_inv(:,:,k)*m(:,k);
            TEMP = TEMP + transpose(m(:,k))*S_inv(:,:,k)*m(:,k);
            g(k) = -(1/2)*log(abs(det(S(:,:,k)))) - (1/2)*(TEMP) + log(P(k));
        end
        
        if g(1) > g(2)
            y_guess(i) = 1;
        else
            y_guess(i) = -1;
        end
        
        if y_guess(i) == y(i)
            correct = correct + 1;
        end
    end
    
    QDA_acc = correct/size;
    
end