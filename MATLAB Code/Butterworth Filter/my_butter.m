function y = my_butter(low, high, fs, x)
    %% Explanation of the inputs:
    
    % low is the lower cutoff frequency
    % high is the upper cutoff frequency
    % low and high are both in Hz and must be normalized with fs and low
    % must be less than high for the output to make sense.
    
    % fs is the nyquist frequency or highest frequency that can be read.
    % If high > fs then the function will not work properly.
    
    % x is the signal
    

    %% Some variable definitions
    
    % wL is the cutoff for the lowpass filter, or the higher cutoff of the band
    % wH is the cutoff for the highpass filter, or the lower cutoff of the band
    % These two values are normalized to the nyquist frequency
    wL = high*pi/fs;
    wH = low*pi/fs;
    
    % w0 is the average of the two cutoff frequencies. It is the target
    % frequency for prewarping.
    % B is the prewarping factor
    w0 = (wL + wH)/2;
    B = w0 / tan(w0/2);
    
    % A is a common factor that makes the formula look nicer when used
    A = wL*wH;

    
    %% Implementation of the filter with a difference equation
    
    % Corresponding difference equation:
    % Derivation on paper
    % y[n]*b(1) = x[n]*a(1) + x[n-1]*a(2) + x[n-2]*a(3) - y[n-1]*b(2) - y[n-2]*b(3)
    a(1) = B/wH;
    a(2) = 0;
    a(3) = -B/wH;
    b(1) = 1 + 2*B*w0/A + B*B/A;
    b(2) = 2 - 2*B*B/A;
    b(3) = 1 - 2*B*w0/A + B*B/A;

    % Initialize the output vector and define length
    L = length(x);
    y = zeros(L,1);
    
    % Assign initial conditions
    y(1) = 0;
    y(2) = 0;

    for k = 3:L
            y(k) = (a(1)*x(k) + a(3)*x(k-2) - b(2)*y(k-1) - b(3)*y(k-2))/b(1);
    end
end
