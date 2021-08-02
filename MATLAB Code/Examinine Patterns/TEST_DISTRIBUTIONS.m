%% Clear
clc
clear

%% Read in and filter data
tt = edfread('SC4021E0-PSG.edf');
info = edfinfo('SC4021E0-PSG.edf');

Fs = info.NumSamples(2)/seconds(info.DataRecordDuration);     %sampling rate

data = zeros(3000,2804);
for i = 1:2804
    data(:,i) = tt.(2){i};
end
clear tt;
clear i;


%% Filter data
data_delta = data;
data_theta = data;
data_alpha = data;
data_beta = data;

for i = 1:2804
    data_delta(:,i) = my_butter(1,4,Fs/2,data(:,i));
    data_theta(:,i) = my_butter(4,8,Fs/2,data(:,i));
    data_alpha(:,i) = my_butter(8,12,Fs/2,data(:,i));
    data_beta(:,i) = my_butter(12,35,Fs/2,data(:,i));
end


%% Plot of example awake state
i = 100

figure(1)
subplot(511)
plot(data(:,i))
title('Unfiltered Data')

subplot(512)
plot(data_delta(:,i))
title('delta')

subplot(513)
plot(data_theta(:,i))
title('theta')

subplot(514)
plot(data_alpha(:,i))
title('alpha')

subplot(515)
plot(data_beta(:,i))
title('beta')

clear i;


%% Signal powers
power = zeros(1,2804);
power_delta = zeros(1,2804);
power_theta = zeros(1,2804);
power_alpha = zeros(1,2804);
power_beta = zeros(1,2804);

for i = 1:2804
    for j = 1:3000
        power(1,i) = power(1,i) + data(j,i)^2/3000;
        power_delta(1,i) = power_delta(1,i) + data_delta(j,i)^2/3000;
        power_theta(1,i) = power_theta(1,i) + data_theta(j,i)^2/3000;
        power_alpha(1,i) = power_alpha(1,i) + data_alpha(j,i)^2/3000;
        power_beta(1,i) = power_beta(1,i) + data_beta(j,i)^2/3000;
    end
end
clear i;
clear j;

%% Plot signal powers
figure(2)
subplot(511)
plot(power(1,:))
title('Unfiltered Power Data')

subplot(512)
plot(power_delta(1,:))
title('power delta')

subplot(513)
plot(power_theta(1,:))
title('power theta')

subplot(514)
plot(power_alpha(1,:))
title('power alpha')

subplot(515)
plot(power_beta(1,:))
title('power beta')


%% Distribution from 1-700 (awake)
dist_delta = zeros(1,100);
dist_theta = zeros(1,100);
dist_alpha = zeros(1,100);
dist_beta = zeros(1,100);
for i = 1:700
    if power_delta(i) > 100
        continue
    end
    dist_delta(1,round((power_delta(i) + 0.5)/1)) = dist_delta(1,round((power_delta(i) + 0.5)/1)) + 1;
end
for i = 1:700
    if power_theta(i) > 100
        continue
    end
    dist_theta(1,round((power_theta(i) + 0.5)/1)) = dist_theta(1,round((power_theta(i) + 0.5)/1)) + 1;
end
for i = 1:700
    if power_alpha(i) > 100
        continue
    end
    dist_alpha(1,round((power_alpha(i) + 0.5)/1)) = dist_alpha(1,round((power_alpha(i) + 0.5)/1)) + 1;
end
for i = 1:700
    if power_beta(i) > 100
        continue
    end
    dist_beta(1,round((power_beta(i) + 0.5)/1)) = dist_beta(1,round((power_beta(i) + 0.5)/1)) + 1;
end

figure(3)
subplot(411)
plot(dist_delta(1,:))
title('dist delta')

subplot(412)
plot(dist_theta(1,:))
title('dist theta')

subplot(413)
plot(dist_alpha(1,:))
title('dist alpha')

subplot(414)
plot(dist_beta(1,:))
title('dist beta')


%% Signal powers over shorter time period
power_S = zeros(1,28040);
power_delta_S = zeros(1,28040);
power_theta_S = zeros(1,28040);
power_alpha_S = zeros(1,28040);
power_beta_S = zeros(1,28040);

for i = 1:2804
    for k = 1:10
        for j = 1:300
            power_S(1,(i-1)*10+k) = power_S(1,(i-1)*10+k) + data(j+100*(k-1),i)^2/300;
            power_delta_S(1,(i-1)*10+k) = power_delta_S(1,(i-1)*10+k) + data_delta(j+100*(k-1),i)^2/300;
            power_theta_S(1,(i-1)*10+k) = power_theta_S(1,(i-1)*10+k) + data_theta(j+100*(k-1),i)^2/300;
            power_alpha_S(1,(i-1)*10+k) = power_alpha_S(1,(i-1)*10+k) + data_alpha(j+100*(k-1),i)^2/300;
            power_beta_S(1,(i-1)*10+k) = power_beta_S(1,(i-1)*10+k) + data_beta(j+100*(k-1),i)^2/300;
        end
    end
end

power_delta_S = power_delta_S.^(1/2);
power_theta_S = power_theta_S.^(1/2);
power_alpha_S = power_alpha_S.^(1/2);
power_beta_S = power_beta_S.^(1/2);


%% Plot new signal powers
figure(4)
subplot(511)
plot(power_S(1,:))
title('Unfiltered Power Data')

subplot(512)
plot(power_delta_S(1,:))
title('power delta')

subplot(513)
plot(power_theta_S(1,:))
title('power theta')

subplot(514)
plot(power_alpha_S(1,:))
title('power alpha')

subplot(515)
plot(power_beta_S(1,:))
title('power beta')

clear i;
clear j;


%% Distribution from 1-700 (awake)

dist_delta_S = zeros(1,200);
dist_theta_S = zeros(1,200);
dist_alpha_S = zeros(1,200);
dist_beta_S = zeros(1,200);
for i = 1:7000
    if power_delta_S(i) > 10
        continue
    end
    dist_delta_S(1,round((power_delta_S(i))/.05 + .5)) = dist_delta_S(1,round((power_delta_S(i))/.05 + .5)) + 1;
end
for i = 1:7000
    if power_theta_S(i) > 8
        continue
    end
    dist_theta_S(1,round((power_theta_S(i))/.04 + .5)) = dist_theta_S(1,round((power_theta_S(i))/.04 + .5)) + 1;
end
for i = 1:7000
    if power_alpha_S(i) > 8
        continue
    end
    dist_alpha_S(1,round((power_alpha_S(i))/.04 + .5)) = dist_alpha_S(1,round((power_alpha_S(i))/.04 + .5)) + 1;
end
for i = 1:7000
    if power_beta_S(i) > 10
        continue
    end
    dist_beta_S(1,round((power_beta_S(i))/.05 + .5)) = dist_beta_S(1,round((power_beta_S(i))/.05 + .5)) + 1;
end

figure(5)
subplot(411)
plot(dist_delta_S(1,:))
title('dist delta')

subplot(412)
plot(dist_theta_S(1,:))
title('dist theta')

subplot(413)
plot(dist_alpha_S(1,:))
title('dist alpha')

subplot(414)
plot(dist_beta_S(1,:))
title('dist beta')


%% Signal powers over shorter time period
power_S = zeros(1,28040);
power_delta_S = zeros(1,28040);
power_theta_S = zeros(1,28040);
power_alpha_S = zeros(1,28040);
power_beta_S = zeros(1,28040);

for i = 1:2804
    for k = 1:10
        for j = 1:300
            power_S(1,(i-1)*10+k) = power_S(1,(i-1)*10+k) + data(j+100*(k-1),i)^2/300;
            power_delta_S(1,(i-1)*10+k) = power_delta_S(1,(i-1)*10+k) + data_delta(j+100*(k-1),i)^2/300;
            power_theta_S(1,(i-1)*10+k) = power_theta_S(1,(i-1)*10+k) + data_theta(j+100*(k-1),i)^2/300;
            power_alpha_S(1,(i-1)*10+k) = power_alpha_S(1,(i-1)*10+k) + data_alpha(j+100*(k-1),i)^2/300;
            power_beta_S(1,(i-1)*10+k) = power_beta_S(1,(i-1)*10+k) + data_beta(j+100*(k-1),i)^2/300;
        end
    end
end

%power_delta_S = power_delta_S.^(1/2);
%power_theta_S = power_theta_S.^(1/2);
%power_alpha_S = power_alpha_S.^(1/2);
%power_beta_S = power_beta_S.^(1/2);

clear i;
clear j;


%% Plot new signal powers
figure(6)
subplot(511)
plot(power_S(1,:))
title('Unfiltered Power Data')

subplot(512)
plot(power_delta_S(1,:))
title('power delta')

subplot(513)
plot(power_theta_S(1,:))
title('power theta')

subplot(514)
plot(power_alpha_S(1,:))
title('power alpha')

subplot(515)
plot(power_beta_S(1,:))
title('power beta')


%% Distribution from 8000-16000 (awake)

dist_delta_S = zeros(1,200);
dist_theta_S = zeros(1,200);
dist_alpha_S = zeros(1,200);
dist_beta_S = zeros(1,200);
for i = 8000:16000
    if power_delta_S(i) > 10
        continue
    end
    dist_delta_S(1,round((power_delta_S(i))/.05 + .5)) = dist_delta_S(1,round((power_delta_S(i))/.05 + .5)) + 1;
end
for i = 8000:16000
    if power_theta_S(i) > 8
        continue
    end
    dist_theta_S(1,round((power_theta_S(i))/.04 + .5)) = dist_theta_S(1,round((power_theta_S(i))/.04 + .5)) + 1;
end
for i = 8000:16000
    if power_alpha_S(i) > 8
        continue
    end
    dist_alpha_S(1,round((power_alpha_S(i))/.04 + .5)) = dist_alpha_S(1,round((power_alpha_S(i))/.04 + .5)) + 1;
end
for i = 8000:16000
    if power_beta_S(i) > 10
        continue
    end
    dist_beta_S(1,round((power_beta_S(i))/.05 + .5)) = dist_beta_S(1,round((power_beta_S(i))/.05 + .5)) + 1;
end

figure(7)
subplot(411)
plot(dist_delta_S(1,:))
title('dist delta')

subplot(412)
plot(dist_theta_S(1,:))
title('dist theta')

subplot(413)
plot(dist_alpha_S(1,:))
title('dist alpha')

subplot(414)
plot(dist_beta_S(1,:))
title('dist beta')



%% Now the relative density of each frequency will be analyzed
totPow = power_delta_S + power_theta_S + power_alpha_S + power_beta_S;
relPow_delta = power_delta_S ./ totPow;
relPow_theta = power_theta_S ./ totPow;
relPow_alpha = power_alpha_S ./ totPow;
relPow_beta = power_beta_S ./ totPow;


%% Plot new signal powers
figure(8)

subplot(511)
plot(relPow_delta(1,:))
title('rel power delta')

subplot(512)
plot(relPow_theta(1,:))
title('rel power theta')

subplot(513)
plot(relPow_alpha(1,:))
title('rel power alpha')

subplot(514)
plot(relPow_beta(1,:))
title('rel power beta')


%% 1-7000 awake ... 8000-16000 asleep
dist_delta_S = zeros(1,250);
dist_theta_S = zeros(1,1000);
dist_alpha_S = zeros(1,1000);
dist_beta_S = zeros(1,500);
dist_delta_A = zeros(1,250);
dist_theta_A = zeros(1,1000);
dist_alpha_A = zeros(1,1000);
dist_beta_A = zeros(1,500);
for i = 8000:16000
    dist_delta_S(1,round((relPow_delta(i))/.004 + .5)) = dist_delta_S(1,round((relPow_delta(i))/.004 + .5)) + 1;
    dist_theta_S(1,round((relPow_theta(i))/.001 + .5)) = dist_theta_S(1,round((relPow_theta(i))/.001 + .5)) + 1;
    dist_alpha_S(1,round((relPow_alpha(i))/.001 + .5)) = dist_alpha_S(1,round((relPow_alpha(i))/.001 + .5)) + 1;
    dist_beta_S(1,round((relPow_beta(i))/.002 + .5)) = dist_beta_S(1,round((relPow_beta(i))/.002 + .5)) + 1;
end
for i = 1:7000
    dist_delta_A(1,round((relPow_delta(i))/.004 + .5)) = dist_delta_A(1,round((relPow_delta(i))/.004 + .5)) + 1;
    dist_theta_A(1,round((relPow_theta(i))/.001 + .5)) = dist_theta_A(1,round((relPow_theta(i))/.001 + .5)) + 1;
    dist_alpha_A(1,round((relPow_alpha(i))/.001 + .5)) = dist_alpha_A(1,round((relPow_alpha(i))/.001 + .5)) + 1;
    dist_beta_A(1,round((relPow_beta(i))/.002 + .5)) = dist_beta_A(1,round((relPow_beta(i))/.002 + .5)) + 1;
end

figure(9)
subplot(411)
hold on
plot(0:.004:.996,dist_delta_S(1,:)/8001,'blue')
plot(0:.004:.996,dist_delta_A(1,:)/7000,'red')
title('dist delta')

subplot(412)
hold on
plot(0:.001:.999,dist_theta_S(1,:)/8001,'blue')
plot(0:.001:.999,dist_theta_A(1,:)/7000,'red')
title('dist theta')

subplot(413)
hold on
plot(0:.001:.999,dist_alpha_S(1,:)/8001,'blue')
plot(0:.001:.999,dist_alpha_A(1,:)/7000,'red')
title('dist alpha')

subplot(414)
hold on
plot(0:.002:.998,dist_beta_S(1,:)/8001,'blue')
plot(0:.002:.998,dist_beta_A(1,:)/7000,'red')
title('dist beta')

figure(10)
hold on
plot(0:.004:.996,dist_delta_S(1,:)/8001,'blue')
plot(0:.004:.996,dist_delta_A(1,:)/7000,'red')
xlim([0 .9]);
title('dist delta')
figure(11)
hold on
plot(0:.001:.999,dist_theta_S(1,:)/8001,'blue')
plot(0:.001:.999,dist_theta_A(1,:)/7000,'red')
xlim([.1 .35]);
title('dist theta')
figure(12)
hold on
plot(0:.001:.999,dist_alpha_S(1,:)/8001,'blue')
plot(0:.001:.999,dist_alpha_A(1,:)/7000,'red')
xlim([0 .3]);
title('dist alpha')
figure(13)
hold on
plot(0:.002:.998,dist_beta_S(1,:)/8001,'blue')
plot(0:.002:.998,dist_beta_A(1,:)/7000,'red')
xlim([0 .6]);
title('dist beta')