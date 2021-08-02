%% quick plot default
j = 1;
figure(j)
scatter3(A(j).s_o2(1,:,1),A(j).s_o2(1,:,2),A(j).s_o2(1,:,3))
hold on
scatter3(A(j).d_o2(1,:,1),A(j).d_o2(1,:,2),A(j).d_o2(1,:,3))

j = j+1;
figure(j)
scatter3(A(j).s_o2(1,:,1),A(j).s_o2(1,:,2),A(j).s_o2(1,:,3))
hold on
scatter3(A(j).d_o2(1,:,1),A(j).d_o2(1,:,2),A(j).d_o2(1,:,3))

%% quick plot ma
j = 1;
figure(j)
scatter3(A(j).s_o2_ma(1,:,1),A(j).s_o2_ma(1,:,2),A(j).s_o2_ma(1,:,3))
hold on
scatter3(A(j).d_o2_ma(1,:,1),A(j).d_o2_ma(1,:,2),A(j).d_o2_ma(1,:,3))

j = j+1;
figure(j)
scatter3(A(j).s_o2_ma(1,:,1),A(j).s_o2_ma(1,:,2),A(j).s_o2_ma(1,:,3))
hold on
scatter3(A(j).d_o2_ma(1,:,1),A(j).d_o2_ma(1,:,2),A(j).d_o2_ma(1,:,3))

%% quick plot skip trans
j = 1;
figure(j)
scatter3(A(j).s_o2_refined(1,:,1),A(j).s_o2_refined(1,:,2),A(j).s_o2_refined(1,:,3))
hold on
scatter3(A(j).d_o2_refined(1,:,1),A(j).d_o2_refined(1,:,2),A(j).d_o2_refined(1,:,3))

j = j+1;
figure(j)
scatter3(A(j).s_o2_refined(1,:,1),A(j).s_o2_refined(1,:,2),A(j).s_o2_refined(1,:,3))
hold on
scatter3(A(j).d_o2_refined(1,:,1),A(j).d_o2_refined(1,:,2),A(j).d_o2_refined(1,:,3))