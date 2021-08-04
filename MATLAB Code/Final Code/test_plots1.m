%% scatter person features vs features_ma

person = 5;
figure(1)
a = Data(person).shallow_ma;
scatter3(a(1,:), a(2,:),a(3,:))
title('hjorth ma')
hold on
a = Data(person).deep_ma;
scatter3(a(1,:), a(2,:),a(3,:))
a = Data(person).other_ma;
%scatter3(a(1,:), a(2,:),a(3,:))


figure(2)
person = person+1;
a = Data(person).shallow_ma;
scatter3(a(1,:), a(2,:),a(3,:))
title('hjorth ma next')
hold on
a = Data(person).deep_ma;
scatter3(a(1,:), a(2,:),a(3,:))
a = Data(person).other_ma;
%scatter3(a(1,:), a(2,:),a(3,:))




figure(3)
person = person-1;
a = Data(person).shallow_ma;
scatter3(a(4,:), a(5,:),a(6,:))
title('powers ma')
hold on
a = Data(person).deep_ma;
scatter3(a(4,:), a(5,:),a(6,:))
a = Data(person).other_ma;
%scatter3(a(4,:), a(5,:),a(6,:))


figure(4)
person = person+1;
a = Data(person).shallow_ma;
scatter3(a(4,:), a(5,:),a(6,:))
title('powers ma next')
hold on
a = Data(person).deep_ma;
scatter3(a(4,:), a(5,:),a(6,:))
a = Data(person).other_ma;
%scatter3(a(4,:), a(5,:),a(6,:))
person = person-1;

%% same thing but with EVERYONE
% and one at a time so computer doesnt die
%% hjorth
for person = 1:20
    figure(1)
    title('hjorth')
    a = Data(person).shallow;
    scatter3(a(1,:), a(2,:),a(3,:), 'red')
    hold on
    a = Data(person).deep;
    scatter3(a(1,:), a(2,:),a(3,:), 'blue')
end

%% hjorth ma
for person = 1:20
    figure(2)
    title('hjorth ma')
    a = Data(person).shallow_ma;
    scatter3(a(1,:), a(2,:),a(3,:), 'red')
    hold on
    a = Data(person).deep_ma;
    scatter3(a(1,:), a(2,:),a(3,:), 'blue')
end

%% power 
for person = 1:20
    figure(3)
    title('powers')
    a = Data(person).shallow;
    scatter3(a(4,:), a(5,:),a(6,:), 'red')
    hold on
    a = Data(person).deep;
    scatter3(a(4,:), a(5,:),a(6,:), 'blue')
end
 
%% power ma
for person = 1:20
    figure(4)
    title('powers ma')
    a = Data(person).shallow_ma;
    scatter3(a(4,:), a(5,:),a(6,:), 'red')
    hold on
    a = Data(person).deep_ma;
    scatter3(a(4,:), a(5,:),a(6,:), 'blue')
end