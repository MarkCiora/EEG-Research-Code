%% Determine sleep states
% Clear
clc
clear

% Get edf info from hypnogram file
h = edfinfo('SC4021EH-Hypnogram.edf');
m = h.Annotations;

% Create array to represent states at each time
%seconds(m.(2)(1))/30;
sleep_state = zeros(1,2880);
j = 1;
k = 0;
for i = 1:161
    for k = 1:seconds(m.(2)(i))/30
        sleep_state(j) = m.(1){i}(13);
        j = j + 1;
    end
end

% 1, 2, 3, 4, R, W
num_1 = 0;
num_2 = 0;
num_3 = 0;
num_4 = 0;
num_R = 0;
num_W = 0;
for i = 1:2880
    switch sleep_state(i)
        case '1'
            num_1 = num_1 + 1;
        case '2'
            num_2 = num_2 + 1;
        case '3'
            num_3 = num_3 + 1;
        case '4'
            num_4 = num_4 + 1;
        case 'R'
            num_R = num_R + 1;
        case 'W'
            num_W = num_W + 1;
    end
end


%% Read data in
% Read in data, filter, and extract power data
tt = edfread('SC4021E0-PSG.edf');
info = edfinfo('SC4021E0-PSG.edf');

Fs = info.NumSamples(2)/seconds(info.DataRecordDuration);     %sampling rate

data = zeros(3000,2804);
for i = 1:2804
    data(:,i) = tt.(2){i};
end
clear tt;
clear i;


% Filter data
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

% Signal powers
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

% Now the relative density of each frequency will be analyzed
totPow = power_delta + power_theta + power_alpha + power_beta;
relPow_delta = power_delta ./ totPow;
relPow_theta = power_theta ./ totPow;
relPow_alpha = power_alpha ./ totPow;
relPow_beta = power_beta ./ totPow;



%% Sort data
relPow_alpha_sorted = zeros(1,2804,6);
relPow_beta_sorted = zeros(1,2804,6);
relPow_delta_sorted = zeros(1,2804,6);
relPow_theta_sorted = zeros(1,2804,6);

j = 0;
for i = 1:2804
    if sleep_state(i) == '1'
        j = j+1;
        relPow_alpha_sorted(1,j,1) = relPow_alpha(1,j);
        relPow_beta_sorted(1,j,1) = relPow_beta(1,j);
        relPow_delta_sorted(1,j,1) = relPow_delta(1,j);
        relPow_theta_sorted(1,j,1) = relPow_theta(1,j);
    end
end
j = 0;
for i = 1:2804
    if sleep_state(i) == '2'
        j = j+1;
        relPow_alpha_sorted(1,j,2) = relPow_alpha(1,j);
        relPow_beta_sorted(1,j,2) = relPow_beta(1,j);
        relPow_delta_sorted(1,j,2) = relPow_delta(1,j);
        relPow_theta_sorted(1,j,2) = relPow_theta(1,j);
    end
end
j = 0;
for i = 1:2804
    if sleep_state(i) == '3'
        j = j+1;
        relPow_alpha_sorted(1,j,3) = relPow_alpha(1,j);
        relPow_beta_sorted(1,j,3) = relPow_beta(1,j);
        relPow_delta_sorted(1,j,3) = relPow_delta(1,j);
        relPow_theta_sorted(1,j,3) = relPow_theta(1,j);
    end
end
j = 0;
for i = 1:2804
    if sleep_state(i) == '4'
        j = j+1;
        relPow_alpha_sorted(1,j,4) = relPow_alpha(1,j);
        relPow_beta_sorted(1,j,4) = relPow_beta(1,j);
        relPow_delta_sorted(1,j,4) = relPow_delta(1,j);
        relPow_theta_sorted(1,j,4) = relPow_theta(1,j);
    end
end
j = 0;
for i = 1:2804
    if sleep_state(i) == 'R'
        j = j+1;
        relPow_alpha_sorted(1,j,5) = relPow_alpha(1,j);
        relPow_beta_sorted(1,j,5) = relPow_beta(1,j);
        relPow_delta_sorted(1,j,5) = relPow_delta(1,j);
        relPow_theta_sorted(1,j,5) = relPow_theta(1,j);
    end
end
j = 0;
for i = 1:2804
    if sleep_state(i) == 'W'
        j = j+1;
        relPow_alpha_sorted(1,j,6) = relPow_alpha(1,j);
        relPow_beta_sorted(1,j,6) = relPow_beta(1,j);
        relPow_delta_sorted(1,j,6) = relPow_delta(1,j);
        relPow_theta_sorted(1,j,6) = relPow_theta(1,j);
    end
end



%% Compare delta, beta, theta
figure(1)
scatter3(relPow_delta(1,1:700),relPow_theta(1,1:700),relPow_beta(1,1:700),'blue')
hold on
scatter3(relPow_delta(1,800:1600),relPow_theta(1,800:1600),relPow_beta(1,800:1600),'red')
xlabel('delta')
ylabel('theta')
zlabel('beta')
hold off

%% Compare delta, beta, alpha
figure(2)
scatter3(relPow_delta(1,1:700),relPow_alpha(1,1:700),relPow_beta(1,1:700),'blue')
hold on
scatter3(relPow_delta(1,800:1600),relPow_alpha(1,800:1600),relPow_beta(1,800:1600),'red')
xlabel('delta')
ylabel('alpha')
zlabel('beta')
hold off


%% Compare alpha, theta
figure(3)
scatter(relPow_alpha(1,1:700),relPow_theta(1,1:700),'blue')
hold on
scatter(relPow_alpha(1,800:1600),relPow_theta(1,800:1600),'red')
xlabel('alpha')
ylabel('theta')
hold off


%% Compare delta, beta for more stages
figure(4)
scatter(relPow_beta_sorted(1,1:num_1,1),relPow_delta_sorted(1,1:num_1,1), 'yellow')
hold on
scatter(relPow_beta_sorted(1,1:num_2,2),relPow_delta_sorted(1,1:num_2,2), 'magenta')
scatter(relPow_beta_sorted(1,1:num_3,3),relPow_delta_sorted(1,1:num_3,3), 'red')
scatter(relPow_beta_sorted(1,1:num_4,4),relPow_delta_sorted(1,1:num_4,4), 'red')
scatter(relPow_beta_sorted(1,1:num_R,5),relPow_delta_sorted(1,1:num_R,5), 'green')
%scatter(relPow_beta_sorted(1,1:num_W,6),relPow_delta_sorted(1,1:num_W,6), 'blue')
xlabel('beta')
ylabel('delta')
hold off


%% Histograms for each stage
num = [num_1 num_2 num_3 num_4 num_R num_W];

bins_a = zeros(1,100,6);
bins_b = zeros(1,100,6);
bins_d = zeros(1,100,6);
bins_t = zeros(1,100,6);
for i = 1:6
    for j = 1:num(i)
        bins_a(1,round((relPow_alpha_sorted(1,j,i))/.01 + .5),i) = 1 + bins(1,round((relPow_alpha_sorted(1,j,i))/.01 + .5),i);
        bins_b(1,round((relPow_beta_sorted(1,j,i))/.01 + .5),i) = 1 + bins(1,round((relPow_beta_sorted(1,j,i))/.01 + .5),i);
        bins_d(1,round((relPow_delta_sorted(1,j,i))/.01 + .5),i) = 1 + bins(1,round((relPow_delta_sorted(1,j,i))/.01 + .5),i);
        bins_t(1,round((relPow_theta_sorted(1,j,i))/.01 + .5),i) = 1 + bins(1,round((relPow_theta_sorted(1,j,i))/.01 + .5),i);
    end
end
bins_a(1,:,3) = bins_a(1,:,3) + bins_a(1,:,4)
bins_b(1,:,3) = bins_b(1,:,3) + bins_b(1,:,4)
bins_d(1,:,3) = bins_d(1,:,3) + bins_d(1,:,4)
bins_t(1,:,3) = bins_t(1,:,3) + bins_t(1,:,4)

%% histogram plots

figure(5)
hold on
%plot(0:.01:.99,bins_b(1,:,1)/num(1),'yellow')
%plot(0:.01:.99,bins_b(1,:,2)/num(2),'magenta')
plot(0:.01:.99,bins_b(1,:,3)/num(3),'red')
%plot(0:.01:.99,bins_b(1,:,4)/num(4),'red')
%plot(0:.01:.99,bins_b(1,:,5)/num(5),'green')
plot(0:.01:.99,bins_b(1,:,6)/num(6),'blue')
hold off



%% SVM

%Organize the data


% 
% % Subgradient Descent
% c = 10;
% w = [0;0;0;0];
% b = 0;
% grad_w = [0;0;0;0]
% grad_b = 0;
% step_ratio = .0001/c;
% 
% for j = 1:100000
%     grad_w = w;
%     grad_b = 0;
%     for i = 1:size
%         grad_w = grad_w - (c/size)*(y(i)*x(i)*SVM_indicator(w,x(i),b,y(i)));
%         grad_b = grad_b - (c/size)*(y(i)*SVM_indicator(w,x(i),b,y(i)));
%     end
%     w = w - grad_w*step_ratio;
%     b = b - grad_b*step_ratio;
% end

