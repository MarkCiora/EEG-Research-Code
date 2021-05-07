clear;
clc;

x = -20000:20000;
y = 4*(x/10000).^2 - (x/10000).^4;% just some funky looking graph


subplot(311)
plot(x,y);
subplot(312)

subplot(313)


%% fifth order
x=0:0.001:2
H=1./sqrt(1+x.^-10)
figure(5)
subplot(211)
plot(x,H)
subplot(212)

%% 2nd order -pi to pi frequency response lowpass

figure(1);

%lowpass
T = 1000;
w0 = 7*pi/10/T;

a = cot(w0*T/2)^2;
b = cot(w0*T/2)*sqrt(2);

w = -pi+1e-6:pi/1000:pi+1e-6;
j=sqrt(-1);
z=exp(j*w);

H_num = z.^(-2) + 2*z.^(-1) + 1;
H_denom = z.^(-2) * (a-b+1) + z.^(-1) * (2-2*a) + (a+b+1);
H1 = (H_num./H_denom);

y=zeros(1,2001);
y(1001+round(w0*T*1000/pi)) = 1;
y(1001-round(w0*T*1000/pi)) = 1;


%highpass
T = 1000;
w0 = 5*pi/10/T;

w0 = pi/T-w0;
a = cot(w0*T/2)^2;
b = cot(w0*T/2)*sqrt(2);

w = -pi+1e-6:pi/1000:pi+1e-6;
j=sqrt(-1);
z=exp(j*w);

H_num = z.^(-2) + 2*z.^(-1) + 1;
H_denom = z.^(-2) * (a-b+1) + z.^(-1) * (2-2*a) + (a+b+1);
H2 = (H_num./H_denom);
H2 = fftshift(H2);
w0 = pi/T-w0;
y(1001+round(w0*T*1000/pi)) = 1;
y(1001-round(w0*T*1000/pi)) = 1;


%plot
figure(1);
hold on;
%plot(w,abs(H1));
%plot(w,abs(H2));
plot(w,H1 + H2 - 1);
%plot(w,abs(H1.*H2))
plot(w,y);
hold off;

%% Bandpass in laplace domain 4th order apparently
clc;
clear;

j = sqrt(-1);

%Only frequency values used (j axis)
s = -10:.001:10;
s_i = s*j;

% w_w / 2 = width of the pass band
% width frequency
w_w = .1;

%Transfer function for the Butterworth lowpass design
H_L = 1 ./ ((s_i/w_w).^2 + sqrt(2) * s_i / w_w + 1);

%Target frequency of the band (average)
w_t = 6;

%Right and left side of the band-pass transfer function and overall
%This is just modulation
H_BR = 1 ./ (((s_i - j*w_t)/w_w).^2 + sqrt(2) * (s_i - j*w_t) / w_w + 1);
H_BL = 1 ./ (((s_i + j*w_t)/w_w).^2 + sqrt(2) * (s_i + j*w_t) / w_w + 1);
H_B = H_BR + H_BL;

%Something?
new_s = s_i/w_t - w_t./s_i;
H = 1 ./ ((new_s).^2 / w_w^2 + sqrt(2) * (new_s) / w_w + 1)

figure(1)
hold on;
%plot(s, abs(H_L));
plot(s, abs(H_B));
%plot(s, abs(H));
hold off;


%% 1st order butterworth, 2nd order bandpass via modulation
clc
clear

j = sqrt(-1);

%Only frequency values used (j axis)
s = -20:.001:20;
s_i = s*j;

% w_w / 2 = width of the pass band
% width frequency
w_w = .5;

%Target frequency of the band (average)
w_t = 10.5;


%Filter
H_BL = 1 ./ ((s_i + j*w_t) / w_w + 1);
H_BR = 1 ./ ((s_i - j*w_t) / w_w + 1);
H_B = H_BL + H_BR;

plot(s,abs(H_B));

%% 1st order butterworth via modulation, 2nd order bandpass in z-domain
% this one doesnt work very well. it is not accurate
clc
clear

j = sqrt(-1);

% w_w is the width of the pass band
% w_t is the target frequency
% w_t +- w_w is the pass band
% T is the sampling period
w_t = pi/2;
w_w = pi/100;
T = 1;

%frequency values for plotting. 1e-6 to avoid pole-zero cancellations
%(although they shouldnt happen)
w = T*(-pi+1e-6:pi/1000:pi+1e-6);

%z values from freq
z = exp(j*w);

%helpful constants used in the formula
x = w_t*cot(w_t*T/2)/w_w;
A = 1 + (w_t/w_w)^2;

%Transfer function
H_num = (x+1) + (2)*z.^(-1) + (1-x)*z.^(-2);
H_den = (x^2+2*x+1) + (2*A-2*x^2)*z.^(-1) + (x^2-2*x+A)*z.^(-2);
H = 2 * H_num ./ H_den;

y=zeros(1,2001);
y(1000 + round(w_t*2000/2/pi) + round(w_w*2000/2/pi)) = 1;
y(1000 + round(w_t*2000/2/pi) - round(w_w*2000/2/pi)) = 1;
y(1000 - round(w_t*2000/2/pi) + round(w_w*2000/2/pi)) = 1;
y(1000 - round(w_t*2000/2/pi) - round(w_w*2000/2/pi)) = 1;

plot(w,abs(H));
hold on;
plot(w,y);


%% 1st order butterworth via multiplication s-domain
clc
clear

j = sqrt(-1);

%Only frequency values used (j axis)
s = -20+1e-6:.0001:20+1e-6;
s_i = s*j;

% w_w / 2 = width of the pass band
% width frequency
w_high = 8;

%Target frequency of the band (average)
w_low = 10;


%Filter
H_high = 1 ./ ((s_i / w_high).^(-1) + 1);
H_low = 1 ./ (s_i / w_low + 1);
H_band = H_high .* H_low;

figure(1);
hold on;
%plot(s,abs(H_high));
%plot(s,abs(H_low));
plot(s,abs(H_band));


%% 1st order butterworth via multiplication, 2nd order bandpass in z-domain
%THIS LOOKS GOOD
clc
clear

j = sqrt(-1);

% w_w is the width of the pass band
% w_t is the target frequency
% w_t +- w_w is the pass band
% T is the sampling period
wL = 35*pi/100;
wH = 12*pi/100;
T = 1;

%frequency values for plotting. 1e-6 to avoid pole-zero cancellations
%(although they shouldnt happen)
w = T*(-pi+1e-6:pi/1000:pi+1e-6);

%z values from freq
z = exp(j*w);

%helpful constants used in the formula
w0 = (wL + wH)/2;
x = w0 / tan(w0*T/2);
A = wL*wH;

%Transfer function
H_num = (-x/wH) + (z.^2)*(x/wH);
H_den = (1 - 2*x*w0/A + x*x/A) + (z)*(2-2*x*x/A) + (z.^2)*(1 + 2*x*w0/A + x*x/A);
H = H_num ./ H_den;

y=zeros(1,2001);
y(1000 + round(wH*2000/2/pi)) = 1;
y(1000 + round(wL*2000/2/pi)) = 1;
y(1000 - round(wH*2000/2/pi)) = 1;
y(1000 - round(wL*2000/2/pi)) = 1;

plot(w,abs(H));
hold on;
plot(w,y);

%Reminder:
%wL is the cutoff for the lowpass filter, or the higher cutoff of the band
%wH is the cutoff for the highpass filter, or the lower cutoff of the band
%w0 = (wL + wH)/2;
%x = w0 / tan(w0*T/2)
%A = wL*wH;
%
%corresponding difference eqn for:
% y[n]*b(1) = x[n]*a(1) + x[n-1]*a(2) + x[n-2]*a(3) - y[n-1]*b(2) - y[n-2]*b(3)
% a(1) = x/wH
% a(2) = 0
% a(3) = x/wH
% b(1) = 1 + 2*x*w0/A + x*x/A
% b(2) = 2 - 2*x*x/A
% b(3) = 1 - 2*x*w0/A + x*x/A






