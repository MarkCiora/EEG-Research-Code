%% scatter first person features vs features_ma
a = Data(1).features;

figure(1)
scatter3(a(1,:), a(2,:),a(3,:))

a = Data(1).features_ma;
figure(2)
scatter3(a(1,:), a(2,:),a(3,:))