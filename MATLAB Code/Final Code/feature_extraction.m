%% After running "read_first_20_2.m" choose features from here
% If you want to use all the features, run the whole script
% It might take a while
% At the end all the features are combined into one set of feature vectors
% A moving average of this result is also created

%% Filter and extract power
% Filter ranges:
filt = [1   4;...
        4   8;...
        8   12;...
        12  35];

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
    
    var = Data(j).var;
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
    
    activity = var;
    mobility = sqrt(var_d ./ var);
    complexity = sqrt(var_d2 .* var) ./ var_d;
    
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

%% Feature vector
% If nothing has changed, features should be a list of 6 dimensional
% vectors
for j = 1:20
    Data(j).features = [Data(j).Hjorth; Data(j).p_ratio_o2];
end

%% Moving Average
ma_val = 5;
for j = 1:20
    Data(j).features_ma = zeros(height(Data(j).features),Data(j).samples);
    
    for i = 1 + ma_val:Data(j).samples
        for k = 1:height(Data(j).features)
            Data(j).features_ma(k,i) = sum(Data(j).features(k,i-ma_val:i));
        end
    end
end
clear ma_val

%% Separate data into shallow and deep sleep feature sets
for j = 1:20
    Data(j).shallow = zeros(height(Data(j).features), sum(Data(j).num(1:2)));
    Data(j).deep = zeros(height(Data(j).features), sum(Data(j).num(3:4)));
    
    
end