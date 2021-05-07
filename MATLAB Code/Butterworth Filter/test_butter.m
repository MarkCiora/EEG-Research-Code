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
