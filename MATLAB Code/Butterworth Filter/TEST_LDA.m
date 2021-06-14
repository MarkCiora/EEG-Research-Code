%%
clc
clear

size1 = 20;
size2 = 20;
x1 = rand(3,size1) - 0.5;
x2 = rand(3,size2) + 0.5;
x1av = [sum(x1(1,:)) sum(x1(2,:)) sum(x1(3,:))] / size1;
x2av = [sum(x2(1,:)) sum(x2(2,:)) sum(x2(3,:))] / size2;

scatter3(x1(1,:), x1(2,:), x1(3,:))
hold on;
scatter3(x2(1,:), x2(2,:), x2(3,:))

scatter3(x1av(1), x1av(2), x1av(3),'blue','filled')
scatter3(x2av(1), x2av(2), x2av(3),'red','filled')
plot3([x1av(1) x2av(1)], [x1av(2) x2av(2)], [x1av(3) x2av(3)])

%% stuff
diff = x2av - x1av;

proj1 = diff*x1;
proj2 = diff*x2;

proj1av = sum(proj1)/size1;
proj2av = sum(proj2)/size2;

figure(2);

z1 = zeros(1,size1);
z2 = zeros(1,size2);

hold on
scatter(proj1, z1, 25);
scatter(proj2, z2, 25);
scatter(proj1av, 0, 50, 'blue', 'filled')
scatter(proj2av, 0, 50, 'red', 'filled')

%% scatter matrix

scatmatwithin = zeros(3,3);

for i = 1:size1
	scatmatwithin = scatmatwithin + (x1(:,i)-x1av)*transpose(x1(:,i)-x1av);
end

for i = 1:size2
	scatmatwithin = scatmatwithin + (x2(:,i)-x1av)*transpose(x2(:,i)-x1av);
end

av = (x1av + x2av) / 2
scatmatbetween = size1*(x1av-av)*transpose(x1av-av);
scatmatbetween = scatmatbetween + size2*(x2av-av)*transpose(x2av-av);


%% asdfasdfasdfasdfasdfasfasdfasdfasd
clc
clear

x1 = rand(1,10);
x2 = rand(1,10)+.5;
y1 = rand(1,10);
y2 = rand(1,10)+.5;
%% a
x1av = sum(x1)/10;
y1av = sum(y1)/10;
x2av = sum(x2)/10;
y2av = sum(y2)/10;

figure(1)
scatter(x1,y1,25);
hold on;
scatter(x2,y2,25,'red');
scatter(x1av,y1av,50,'blue','filled');
scatter(x2av,y2av,50,'red','filled');
plot([x1av x2av], [y1av y2av])

ylim([0 1.5])
xlim([0 1.5])

diff = [x2av-x1av y2av-y1av]
%% a
out1 = (x1-x1av)*diff(1)+(y1-y1av)*diff(2);
out2 = (x2-x1av)*diff(1)+(y2-y1av)*diff(2);
out1av = sum(out1)/10;
out2av = sum(out2)/10;
out1avtrue=x1av+y1av*diff(2)/diff(1);
out2avtrue=x2av+y2av*diff(2)/diff(1);
z = zeros(1,10);

figure(2)
hold on;
scatter(out1,z+.1,25);
scatter(out2,z-.1,25,'red');
scatter(out1av,z+.1,50,'blue','filled');
scatter(out2av,z-.1,50,'red','filled');
ylim([-2 2])
hold off;

%% a

out1 = (x1)*diff(1)+(y1)*diff(2);
out2 = (x2)*diff(1)+(y2)*diff(2);
out1av = sum(out1)/10;
out2av = sum(out2)/10;
out1avtrue=x1av+y1av*diff(2)/diff(1);
out2avtrue=x2av+y2av*diff(2)/diff(1);
z = zeros(1,10);

figure(3)
hold on;
scatter(out1,z+.1,25,1:10);
scatter(out2,z-.1,25,'red');
scatter(out1av,z+.1,50,'blue','filled');
scatter(out2av,z-.1,50,'red','filled');
ylim([-2 2])
hold off