% testing
clear;
clc;

%load EEG file
tt = edfread('SC4021E0-PSG.edf');
info = edfinfo('SC4021E0-PSG.edf');

%change which time segment to look at
%note: this data is divided into 30 second increments
rec = 1017;

%change which electrode to look at
sig = 1;

Fs = info.NumSamples(sig)/seconds(info.DataRecordDuration);     %sampling rate

t = (0:info.NumSamples(sig)-1)/Fs;
y = tt.(sig){rec};

%%

figure(1)
subplot(311)
plot(t,y)
xlabel('t (in sec)')
ylabel('\muV')
title('Unfiltered Sleep EEG Signal')

N = 1; % order = 2N;
norm = 1/(Fs/2);
[b,a] = butter(N, [norm*1 norm*4], 'bandpass');
delta = filter(b, a, y);

subplot(312)
plot(t, delta)
ylim([min(delta), max(delta)]);
xlabel('t (in sec)')
ylabel('\muV')
title('MATLAB Filter')

test = my_butter(1, 4, Fs/2,y);

subplot(313)
plot(t, test)
ylim([min(test), max(test)]);
xlabel('t (in sec)')
ylabel('\muV')
title('My Filter')

%figure(2);
%plot(t,y);
%hold on;
%plot(t, delta - test);
%hold off;

%% Side-by-side comparison of my_butter and MATLAB function
%% Unfiltered

N = 1; % order = 2N;
norm = 1/(Fs/2);

% plot unfiltered EEG signal
figure(1)
plot(t,y)
xlabel('t (in sec)')
ylabel('\muV')
title('Unfiltered Sleep EEG Signal')
legend(strcat("Record ",int2str(rec),", Signal ",info.SignalLabels(sig)))

%% MATLAB
% extract and plot 
figure(2)
sgtitle('Second Order Butterworth Filtered Sleep Signal MATLAB')

subplot(411)
[b,a] = butter(N, [1*norm 4*norm], 'bandpass');
delta = filter(b, a, y);

plot(t, delta)
xlabel('t (in sec)')
ylabel('\muV')
title('Delta Component')

subplot(412)
[b,a] = butter(N, [4*norm 8*norm], 'bandpass');
theta = filter(b, a, y);

plot(t, theta)
xlabel('t (in sec)')
ylabel('\muV')
title('Theta Component')

subplot(413)
[b,a] = butter(N, [8*norm 12*norm], 'bandpass');
alpha = filter(b, a, y);

plot(t, alpha)
xlabel('t (in sec)')
ylabel('\muV')
title('Alpha Component')

subplot(414)
[b,a] = butter(N, [12*norm 35*norm], 'bandpass');
beta = filter(b, a, y);

plot(t, beta)
xlabel('t (in sec)')
ylabel('\muV')
title('Beta Component')

%% my_butter
figure(3)
sgtitle('Second Order Butterworth Filtered Sleep Signal my butter')

subplot(411)
delta = my_butter(1,4,Fs/2,y);

plot(t, delta)
xlabel('t (in sec)')
ylabel('\muV')
title('Delta Component')

subplot(412)
theta = my_butter(4,8,Fs/2,y);

plot(t, theta)
xlabel('t (in sec)')
ylabel('\muV')
title('Theta Component')

subplot(413)
alpha = my_butter(8,12,Fs/2,y);

plot(t, alpha)
xlabel('t (in sec)')
ylabel('\muV')
title('Alpha Component')

subplot(414)
beta = my_butter(12,35,Fs/2,y);

plot(t, beta)
xlabel('t (in sec)')
ylabel('\muV')
title('Beta Component')