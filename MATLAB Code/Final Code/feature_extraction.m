%% After running "read_first_20_2.m" choose features from here
% At the end all the features are combined into one set of feature vectors
% A moving average of this result is also created
% Once features have been selected, classify them in another file

%% Filter and extract power -- 2nd order Butter approx
% Filter ranges:
filt = [1   4;...
        5   8;...
        9   12;...
        13  35];

F_s = 100;

% o2 specifies order 2 filter

for j = 1:20
    % Filter the signal over 4 prespecified ranges
    % By default alpha, beta, delta, gamma waves are used
    % These are arbitrary though
    signal_filt_o2 = zeros(300,Data(j).samples,4);
    for i = 1:Data(j).samples
        signal_filt_o2(:,i,1) = my_butter(filt(1,1),filt(1,2),F_s,Data(j).signal(:,i));
        signal_filt_o2(:,i,2) = my_butter(filt(2,1),filt(2,2),F_s,Data(j).signal(:,i));
        signal_filt_o2(:,i,3) = my_butter(filt(3,1),filt(3,2),F_s,Data(j).signal(:,i));
        signal_filt_o2(:,i,4) = my_butter(filt(4,1),filt(4,2),F_s,Data(j).signal(:,i));
    end
    
    % Extract power from filtered signals
    % The fifth row is the sum of the first four
    power_o2 = zeros(5,Data(j).samples);
    for i = 1:Data(j).samples
        power_o2(1,i) = sum(signal_filt_o2(:,i,1).^2)/300;
        power_o2(2,i) = sum(signal_filt_o2(:,i,2).^2)/300;
        power_o2(3,i) = sum(signal_filt_o2(:,i,3).^2)/300;
        power_o2(4,i) = sum(signal_filt_o2(:,i,4).^2)/300;
    end
    power_o2(5,:) = power_o2(1,:) + power_o2(2,:) + power_o2(3,:) + power_o2(4,:);
    
    % Extract ratios of power from each frequency range
    ratio_o2 = zeros(4,Data(j).samples);
    ratio_o2(1,:) = power_o2(1,:)./power_o2(5,:);
    ratio_o2(2,:) = power_o2(2,:)./power_o2(5,:);
    ratio_o2(3,:) = power_o2(3,:)./power_o2(5,:);
    ratio_o2(4,:) = power_o2(4,:)./power_o2(5,:);
    
    % Power ratios projected onto a 3d hyperplane
    % No information is lost here
    % proj_mat defines a hyperplane orthogonal to the ones vector
    proj_mat = [-1  1 -1;...
                -1 -1  1;...
                 1 -1 -1;...
                 1  1  1];
    Data(j).p_ratio_o2 = transpose(proj_mat) * ratio_o2;
    
end
clear signal_filt_o2
clear power_o2
clear proj_mat
clear ratio_o2
clear F_s
clear filt

%% Filter and exact power with ideal filtering
filt = [1   4;...
        4   8;...
        8   12;...
        12  35];

F_s = 100;
filt = round(filt*300/F_s);
for j = 1:20
    power_o2 = zeros(5,Data(j).samples);
    for i = 1:Data(j).samples
        temp = fft(Data(j).signal(:,i));
        power_o2(1,i) = sum(abs(temp(filt(1,1):filt(1,2))).^2)/150;
        power_o2(2,i) = sum(abs(temp(filt(2,1):filt(2,2))).^2)/150;
        power_o2(3,i) = sum(abs(temp(filt(3,1):filt(3,2))).^2)/150;
        power_o2(4,i) = sum(abs(temp(filt(4,1):filt(4,2))).^2)/150;
    end
    power_o2(5,:) = power_o2(1,:) + power_o2(2,:) + power_o2(3,:) + power_o2(4,:);
    
    % Extract ratios of power from each frequency range
    ratio_o2 = zeros(4,Data(j).samples);
    ratio_o2(1,:) = power_o2(1,:)./power_o2(5,:);
    ratio_o2(2,:) = power_o2(2,:)./power_o2(5,:);
    ratio_o2(3,:) = power_o2(3,:)./power_o2(5,:);
    ratio_o2(4,:) = power_o2(4,:)./power_o2(5,:);
    
    % Power ratios projected onto a 3d hyperplane
    % No information is lost here
    % proj_mat defines a hyperplane orthogonal to the ones vector
    proj_mat = [-1  1 -1;...
                -1 -1  1;...
                 1 -1 -1;...
                 1  1  1];
    Data(j).p_ratio = transpose(proj_mat) * ratio_o2;
end

%% Hjorth features
% Activity = Variance(x[n])
%
% Mobility = sqrt( Variance(x'[n]) )
%                ( --------------  )
%                ( Variance(x[n])  )
%
% Complexity = Mobility(x'[n])
%              ---------------
%              Mobility(x[n])

for j = 1:20
    derivative = zeros(299,Data(j).samples);
    derivative2 = zeros(298,Data(j).samples);
    
    var_d = zeros(Data(j).samples,1);
    var_d2 = zeros(Data(j).samples,1);
    
    for i = 1:Data(j).samples
        
        for k = 1:299
            derivative(k,i) =  ... 
                Data(j).signal(k+1,i) - Data(j).signal(k,i);
        end
        for k = 1:298
            derivative2(k,i) =  ... 
                derivative(k+1,i) - derivative(k,i);
        end
        
        mean1 = sum(derivative(:,i))/299;
        mean2 = sum(derivative2(:,i))/298;
        
        var_d(i) = sum((derivative(:,i)-mean1).^2)/299;
        var_d2(i) = sum((derivative2(:,i)-mean2).^2)/298;
        
    end
    
    activity = Data(j).var;
    mobility = sqrt(var_d ./ Data(j).var);
    complexity = sqrt(var_d2 .* Data(j).var) ./ var_d;
    
    Data(j).Hjorth = [transpose(activity); transpose(mobility); transpose(complexity)];
end
clear activity
clear complexity
clear derivative
clear derivative2
clear mean1
clear mean2
clear mobility
clear var
clear var_d
clear var_d2

%% Approximate Entropy
m = 3;
r = 0.12;
splits = 5;
for j = 1:20
    Data(j).ApproxEnt = zeros(1,Data(j).samples);
    for i = 1:Data(j).samples
        Data(j).ApproxEnt(1,i) = sum(ApEn(Data(j).signal(:,i),m,r,splits));
    end
end

%% Feature vector
% If nothing has changed, features should be a list of 6 dimensional vectors
% By default, Hjorth features and the order 2 filtered power is used
% Also extracts overall feature variance and mean
for j = 1:20
    Data(j).features = [Data(j).Hjorth;...
                        Data(j).p_ratio_o2;...
                        Data(j).ApproxEnt];
    for i = 1:height(Data(j).features)
        Data(j).features_mean(i) = ...
            sum(Data(j).features(i,:)) / Data(j).samples;
        Data(j).features_var(i) = ...
            sum((Data(j).features(i,:) - Data(j).features_mean(i)).^2)...
            / Data(j).samples;
    end
end

%% Normalize all features (OPTIONAL)
total = 0;
for j = 1:20
    total = total + Data(j).samples;
end

mean = zeros(height(Data(j).features),1);
for j = 1:20
    for i = 1:height(Data(j).features)
        mean(i) = mean(i) + sum(Data(j).features(i,:));
    end
end
mean = mean/total;

var = zeros(height(Data(j).features),1);
for j = 1:20
    for i = 1:height(Data(j).features)
        var(i) = var(i) + sum((Data(j).features(i,:)-mean(i)).^2);
    end
end
var = var/total;

for j = 1:20
    Data(j).features = (Data(j).features() - mean) ./ sqrt(var);
end

clear mean
clear var
clear total


%% Moving Average
ma_val = 8;
for j = 1:20
    Data(j).features_ma = zeros(height(Data(j).features),Data(j).samples);
    
    for i = 1 + ma_val:Data(j).samples
        for k = 1:height(Data(j).features)
            Data(j).features_ma(k,i) = sum(Data(j).features(k,i-ma_val:i));
        end
    end
end
clear ma_val

%% Fake moving average, not sure what to call it
% some recursive thing
%.8 seems good
factor = .82; % MUST BE LESS THAN 1
for j = 1:20
    Data(j).features_ma = zeros(height(Data(j).features),Data(j).samples);
    Data(j).features_ma(:,1) = Data(j).features(:,1) ./ (1 - factor);
    
    for i = 2:Data(j).samples
        Data(j).features_ma(:,i) = Data(j).features(:,i) + ...
                                   factor * Data(j).features_ma(:,i-1);
    end
end
clear factor


%% Separate data into shallow and deep sleep feature sets
for j = 1:20
    Data(j).shallow = zeros(height(Data(j).features), sum(Data(j).num(1:2)));
    Data(j).deep = zeros(height(Data(j).features), sum(Data(j).num(3:4)));
    Data(j).other = zeros(height(Data(j).features), sum(Data(j).num(5:6)));
    Data(j).shallow_ma = zeros(height(Data(j).features), sum(Data(j).num(1:2)));
    Data(j).deep_ma = zeros(height(Data(j).features), sum(Data(j).num(3:4)));
    Data(j).other_ma = zeros(height(Data(j).features), sum(Data(j).num(5:6)));
    
    count = [0 0 0];
    for i = 1:Data(j).samples
        if Data(j).state(i) == '1' || Data(j).state(i) == '2'
            count(1) = count(1) + 1;
            Data(j).shallow(:,count(1)) = Data(j).features(:,i);
            Data(j).shallow_ma(:,count(1)) = Data(j).features_ma(:,i);
        elseif Data(j).state(i) == '3' || Data(j).state(i) == '4'
            count(2) = count(2) + 1;
            Data(j).deep(:,count(2)) = Data(j).features(:,i);
            Data(j).deep_ma(:,count(2)) = Data(j).features_ma(:,i);
        else
            count(3) = count(3) + 1;
            Data(j).other(:,count(3)) = Data(j).features(:,i);
            Data(j).other_ma(:,count(3)) = Data(j).features_ma(:,i);
        end
    end
    
end

