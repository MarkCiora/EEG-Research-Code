%% Run "read_first_20" before this

%% Testing
%0 : awake
%1 : shallow
%2 : deep
%3 : REM

%% Scatter
figure(1)
%scatter3(Data(j).scat_w(1,:),Data(j).scat_w(2,:),Data(j).scat_w(4,:),'green')
for j = 1:20
    scatter3(Data(j).scat_s(1,:,1),Data(j).scat_s(4,:,1),Data(j).scat_s(3,:,1),'red')
    hold on
    scatter3(Data(j).scat_d(1,:,1),Data(j).scat_d(4,:,1),Data(j).scat_d(3,:,1),'magenta')
    hold on
    scatter3(Data(j).scat_r(1,:,1),Data(j).scat_r(4,:,1),Data(j).scat_r(3,:,1),'blue')
end
legend({'red = shallow','magenta = deep','blue = REM'},'Location','southwest')

%% Scatter with POWER TOTALS
figure(2)
%scatter3(Data(j).scat_w(1,:),Data(j).scat_w(2,:),Data(j).scat_w(4,:),'green')
for j = 1:20
    %scatter3(Data(j).scat_w(1,:,1),Data(j).scat_w(4,:,1),Data(j).scat_w(1,:,2),'green')
    %hold on
    scatter3(Data(j).scat_s(1,:,1),Data(j).scat_s(3,:,1),Data(j).scat_s(1,:,2),'red')
    hold on
    scatter3(Data(j).scat_d(1,:,1),Data(j).scat_d(3,:,1),Data(j).scat_d(1,:,2),'magenta')
    hold on
    scatter3(Data(j).scat_r(1,:,1),Data(j).scat_r(3,:,1),Data(j).scat_r(1,:,2),'blue')
end
legend({'red = shallow','magenta = deep','blue = REM'},'Location','southwest')
zlim([0 2000])
hold off

%% Scatter it all
figure(3)
for j = 1:20
    scatter(Data(j).rel(1,:), Data(j).rel(4,:))
    hold on
end
hold off

%% Calculate histogram of power data
bins = zeros(4,300,4);

for j = 1:20
    for i = 1:width(Data(j).state)
        for k = 1:4
            switch Data(j).state(i)
                case 0
                    bins(k,round(Data(j).rel(k,i)*300+0.5),1) = bins(k,round(Data(j).rel(k,i)*300+0.5),1) + 1;
                case 1
                    bins(k,round(Data(j).rel(k,i)*300+0.5),2) = bins(k,round(Data(j).rel(k,i)*300+0.5),2) + 1;                    
                case 2
                    bins(k,round(Data(j).rel(k,i)*300+0.5),3) = bins(k,round(Data(j).rel(k,i)*300+0.5),3) + 1;                    
                case 3
                    bins(k,round(Data(j).rel(k,i)*300+0.5),4) = bins(k,round(Data(j).rel(k,i)*300+0.5),4) + 1;                    
            end
        end
    end
end
    

%% Plot the histogram
figure(1)
for k = 1:4
    subplot(4,1,k)
    hold on
    plot(0:1/300:1-1/300,bins(k,:,1)/sum(bins(k,:,1)),'green')
end

for k = 1:4
    subplot(4,1,k)
    hold on
    plot(0:1/300:1-1/300,bins(k,:,2)/sum(bins(k,:,2)),'red')
end

for k = 1:4
    subplot(4,1,k)
    hold on
    plot(0:1/300:1-1/300,bins(k,:,3)/sum(bins(k,:,3)),'magenta')
end

for k = 1:4
    subplot(4,1,k)
    hold on
    plot(0:1/300:1-1/300,bins(k,:,4)/sum(bins(k,:,4)),'blue')
end
legend({'green = awake','red = shallow','magenta = deep','blue = REM'},'Location','southwest')

%% Delta and Beta in isolation
figure(1)
hold on
plot(bins(4,:,1)/sum(bins(4,:,1)),'green')
plot(bins(4,:,2)/sum(bins(4,:,2)),'red')
plot(bins(4,:,3)/sum(bins(4,:,3)),'magenta')
plot(bins(4,:,4)/sum(bins(4,:,4)),'blue')
legend({'green = awake','red = shallow','magenta = deep','blue = REM'},'Location','southwest')
