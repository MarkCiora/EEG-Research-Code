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

%%