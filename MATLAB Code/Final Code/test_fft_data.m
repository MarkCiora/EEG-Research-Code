%% Separate data into shallow and deep sleep feature sets

temp1 = zeros(300,1);
temp2 = zeros(300,1);
temp3 = zeros(300,1);
for j = 1:20
    
    temp1_ = zeros(300,1);
    temp2_ = zeros(300,1);
    temp3_ = zeros(300,1);
    
    count = [0 0 0];
    for i = 1:Data(j).samples
        if Data(j).state(i) == '1' || Data(j).state(i) == '2'
            count(1) = count(1) + 1;
            temp1_ = temp1_ + abs(fft(Data(j).signal(:,i))).^2;
        elseif Data(j).state(i) == '3' || Data(j).state(i) == '4'
            count(2) = count(2) + 1;
            temp2_ = temp2_ + abs(fft(Data(j).signal(:,i))).^2;
        else
            count(3) = count(3) + 1;
            temp3_ = temp3_ + abs(fft(Data(j).signal(:,i))).^2;
        end
    end
    
    temp1 = temp1 + temp1_ / count(1);
    temp2 = temp2 + temp2_ / count(2);
    temp3 = temp3 + temp3_ / count(3);
    
end

temp1 = temp1(1:150);
temp2 = temp2(1:150);
temp3 = temp3(1:150);

plot(temp1,'blue')
hold on
plot(temp2,'red')
plot(temp3)