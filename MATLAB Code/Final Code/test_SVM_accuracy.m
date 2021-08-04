function accuracy = test_SVM_accuracy(w, b, x, y)
    size = width(x);
    accuracy = [0;0;0;0];
    
    for i = 1:size
        if (transpose(x(:,i))*(w) + b) * y(i) >= 1
            accuracy(1) = accuracy(1) + 1;
        end
        if (transpose(x(:,i))*(w) + b) * y(i) > 0
            accuracy(2) = accuracy(2) + 1;
        end
        if (transpose(x(:,i))*(w) + b) * y(i) < 0
            accuracy(3) = accuracy(3) + 1;
        end
        if (transpose(x(:,i))*(w) + b) * y(i) <= -1
            accuracy(4) = accuracy(4) + 1;
        end
    end
    
    accuracy = accuracy / size;
    
end