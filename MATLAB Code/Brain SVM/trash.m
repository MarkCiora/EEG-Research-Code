%% quick plot ULTIMATE
j = 17;
figure(j)
scatter3(C(j).s_o2(1,:),C(j).s_o2(2,:),C(j).s_o2(3,:))
hold on
scatter3(C(j).d_o2(1,:),C(j).d_o2(2,:),C(j).d_o2(3,:))
scatter3(0,0,0)

j = j+1;
figure(j)
scatter3(C(j).s_o2(1,:),C(j).s_o2(2,:),C(j).s_o2(3,:))
hold on
scatter3(C(j).d_o2(1,:),C(j).d_o2(2,:),C(j).d_o2(3,:))
scatter3(0,0,0)


%% quick plot ma
j = 1;
figure(j)
hold off
scatter3(B(j).s_o2_ma(1,:),B(j).s_o2_ma(2,:),B(j).s_o2_ma(3,:))
hold on
scatter3(B(j).d_o2_ma(1,:),B(j).d_o2_ma(2,:),B(j).d_o2_ma(3,:))
%scatter3(B(j).w_o2_ma(1,:),B(j).w_o2_ma(2,:),B(j).w_o2_ma(3,:))
%scatter3(B(j).r_o2_ma(1,:),B(j).r_o2_ma(2,:),B(j).r_o2_ma(3,:))

j = j+1;
figure(j)
hold off
scatter3(B(j).s_o2_ma(1,:),B(j).s_o2_ma(2,:),B(j).s_o2_ma(3,:))
hold on
scatter3(B(j).d_o2_ma(1,:),B(j).d_o2_ma(2,:),B(j).d_o2_ma(3,:))
%scatter3(B(j).w_o2_ma(1,:),B(j).w_o2_ma(2,:),B(j).w_o2_ma(3,:))
%scatter3(B(j).r_o2_ma(1,:),B(j).r_o2_ma(2,:),B(j).r_o2_ma(3,:))

%%
figure(1)
j = 1;
scatter3(0,0,0)
xlim([-35 10])
ylim([0 25])
zlim([-20 10])
%%
hold off
xlim([-35 10])
ylim([0 25])
zlim([-20 10])
scatter3(B(j).w_o2_ma(1,:),B(j).w_o2_ma(2,:),B(j).w_o2_ma(3,:))
%%
hold off
xlim([-35 10])
ylim([0 25])
zlim([-20 10])
scatter3(B(j).s_o2_ma(1,:),B(j).s_o2_ma(2,:),B(j).s_o2_ma(3,:))
%%
hold off
xlim([-35 10])
ylim([0 25])
zlim([-20 10])
scatter3(B(j).d_o2_ma(1,:),B(j).d_o2_ma(2,:),B(j).d_o2_ma(3,:))
%%
hold off
xlim([-35 10])
ylim([0 25])
zlim([-20 10])
scatter3(B(j).r_o2_ma(1,:),B(j).r_o2_ma(2,:),B(j).r_o2_ma(3,:))

