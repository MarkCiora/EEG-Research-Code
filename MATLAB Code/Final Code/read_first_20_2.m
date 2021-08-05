% This file must be run first to interpret the data from file
% After this use "feature_extraction.m"


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
    Data(j).reduced_bool = 0;
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
% reduces data to 3 second samples of 300 data points
if Data(1).reduced_bool == 0
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
    clear new_sig

    % mean centered samples and mean
    for j = 1:20
        Data(j).mean = zeros(Data(j).samples, 1);
        for i = 1:Data(j).samples
            Data(j).mean(i) = sum(Data(j).signal(:,i)) / 300;
            Data(j).signal(:,i) = Data(j).signal(:,i) - Data(j).mean(i);
        end
    end

    % z-standard and variance
    for j = 1:20
        Data(j).var = zeros(Data(j).samples, 1);
        for i = 1:Data(j).samples
            Data(j).var(i) = sum(Data(j).signal(:,i).^2) / 300;
            Data(j).signal(:,i) = Data(j).signal(:,i) / sqrt(Data(j).var(i));
        end

        Data(j).reduced_bool = 1;
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
    Data(j).mean = Data(j).mean(1:Data(j).samples);
    Data(j).var = Data(j).var(1:Data(j).samples);
end

%% clear up some memory

Data = rmfield(Data, 'hyp');

%% clear up some memory
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

