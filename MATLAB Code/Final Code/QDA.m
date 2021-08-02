function out = QDA(x, y)
%M is overall mean
%m are class specific means
%S is scatter matrix
%P is probability of class occuring

    dim = height(x);
    size = width(x);
    pos_occurances = (sum(y) + size)/2;
    neg_occurances = size - pos_occurances;
    P(1) = pos_occurances/size;
    P(2) = neg_occurances/size;
    
    m = zeros(dim, 2);
    for i = 1:size
        if y(i) == 1
            m(:,1) = m(:,1) + x(:,i);
        end
        if y(i) == -1
            m(:,2) = m(:,2) + x(:,i);
        end
    end
    m(:,1) = m(:,1) / pos_occurances;
    m(:,2) = m(:,2) / neg_occurances;
    
    S = zeros(dim, dim, 2);
    for i = 1:size
        if y(i) == 1
            class = 1;
            S(:,:,1) = S(:,:,1) + (m(:,class) - x(:,i))*transpose(m(:,class) - x(:,i));
        end
        if y(i) == -1
            class = 2;
            S(:,:,2) = S(:,:,2) + (m(:,class) - x(:,i))*transpose(m(:,class) - x(:,i));
        end
    end
    S(:,:,1) = S(:,:,1) / pos_occurances;
    S(:,:,2) = S(:,:,2) / neg_occurances;
    
    out.m = m;
    out.S = S;
    out.P = P;
end