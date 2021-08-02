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
    Data(j).signall = zeros(3000,height(ata(j).data));
    for k = 1:height(ata(j).data)
        Data(j).signall(:,k) = ata(j).data.(2){k};
    end
    Data(j).samples = width(Data(j).signall);
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



%% 
for j = 1:20
    
end
