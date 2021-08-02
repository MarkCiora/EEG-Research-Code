function output = ApEn2(u, m, r, splits)
%assuming splits = 10 and data is size 300 currently
    N = height(u);
    output = zeros(splits,1);
    
    for i = 1:splits
        output(i) = ApEn2_internal(u(1+(i-1)*30:(i)*30),m,r);
        
    end

end