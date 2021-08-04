%This file must be run first to interpret the data

%% Clear
clc
clear



%% Info

ata(1).data = edfread('SC4001E0-PSG.edf');
ata(2).data = edfread('SC4002E0-PSG.edf');
ata(3).data = edfread('SC4011E0-PSG.edf');
ata(4).data = edfread('SC4012E0-PSG.edf');
ata(5).data = edfread('SC4021E0-PSG.edf');
ata(6).data = edfread('SC4022E0-PSG.edf');
ata(7).data = edfread('SC4031E0-PSG.edf');
ata(8).data = edfread('SC4032E0-PSG.edf');
ata(9).data = edfread('SC4041E0-PSG.edf');
ata(10).data = edfread('SC4042E0-PSG.edf');
ata(11).data = edfread('SC4051E0-PSG.edf');
ata(12).data = edfread('SC4052E0-PSG.edf');
ata(13).data = edfread('SC4061E0-PSG.edf');
ata(14).data = edfread('SC4062E0-PSG.edf');
ata(15).data = edfread('SC4071E0-PSG.edf');
ata(16).data = edfread('SC4072E0-PSG.edf');
ata(17).data = edfread('SC4081E0-PSG.edf');
ata(18).data = edfread('SC4082E0-PSG.edf');
ata(19).data = edfread('SC4091E0-PSG.edf');
ata(20).data = edfread('SC4092E0-PSG.edf');

for j = 1:20
    Data(j).signal = zeros(3000,height(ata(j).data));
    for k = 1:height(ata(j).data)
        Data(j).signal(:,k) = ata(j).data.(2){k};
    end
    Data(j).samples = width(Data(j).signal);
end
clear ata



% Info

Data(1).info = edfinfo('SC4001E0-PSG.edf');
Data(2).info = edfinfo('SC4002E0-PSG.edf');
Data(3).info = edfinfo('SC4011E0-PSG.edf');
Data(4).info = edfinfo('SC4012E0-PSG.edf');
Data(5).info = edfinfo('SC4021E0-PSG.edf');
Data(6).info = edfinfo('SC4022E0-PSG.edf');
Data(7).info = edfinfo('SC4031E0-PSG.edf');
Data(8).info = edfinfo('SC4032E0-PSG.edf');
Data(9).info = edfinfo('SC4041E0-PSG.edf');
Data(10).info = edfinfo('SC4042E0-PSG.edf');
Data(11).info = edfinfo('SC4051E0-PSG.edf');
Data(12).info = edfinfo('SC4052E0-PSG.edf');
Data(13).info = edfinfo('SC4061E0-PSG.edf');
Data(14).info = edfinfo('SC4062E0-PSG.edf');
Data(15).info = edfinfo('SC4071E0-PSG.edf');
Data(16).info = edfinfo('SC4072E0-PSG.edf');
Data(17).info = edfinfo('SC4081E0-PSG.edf');
Data(18).info = edfinfo('SC4082E0-PSG.edf');
Data(19).info = edfinfo('SC4091E0-PSG.edf');
Data(20).info = edfinfo('SC4092E0-PSG.edf');

for j = 1:20
    Data(j).Fs = Data(j).info.NumSamples(2)/seconds(Data(j).info.DataRecordDuration);
end




% asdfasdf assfaascvacsf 

Data(1).hyp = edfinfo('SC4001EC-Hypnogram.edf').Annotations;
Data(2).hyp = edfinfo('SC4002EC-Hypnogram.edf').Annotations;
Data(3).hyp = edfinfo('SC4011EH-Hypnogram.edf').Annotations;
Data(4).hyp = edfinfo('SC4012EC-Hypnogram.edf').Annotations;
Data(5).hyp = edfinfo('SC4021EH-Hypnogram.edf').Annotations;
Data(6).hyp = edfinfo('SC4022EJ-Hypnogram.edf').Annotations;
Data(7).hyp = edfinfo('SC4031EC-Hypnogram.edf').Annotations;
Data(8).hyp = edfinfo('SC4032EP-Hypnogram.edf').Annotations;
Data(9).hyp = edfinfo('SC4041EC-Hypnogram.edf').Annotations;
Data(10).hyp = edfinfo('SC4042EC-Hypnogram.edf').Annotations;
Data(11).hyp = edfinfo('SC4051EC-Hypnogram.edf').Annotations;
Data(12).hyp = edfinfo('SC4052EC-Hypnogram.edf').Annotations;
Data(13).hyp = edfinfo('SC4061EC-Hypnogram.edf').Annotations;
Data(14).hyp = edfinfo('SC4062EC-Hypnogram.edf').Annotations;
Data(15).hyp = edfinfo('SC4071EC-Hypnogram.edf').Annotations;
Data(16).hyp = edfinfo('SC4072EH-Hypnogram.edf').Annotations;
Data(17).hyp = edfinfo('SC4081EC-Hypnogram.edf').Annotations;
Data(18).hyp = edfinfo('SC4082EP-Hypnogram.edf').Annotations;
Data(19).hyp = edfinfo('SC4091EC-Hypnogram.edf').Annotations;
Data(20).hyp = edfinfo('SC4092EC-Hypnogram.edf').Annotations;




%% Shorter sample duration, more power data
for j = 1:20
    Data(j).samples = Data(j).samples*10;
    new_sig = zeros(300,Data(j).samples);
    for i = 1:Data(j).samples/10
        for k = 1:10
            new_sig(:,k + (i-1)*10) = Data(j).signal(1 + (k-1)*300:k*300, i);
        end
    end
    Data(j).signal = new_sig;
end

%% mean centered samples
for j = 1:20
    for i = 1:Data(j).samples
        Data(j).signal(:,i) = Data(j).signal(:,i) - sum(Data(j).signal(:,i)) / 300;
    end
end

%% z-standard
for j = 1:20
    for i = 1:Data(j).samples
        Data(j).signal(:,i) = Data(j).signal(:,i) * sqrt(300) / sqrt(sum(Data(j).signal(:,i).^2));
    end
end



%% States
for j = 1:20
    % Extract sleep state data from file
    sleep_state = zeros(1,28800);
    inc = 1;
    for i = 1:length(Data(j).hyp.(2))
        char_ = Data(j).hyp.(1){i}(13);
        for k = 1:seconds(Data(j).hyp.(2)(i))/30
            for asdf = 1:10
                sleep_state(asdf + 10*(inc-1)) = char_;
            end
            inc = inc + 1;
        end
    end

    % Determine which state is present at each sample
    % 1, 2, 3, 4, R, W
    num_W = 0; %wake
    num_1 = 0; %shallow sleep
    num_2 = 0; %shallow sleep
    num_3 = 0; %deep sleep
    num_4 = 0; %deep sleep
    num_R = 0; %REM sleep
    for i = 1:Data(j).samples
        switch sleep_state(i)
            case '1'
                num_1 = num_1 + 1;
                sleep_state(i) = '1';
            case '2'
                num_2 = num_2 + 1;
                sleep_state(i) = '2';
            case '3'
                num_3 = num_3 + 1;
                sleep_state(i) = '3';
            case '4'
                num_4 = num_4 + 1;
                sleep_state(i) = '4';
            case 'R'
                num_R = num_R + 1;
                sleep_state(i) = 'R';
            case 'W'
                num_W = num_W + 1;
                sleep_state(i) = 'W';
        end
    end
    Data(j).num = [num_1 num_2 num_3 num_4 num_R num_W];
    Data(j).state = sleep_state(1:sum(Data(j).num));
    Data(j).signal = Data(j).signal(:,1:sum(Data(j).num));
    Data(j).samples = sum(Data(j).num);
end

%%

Data = rmfield(Data, 'hyp');

%%
clear char_
clear asdf
clear i
clear inc 
clear k 
clear j 
clear new_sig 
clear num_1 
clear num_2
clear num_3
clear num_4
clear num_R
clear num_W
clear sleep_state

%% Filter
for j = 1:20
    Data(j).signal_filt_o2 = zeros(300,Data(j).samples,4);
    
    for i = 1:Data(j).samples
        Data(j).signal_filt_o2(:,i,1) = my_butter(1,4,100,Data(j).signal(:,i));
        Data(j).signal_filt_o2(:,i,2) = my_butter(4,8,100,Data(j).signal(:,i));
        Data(j).signal_filt_o2(:,i,3) = my_butter(8,12,100,Data(j).signal(:,i));
        Data(j).signal_filt_o2(:,i,4) = my_butter(12,35,100,Data(j).signal(:,i));
    end
end

%% ApEn
m = 4;
r = 0.1;
splits = 1;
for j = 1:20
    Data(j).ApproxEnt = zeros(splits,Data(j).samples);
    for i = 1:Data(j).samples
        Data(j).ApproxEnt(:,i) = ApEn(Data(j).signal(:,i),m,r,splits);
    end
end

%% ApEn 2.0
m = 6;
r = 0.3;
splits = 1;
for j = 1:20
    Data(j).ApproxEnt2 = zeros(splits,Data(j).samples);
    for i = 1:Data(j).samples
        Data(j).ApproxEnt2(:,i) = ApEn2(Data(j).signal(:,i),m,r,splits);
    end
end


%% Derivatives 1,2 and Hjorth
for j = 1:1
    Data(j).derivative = zeros(299,Data(j).samples);
    Data(j).derivative2 = zeros(298,Data(j).samples);
    
    Data(j).var = zeros(1,Data(j).samples);
    Data(j).var_d = zeros(1,Data(j).samples);
    Data(j).var_d2 = zeros(1,Data(j).samples);
    
    Data(j).activity = zeros(1,Data(j).samples);%literally var
    Data(j).mobility = zeros(1,Data(j).samples);
    Data(j).complexity = zeros(1,Data(j).samples);
    
    for i = 1:Data(j).samples
        
        for k = 1:299
            Data(j).derivative(k,i) =  ... 
                Data(j).signal(k+1,i) - Data(j).signal(k,i);
        end
        for k = 1:298
            Data(j).derivative2(k,i) =  ... 
                Data(j).derivative(k+1,i) - Data(j).derivative(k,i);
        end
        
        mean = sum(Data(j).signal(:,i))/300;
        mean1 = sum(Data(j).derivative(:,i))/299;
        mean2 = sum(Data(j).derivative2(:,i))/298;
        
        Data(j).var(1,i) = sum((Data(j).signal(:,i)-mean).^2)/300;
        Data(j).var_d(1,i) = sum((Data(j).derivative(:,i)-mean1).^2)/299;
        Data(j).var_d2(1,i) = sum((Data(j).derivative2(:,i)-mean2).^2)/298;
        
    end
    Data(j).activity = Data(j).var;
    Data(j).mobility = sqrt(Data(j).var_d ./ Data(j).var);
    Data(j).complexity = sqrt(Data(j).var_d2 .* Data(j).var) ./ Data(j).var_d;
    
    Data(j).Hjorth = [Data(j).activity; Data(j).mobility; Data(j).complexity];
end

%% Hurst!
for j = 1:20
    Data(j).hurst = zeros(1,Data(j).samples);
    for i = 1:Data(j).samples
        Data(j).hurst(1,i) = estimate_hurst_exponent(Data(j).signal(:,i));
    end
end

%% Threshold bad
thresh = 10;
for j = 1:20
    Data(j).threshold = zeros(1,Data(j).samples);
    for i = 1:Data(j).samples
        for k = 1:300
            if Data(j).signal(k,i)^2 > thresh^2
                Data(j).threshold(1,i) = Data(j).threshold(1,i) + 1;
            end
        end
    end
end

%% Crosses over 0
for j = 1:20
    sum_arr = zeros(Data(j).samples,1);
    for i = 1:Data(j).samples
        sum = 0;
        for k = 2:300
            if Data(j).signal(k,i) * Data(j).signal(k-1,i) <= 0
                sum = sum + 1;
            end
        end
        sum_arr(i) = sum;
    end
    Data(j).cross0 = transpose(sum_arr);
end


%% Extract power
for j = 1:20
    Data(j).power_o2 = zeros(5,Data(j).samples);
    for i = 1:Data(j).samples
        Data(j).power_o2(1,i) = sum(Data(j).signal_filt_o2(:,i,1).^2)/300;
        Data(j).power_o2(2,i) = sum(Data(j).signal_filt_o2(:,i,2).^2)/300;
        Data(j).power_o2(3,i) = sum(Data(j).signal_filt_o2(:,i,3).^2)/300;
        Data(j).power_o2(4,i) = sum(Data(j).signal_filt_o2(:,i,4).^2)/300;
    end
    Data(j).power_o2(5,:) = Data(j).power_o2(1,:) + Data(j).power_o2(2,:) + Data(j).power_o2(3,:) + Data(j).power_o2(4,:);
end

%%

Data = rmfield(Data, 'signal_filt_o2');


%% Power ratio
for j = 1:20
    Data(j).ratio_o2 = zeros(4,Data(j).samples);
    Data(j).ratio_o2(1,:) = Data(j).power_o2(1,:)./Data(j).power_o2(5,:);
    Data(j).ratio_o2(2,:) = Data(j).power_o2(2,:)./Data(j).power_o2(5,:);
    Data(j).ratio_o2(3,:) = Data(j).power_o2(3,:)./Data(j).power_o2(5,:);
    Data(j).ratio_o2(4,:) = Data(j).power_o2(4,:)./Data(j).power_o2(5,:);
end

%%

Data = rmfield(Data, 'power_o2');


%% Reduce to 3 dimensions
% project onto vectors:     -1   1  -1  
%                           -1  -1   1
%                            1  -1  -1
%                            1   1   1
%
% These are perpendicular to:   1
%                               1
%                               1
%                               1
% Which provides no useful information
proj_mat = [-1 1 -1; -1 -1 1; 1 -1 -1; 1 1 1];
for j = 1:20
    a = Data(j).ratio_o2;
    temp = [a(1,:); a(2,:); a(3,:); a(4,:)];
    Data(j).ratio_o2_d3 = transpose(proj_mat)*temp;
    clear a;
end
%clear proj_mat
clear temp
clear a

%%

Data = rmfield(Data, 'ratio_o2');


%%  eliminate transitions and moving average
marching = 20;
ma_val = 20;
error_range = 0;
for j = 1:20
    %Eliminate transitions first
    Data(j).ma_val = ma_val;
    spots = [];
    num = [0 0 0 0];
    for k = matching+1:Data(j).pow_samples - matching
        bad = 0;
        for loop = -matching:matching
            if Data(j).pow_state(k - loop) ~= Data(j).pow_state(k)
                bad = 1;
            end
        end
        
        if bad == 0
            spots = [spots k];
            num(Data(j).pow_state(k)+1) = num(Data(j).pow_state(k)+1) + 1;
        end
    end
    
    Data(j).ratio_o2_refined = zeros(3,width(spots));
    Data(j).state_o2_refined = zeros(1,width(spots));
    num = [0 0 0 0];
    for i = 1:width(spots)
        num(Data(j).pow_state(spots(i)) + 1) = num(Data(j).pow_state(spots(i)) + 1) + 1;
        Data(j).ratio_o2_refined(:,sum(num)) = Data(j).ratio_o2_d3(:,spots(i));
        Data(j).state_o2_refined(1,sum(num)) = Data(j).pow_state(spots(i));
    end
    
    %Moving average
    Data(j).ratio_o2_ultimate = zeros(3,sum(num)-ma_val);
    Data(j).pow_state_ultimate = zeros(1,sum(Data(j).num)-ma_val);
    for i = 1:width(Data(j).state_o2_refined) - ma_val
        Data(j).ratio_o2_ultimate(1,i) = sum(Data(j).ratio_o2_refined(1,1+i:ma_val+i));
        Data(j).ratio_o2_ultimate(2,i) = sum(Data(j).ratio_o2_refined(2,1+i:ma_val+i));
        Data(j).ratio_o2_ultimate(3,i) = sum(Data(j).ratio_o2_refined(3,1+i:ma_val+i));
        
        Data(j).pow_state_ultimate(1,i) = sum(Data(j).state_o2_refined(1,1+i:ma_val+i));
    end
    Data(j).pow_state_ultimate = Data(j).pow_state_ultimate / ma_val + 1;
    Data(j).ratio_o2_ultimate = Data(j).ratio_o2_ultimate / ma_val + 1;
    C(j).ma = ma_val;
    
    %Sort
    num = [0 0 0 0];
    for i = 1:width(Data(j).ratio_o2_ultimate) - C(j).ma
        v1 = Data(j).pow_state_ultimate(i);
        if (v1 <= 1.5 - error_range) && (v1 >= 1)
            num(1) = num(1) + 1;
        elseif (v1 <= 2.5 - error_range) && (v1 >= 1.5 + error_range)
            num(2) = num(2) + 1;
        elseif (v1 <= 3.5 - error_range) && (v1 >= 2.5 + error_range)
            num(3) = num(3) + 1;
        elseif (v1 <= 4) && (v1 >= 3.5 + error_range)
            num(4) = num(4) + 1;
        end
    end
    C(j).num = num;
    C(j).w_o2 = zeros(3,C(j).num(1));
    C(j).s_o2 = zeros(3,C(j).num(2));
    C(j).d_o2 = zeros(3,C(j).num(3));
    C(j).r_o2 = zeros(3,C(j).num(4));
    
    num = [0 0 0 0];
    for i = 1:sum(C(j).num) - C(j).ma
        v1 = Data(j).pow_state_ultimate(i);
        if (v1 <= 1.5 - error_range) && (v1 >= 1)
            num(1) = num(1) + 1;
            C(j).w_o2(:,num(1)) = Data(j).ratio_o2_ultimate(:,i); 
        elseif (v1 <= 2.5 - error_range) && (v1 >= 1.5 + error_range)
            num(2) = num(2) + 1;
            C(j).s_o2(:,num(2)) = Data(j).ratio_o2_ultimate(:,i);
        elseif (v1 <= 3.5 - error_range) && (v1 >= 2.5 + error_range)
            num(3) = num(3) + 1;
            C(j).d_o2(:,num(3)) = Data(j).ratio_o2_ultimate(:,i);
        elseif (v1 <= 4) && (v1 >= 3.5 + error_range)
            num(4) = num(4) + 1;
            C(j).r_o2(:,num(4)) = Data(j).ratio_o2_ultimate(:,i);
        end
    end
end

%% Moving average
ma_val = 45;
for j = 1:20
    Data(j).ma_val = ma_val;
    Data(j).ratio_o2_ma = zeros(1,sum(Data(j).num)-ma_val,4);
    Data(j).ratio_o2_ma_d3 = zeros(3,sum(Data(j).num)-ma_val);
    Data(j).pow_state_ma = zeros(1,sum(Data(j).num)-ma_val);
    for i = 1:sum(Data(j).num) - ma_val
        Data(j).ratio_o2_ma(1,i,1) = sum(Data(j).ratio_o2(1,1+i:ma_val+i,1));
        Data(j).ratio_o2_ma(1,i,2) = sum(Data(j).ratio_o2(1,1+i:ma_val+i,2));
        Data(j).ratio_o2_ma(1,i,3) = sum(Data(j).ratio_o2(1,1+i:ma_val+i,3));
        Data(j).ratio_o2_ma(1,i,4) = sum(Data(j).ratio_o2(1,1+i:ma_val+i,4));
        
        Data(j).ratio_o2_ma_d3(1,i) = sum(Data(j).ratio_o2_d3(1,1+i:ma_val+i));
        Data(j).ratio_o2_ma_d3(2,i) = sum(Data(j).ratio_o2_d3(2,1+i:ma_val+i));
        Data(j).ratio_o2_ma_d3(3,i) = sum(Data(j).ratio_o2_d3(3,1+i:ma_val+i));
        
        Data(j).pow_state_ma(1,i) = sum(Data(j).pow_state(1,1+i:ma_val+i));
    end
    Data(j).pow_state_ma = Data(j).pow_state_ma / ma_val + 1;
    A(j).ma = ma_val;
    B(j).ma = ma_val;
end


%%
clear asdf
clear i
clear inc
clear j
clear k
clear new_sig
clear num_D
clear num_R
clear num_S
clear num_W
clear signal_filt_o2
clear sleep_state
clear char_


%% Sort o2 power
for j = 1:20
    % aWake Shallow Deep Rem
    A(j).w_o2 = zeros(1,Data(j).num(1),4);
    A(j).s_o2 = zeros(1,Data(j).num(2),4);
    A(j).d_o2 = zeros(1,Data(j).num(3),4);
    A(j).r_o2 = zeros(1,Data(j).num(4),4);
    
    B(j).w_o2 = zeros(3,Data(j).num(1));
    B(j).s_o2 = zeros(3,Data(j).num(2));
    B(j).d_o2 = zeros(3,Data(j).num(3));
    B(j).r_o2 = zeros(3,Data(j).num(4));
    
    num = [0 0 0 0];
    for i = 1:Data(j).pow_samples
        switch Data(j).pow_state(i)
            case 0 %awake
                num(1) = num(1) + 1;
                A(j).w_o2(1,num(1),:) = Data(j).ratio_o2(1,i,1:4);
                B(j).w_o2(:,num(1)) = Data(j).ratio_o2_d3(:,i); 
            case 1 %shallow
                num(2) = num(2) + 1;
                A(j).s_o2(1,num(2),:) = Data(j).ratio_o2(1,i,1:4);
                B(j).s_o2(:,num(2)) = Data(j).ratio_o2_d3(:,i);
            case 2 %deep
                num(3) = num(3) + 1;
                A(j).d_o2(1,num(3),:) = Data(j).ratio_o2(1,i,1:4);
                B(j).d_o2(:,num(3)) = Data(j).ratio_o2_d3(:,i);
            case 3 %rem
                num(4) = num(4) + 1;
                A(j).r_o2(1,num(4),:) = Data(j).ratio_o2(1,i,1:4);
                B(j).r_o2(:,num(4)) = Data(j).ratio_o2_d3(:,i);
        end
    end
    A(j).num = num;
    B(j).num = num;
end
clear num
clear i
clear j


%% Sort o2 power MOVING AVERAGE
error_range = 0;
for j = 1:20
    num = [0 0 0 0];
    for i = 1:Data(j).pow_samples - A(j).ma
        v1 = Data(j).pow_state_ma(i);
        if (v1 <= 1.5 - error_range) && (v1 >= 1)
            num(1) = num(1) + 1;
        elseif (v1 <= 2.5 - error_range) && (v1 >= 1.5 + error_range)
            num(2) = num(2) + 1;
        elseif (v1 <= 3.5 - error_range) && (v1 >= 2.5 + error_range)
            num(3) = num(3) + 1;
        elseif (v1 <= 4) && (v1 >= 3.5 + error_range)
            num(4) = num(4) + 1;
        end
    end
    A(j).num_ma = num;
    % aWake Shallow Deep Rem
    A(j).w_o2_ma = zeros(1,num(1),4);
    A(j).s_o2_ma = zeros(1,num(2),4);
    A(j).d_o2_ma = zeros(1,num(3),4);
    A(j).r_o2_ma = zeros(1,num(4),4);
    
    B(j).w_o2_ma = zeros(3,num(1));
    B(j).s_o2_ma = zeros(3,num(2));
    B(j).d_o2_ma = zeros(3,num(3));
    B(j).r_o2_ma = zeros(3,num(4));
    
    num = [0 0 0 0];
    for i = 1:Data(j).pow_samples - A(j).ma
        v1 = Data(j).pow_state_ma(i);
        if (v1 <= 1.5 - error_range) && (v1 >= 1)
            num(1) = num(1) + 1;
            A(j).w_o2_ma(1,num(1),:) = Data(j).ratio_o2_ma(1,i,1:4); 
            B(j).w_o2_ma(:,num(1)) = Data(j).ratio_o2_ma_d3(:,i); 
        elseif (v1 <= 2.5 - error_range) && (v1 >= 1.5 + error_range)
            num(2) = num(2) + 1;
            A(j).s_o2_ma(1,num(2),:) = Data(j).ratio_o2_ma(1,i,1:4);
            B(j).s_o2_ma(:,num(2)) = Data(j).ratio_o2_ma_d3(:,i);
        elseif (v1 <= 3.5 - error_range) && (v1 >= 2.5 + error_range)
            num(3) = num(3) + 1;
            A(j).d_o2_ma(1,num(3),:) = Data(j).ratio_o2_ma(1,i,1:4);
            B(j).d_o2_ma(:,num(3)) = Data(j).ratio_o2_ma_d3(:,i);
        elseif (v1 <= 4) && (v1 >= 3.5 + error_range)
            num(4) = num(4) + 1;
            A(j).r_o2_ma(1,num(4),:) = Data(j).ratio_o2_ma(1,i,1:4);
            B(j).r_o2_ma(:,num(4)) = Data(j).ratio_o2_ma_d3(:,i);
        end
    end
    A(j).num_ma = num;
end
clear num
clear i
clear j


%% Sort while IGNORING close time-based state changes
matching = 50;
for j = 1:20
    spots = [];
    num = [0 0 0 0];
    for k = matching+1:Data(j).pow_samples - matching
        bad = 0;
        for loop = -matching:matching
            if Data(j).pow_state(k - loop) ~= Data(j).pow_state(k)
                bad = 1;
            end
        end
        
        if bad == 0
            spots = [spots k];
            num(Data(j).pow_state(k)+1) = num(Data(j).pow_state(k)+1) + 1;
        end
    end
    
    % aWake Shallow Deep Rem
    A(j).w_o2_refined = zeros(1,num(1),4);
    A(j).s_o2_refined = zeros(1,num(2),4);
    A(j).d_o2_refined = zeros(1,num(3),4);
    A(j).r_o2_refined = zeros(1,num(4),4);
    
    num = [0 0 0 0];
    for i = 1:width(spots)
        switch Data(j).pow_state(spots(i))
            case 0 %awake
                num(1) = num(1) + 1;
                A(j).w_o2_refined(1,num(1),:) = Data(j).ratio_o2(1,spots(i),1:4); 
            case 1 %shallow
                num(2) = num(2) + 1;
                A(j).s_o2_refined(1,num(2),:) = Data(j).ratio_o2(1,spots(i),1:4);
            case 2 %deep
                num(3) = num(3) + 1;
                A(j).d_o2_refined(1,num(3),:) = Data(j).ratio_o2(1,spots(i),1:4);
            case 3 %rem
                num(4) = num(4) + 1;
                A(j).r_o2_refined(1,num(4),:) = Data(j).ratio_o2(1,spots(i),1:4);
        end
    end
    A(j).num_refined = num;
end
clear num
clear i
clear j


%% Hjorth sort
for j = 1:1
    % aWake Shallow Deep Rem
    A(j).s1 = zeros(3,Data(j).num(1));
    A(j).s2 = zeros(3,Data(j).num(2));
    A(j).s3 = zeros(3,Data(j).num(3));
    A(j).s4 = zeros(3,Data(j).num(4));
    
    num = [0 0 0 0];
    for i = 1:Data(j).samples
        switch Data(j).state(i)
            case '1' %1
                num(1) = num(1) + 1;
                A(j).s1(:,num(1)) = Data(j).Hjorth(:,i);
            case '2' %2
                num(2) = num(2) + 1;
                A(j).s2(:,num(2)) = Data(j).Hjorth(:,i);
            case '3' %3
                num(3) = num(3) + 1;
                A(j).s3(:,num(3)) = Data(j).Hjorth(:,i);
            case '4' %4
                num(4) = num(4) + 1;
                A(j).s4(:,num(4)) = Data(j).Hjorth(:,i);
        end
    end
    A(j).num = num;
end
clear num
clear i
clear j