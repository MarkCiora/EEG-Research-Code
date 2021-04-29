function y = my_butter(wp1, wp2, fs, x) 
%     % prewarping the cutoff frequencies
%     T = 1/fs;
%     wp1 = (2/T)*tan(wp1*T/2);
%     wp2 = (2/T)*tan(wp2*T/2);
%     
%     n = 2; % second order
%     A = 10*sqrt(10); % minimum attenuation of 30dB
%     
%     % finding outer cutoff freqencies
%     ws2 = wp2*10^(log(A)/n); % rearrange order equation
%     ws1 = wp1*wp2/ws2; % to make it symmetrical in log domain
%     
%     % bandwidth variable
%     BW = wp2-wp1;
    
    %--------------------------------------------------------
    
    % skip to end for now
    N = 1;
    norm = 1/(fs/2);
    [b,a] = butter(N, [1*norm 4*norm], 'bandpass');
    
    l = length(x);
    y = zeros(l,1);
    
    for k = 3:l
        y(k) = b(1)*x(k) + b(2)*x(k-1) + b(3)*x(k-2) - a(2)*y(k-1) - a(3)*y(k-2);
    end
end