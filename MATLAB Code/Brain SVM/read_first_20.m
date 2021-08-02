
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
    for i = 1:height(ata(j).data)
        Data(j).signal(:,i) = ata(j).data.(2){i};
    end
end
clear ata



%% Info

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






%% asdfasdf assfaascvacsf 

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

for j = 1:20
    sleep_state = zeros(1,2880);
    inc = 1;
    for i = 1:length(Data(j).hyp.(2))
        for k = 1:seconds(Data(j).hyp.(2)(i))/30
            sleep_state(inc) = Data(j).hyp.(1){i}(13);
            inc = inc + 1;
        end
    end

    % 1, 2, 3, 4, R, W
    num_W = 0; %wake
    num_S = 0; %shallow sleep
    num_D = 0; %deep sleep
    num_R = 0; %REM sleep
    for i = 1:width(Data(j).signal)
        switch sleep_state(i)
            case '1'
                num_S = num_S + 1;
                sleep_state(i) = 1;
            case '2'
                num_S = num_S + 1;
                sleep_state(i) = 1;
            case '3'
                num_D = num_D + 1;
                sleep_state(i) = 2;
            case '4'
                num_D = num_D + 1;
                sleep_state(i) = 2;
            case 'R'
                num_R = num_R + 1;
                sleep_state(i) = 3;
            case 'W'
                num_W = num_W + 1;
                sleep_state(i) = 0;
        end
    end
    Data(j).state = sleep_state(1, 1:width(Data(j).signal));
    Data(j).num = [num_W num_S num_D num_R];
end

clear num_D
clear num_R
clear num_S
clear num_W
clear j
clear k
clear i
clear inc
clear sleep_state



%% 1
for j = 1:20
    Data(j).p = zeros(1,height(transpose(Data(j).signal)));
    Data(j).pd = zeros(1,height(transpose(Data(j).signal)));
    Data(j).pt = zeros(1,height(transpose(Data(j).signal)));
    Data(j).pa = zeros(1,height(transpose(Data(j).signal)));
    Data(j).pb = zeros(1,height(transpose(Data(j).signal)));
end

%% 2
for j = 1:20
    data_delta = Data(j).signal;
    data_theta = Data(j).signal;
    data_alpha = Data(j).signal;
    data_beta = Data(j).signal;

    for i = 1:height(transpose(Data(j).signal))
        data_delta(:,i) = my_butter(1,4,Data(j).Fs/2,Data(j).signal(:,i));
        data_theta(:,i) = my_butter(4,8,Data(j).Fs/2,Data(j).signal(:,i));
        data_alpha(:,i) = my_butter(8,12,Data(j).Fs/2,Data(j).signal(:,i));
        data_beta(:,i) = my_butter(12,35,Data(j).Fs/2,Data(j).signal(:,i));
    end
end

%% 3
for j = 1:20
    for i = 1:height(transpose(Data(j).signal))
        Data(j).p(1,i) = sum(Data(j).signal(:,i).^2)/3000;
        Data(j).pd(1,i) = sum(data_delta(:,i).^2)/3000;
        Data(j).pt(1,i) = sum(data_theta(:,i).^2)/3000;
        Data(j).pa(1,i) = sum(data_alpha(:,i).^2)/3000;
        Data(j).pb(1,i) = sum(data_beta(:,i).^2)/3000;
        Data(j).sumpow = Data(j).pd + Data(j).pt + Data(j).pa + Data(j).pb;
    end
end

%% 4
for j = 1:20
    Data(j).rel(1,:) = Data(j).pd ./ Data(j).sumpow;
    Data(j).rel(2,:) = Data(j).pt ./ Data(j).sumpow;
    Data(j).rel(3,:) = Data(j).pa ./ Data(j).sumpow;
    Data(j).rel(4,:) = Data(j).pb ./ Data(j).sumpow;
end

%% 5
%Separate data in each frequency category into 4 arrays, one for each stage
for j = 1:20
    Data(j).scat_w = zeros(4,Data(j).num(1),2);
    Data(j).scat_s = zeros(4,Data(j).num(2),2);
    Data(j).scat_d = zeros(4,Data(j).num(3),2);
    Data(j).scat_r = zeros(4,Data(j).num(4),2);
    
    for k = 1:4 %loop through freqs
        num = [1 1 1 1];
        for i = 1:width(Data(j).state)
            switch Data(j).state(i)
                case 0
                    Data(j).scat_w(k,num(1),1) = Data(j).rel(k,i);
                    Data(j).scat_w(k,num(1),2) = Data(j).p(1,i);
                    num(1) = num(1) + 1;
                case 1
                    Data(j).scat_s(k,num(2),1) = Data(j).rel(k,i);
                    Data(j).scat_s(k,num(2),2) = Data(j).p(1,i);
                    num(2) = num(2) + 1;
                case 2
                    Data(j).scat_d(k,num(3),1) = Data(j).rel(k,i);
                    Data(j).scat_d(k,num(3),2) = Data(j).p(1,i);
                    num(3) = num(3) + 1;
                case 3
                    Data(j).scat_r(k,num(4),1) = Data(j).rel(k,i);
                    Data(j).scat_r(k,num(4),2) = Data(j).p(1,i);
                    num(4) = num(4) + 1;
            end
        end
    end
end

%% 6

clear data_alpha
clear data_beta
clear data_delta
clear data_theta
clear i
clear j
Data = rmfield(Data, 'signal');
clear num
clear k