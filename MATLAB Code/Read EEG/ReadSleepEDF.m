clear;
clc;

%load EEG file
tt = edfread('SC4021E0-PSG.edf');
info = edfinfo('SC4021E0-PSG.edf');

%change which time segment to look at
%note: this data is divided into 30 second increments
rec = 1017;

%change which electrode to look at
sig = 2;

Fs = info.NumSamples(sig)/seconds(info.DataRecordDuration);     %sampling rate
T = 1/Fs;           %sampling interval
L = 500;            %Number of time points
%t = 0:T:(L-1)*T;    %time vector
N = 1024;           %FFT points

y = tt.(sig){rec};
t = (0:info.NumSamples(sig)-1)/Fs;

%Original
subplot(211)
plot(t,y)
xlabel('t (in sec)')
ylabel('\muV')
title('Time Domain')
legend(strcat("Record ",int2str(rec),", Signal ",info.SignalLabels(sig)))

%FFT
X = fft(y,N);
SSB = X(1:N/2);
SSB(2:end) = 2*SSB(2:end);
f = (0:N/2-1)*(Fs/N);

subplot(212)
plot(f,abs(SSB/L))
xlabel('f (in Hz)')
ylabel('|X(f)|')
title('Frequency Spectrum')