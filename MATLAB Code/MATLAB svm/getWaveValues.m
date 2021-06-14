function [delta, theta, alpha, beta] = getWaveValues(file, rec, sig)
%load EEG file
tt = edfread(file);
info = edfinfo(file);

Fs = info.NumSamples(sig)/seconds(info.DataRecordDuration);     %sampling rate

y = tt.(sig){rec};
%%
%get delta signals (0.5-4 Hz)
delta_filt = designfilt('bandpassfir', 'FilterOrder', 30, 'CutoffFrequency1', 1, 'CutoffFrequency2', 4, 'SampleRate', Fs);
d = filtfilt(delta_filt, y);

D = abs(fft(d));

%average
delta = mean(D);
%%
%get theta (4-8 Hz)
theta_filt = designfilt('bandpassfir', 'FilterOrder', 30, 'CutoffFrequency1', 4, 'CutoffFrequency2', 8, 'SampleRate', Fs);
t = filtfilt(theta_filt, y);

T = abs(fft(t));

%average
theta = mean(T);
%%
%get alpha (8-12 Hz)
alpha_filt = designfilt('bandpassfir', 'FilterOrder', 30, 'CutoffFrequency1', 8, 'CutoffFrequency2', 12, 'SampleRate', Fs);
a = filtfilt(alpha_filt, y);

A = abs(fft(a));

%average
alpha = mean(A);
%%
%get beta (12-35 Hz)
beta_filt = designfilt('bandpassfir', 'FilterOrder', 30, 'CutoffFrequency1', 12, 'CutoffFrequency2', 35, 'SampleRate', Fs);
b = filtfilt(beta_filt, y);

B = abs(fft(b));

%average
beta = mean(B);
end