function output = ApEn(u, m, r, splits)
%assuming splits = 10 and data is size 300 currently
    N = height(u);
    output = zeros(splits,1);
    
    for i = 1:splits
        output(i) = log(ApEn_internal(u(1+(i-1)*30:(i)*30),m,r)/ ...
            ApEn_internal(u(1+(i-1)*30:(i)*30),m+1,r));
        
    end

end