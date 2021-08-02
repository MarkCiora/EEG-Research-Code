function output = ApEn(u, m, r, splits)
%assuming splits = 10 and data is size 300 currently
    N = height(u);
    output = zeros(splits,1);
    
    for i = 1:splits
        output(i) = log(ApEn_internal(u(1+(i-1)*30:(i)*30),m,r)/ ...
            ApEn_internal(u(1+(i-1)*30:(i)*30),m+1,r));
        
    end
    
%     for loop = 1:2
%         if loop == 2
%             m = m + 1;
%         end
%         
%         n = zeros(N - m + 1, 1);
%         
%         for i = 1:N - m + 1
%             for j = 1:N - m + 1
%                 doit = 1;
%                 for k = 1:m
%                     if (u(i + k - 1) - u(j + k - 1))^2 > r^2
%                         doit = 0;
%                         break
%                     end
%                 end
%                 if doit == 1
%                     n(i) = n(i) + 1;
%                 end
%             end
%         end
%         av(loop) = sum(n) / (N - m + 1);
%     end
    
    %output = log(av(1) / av(2));
end