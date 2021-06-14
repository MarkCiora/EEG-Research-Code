%% 3D
clc
clear

% 3 by size matrices with random gaussian variables
size1 = 10;
size2 = 10;
x1 = rand(3,size1)+rand(1);
x2 = rand(3,size2)+rand(1);

for i = 1:3
   x1(i,:) = x1(i,:)*2*rand(1);
   x2(i,:) = x2(i,:)*2*rand(1); 
end

% means
x1_mean = [sum(x1(1,:)); sum(x1(2,:)); sum(x1(3,:))] / size1;
x2_mean = [sum(x2(1,:)); sum(x2(2,:)); sum(x2(3,:))] / size2;
mean = (x1_mean + x2_mean)/2;

% scatter matrices
x1_scat_w = zeros(3,3);
x2_scat_w = zeros(3,3);

for i = 1:size1
    x1_scat_w = x1_scat_w + (x1_mean - x1(:,i))*transpose(x1_mean - x1(:,i));
end

for i = 1:size2
    x2_scat_w = x2_scat_w + (x2_mean - x2(:,i))*transpose(x2_mean - x2(:,i));
end

x1_scat_b = size1*(x1_mean-mean)*transpose(x1_mean-mean);
x2_scat_b = size2*(x2_mean-mean)*transpose(x2_mean-mean);

scat_w = x1_scat_w + x2_scat_w
scat_b = x1_scat_b + x2_scat_b

maximize = scat_b/scat_w

[vecs, vals] = eig(maximize)
vecs = vecs*vals;

% plotting
scatter3(x1(1,:),x1(2,:),x1(3,:))
hold on;
scatter3(x2(1,:),x2(2,:),x2(3,:))
scatter3(x1_mean(1),x1_mean(2),x1_mean(3),'blue','filled')
scatter3(x2_mean(1),x2_mean(2),x2_mean(3),'red','filled')

plot3([-vecs(1,1) vecs(1,1)]+mean(1),[-vecs(2,1) vecs(2,1)]+mean(2),[-vecs(3,1) vecs(3,1)]+mean(3))
plot3([-vecs(1,2) vecs(1,2)]+mean(1),[-vecs(2,2) vecs(2,2)]+mean(2),[-vecs(3,2) vecs(3,2)]+mean(3))
plot3([-vecs(1,3) vecs(1,3)]+mean(1),[-vecs(2,3) vecs(2,3)]+mean(2),[-vecs(3,3) vecs(3,3)]+mean(3))
ylim([-5 5])
xlim([-5 5])
zlim([-5 5])
hold off;

%project it onto the greater eigenvector
if vals(1,1) > vals(2,2)
    col = 1; 
elseif vals(2,2) > vals(3,3)
    col = 2;
else
    col = 3;
end

out1 = transpose(vecs(:,col))*x1
out2 = transpose(vecs(:,col))*x2

figure(2)
hold on;
scatter(out1,zeros(1,size1))
scatter(out2,zeros(1,size2))


%% 2D
clc
clear

% 2 by size matrices with random variables
size1 = 20;
size2 = 20;
x1 = randn(2,size1);
x2 = randn(2,size2);

x1(2,:) = x1(2,:)-1;
x1(1,:) = x1(1,:)-1;
x2(2,:) = x2(2,:)+1;
x2(1,:) = x2(1,:)+1;

% means
x1_mean = [sum(x1(1,:)); sum(x1(2,:))] / size1;
x2_mean = [sum(x2(1,:)); sum(x2(2,:))] / size2;
mean = (x1_mean + x2_mean) / 2;

% scatter matrices
x1_scat_w = zeros(2,2);
x2_scat_w = zeros(2,2);
x1_scat_b = zeros(2,2);
x2_scat_b = zeros(2,2);

for i = 1:size1
    x1_scat_w = x1_scat_w + (x1_mean - x1(:,i))*transpose(x1_mean - x1(:,i));
end

for i = 1:size2
    x2_scat_w = x2_scat_w + (x2_mean - x2(:,i))*transpose(x2_mean - x2(:,i));
end

x1_scat_b = x1_scat_b + size1*(x1_mean-mean)*transpose(x1_mean-mean);
x2_scat_b = x2_scat_b + size2*(x2_mean-mean)*transpose(x2_mean-mean);

scat_w = x1_scat_w + x2_scat_w
scat_b = x1_scat_b + x2_scat_b

maximize = scat_b/scat_w

[vecs,vals] = eig(maximize)
vecs = vecs*vals


% plotting
figure(1)
hold on;
scatter(x1(1,:),x1(2,:))
scatter(x2(1,:),x2(2,:))
scatter(x1_mean(1),x1_mean(2),'blue','filled')
scatter(x2_mean(1),x2_mean(2),'red','filled')

plot([-vecs(1,1) vecs(1,1)],[-vecs(2,1) vecs(2,1)])
plot([-vecs(1,2) vecs(1,2)],[-vecs(2,2) vecs(2,2)])
%ylim([-20 30])
%xlim([-20 30])
hold off;

%project it onto the greater eigenvector
if vals(1,1) > vals(2,2)
    col = 1; 
else
    col = 2;
end

out1 = transpose(vecs(:,col))*x1
out2 = transpose(vecs(:,col))*x2

figure(2)
hold on;
scatter(out1,zeros(1,size1))
scatter(out2,zeros(1,size2))

%% n-Dim, m classes ONLY USE 3 DIM FOR NOW
clc
clear

n = 3;
m = 4;

% n by size matrices with random gaussian variables
size = 15;
x = zeros([n size m]);
for i = 1:m
x(:,:,i) = rand(n,size)+2*rand(n,1);
end

for j = 1:m
for i = 1:n
   x(i,:,m) = x(i,:,j)*2*rand(1);
end
end

% means
x_mean = zeros([n m]);
for j = 1:m
for i = 1:n
    x_mean(i,j) = sum(x(i,:,j))/size; 
end
end

mean = zeros([n 1]);
for i = 1:n
    mean(i) = sum(x_mean(i,:));
end
mean = mean/size;

% scatter matrices
scat_w = zeros(n,n);
for i = 1:size
for j = 1:m
    scat_w = scat_w + (x_mean(:,j)-x(:,i,j))*transpose(x_mean(:,j)-x(:,i,j));
end
end

scat_b = zeros(n,n);
for i = 1:m
    scat_b = scat_b + size * (x_mean(:,i) - mean) * transpose(x_mean(:,i) - mean); 
end

maximize = scat_b/scat_w

[vecs, vals] = eig(maximize)
vecs = vecs*vals;


for i = 1:m
    out1(1,:,i) = transpose(vecs(:,1))*x(:,:,i);
end
figure(2)
hold on
scatter(out1(1,:,1),zeros(1,size)+1,'blue')
scatter(out1(1,:,2),zeros(1,size)+2,'red')
scatter(out1(1,:,3),zeros(1,size)+3,'magenta')
scatter(out1(1,:,4),zeros(1,size)+4,'green')
scatter(sum(out1(1,:,1))/size,1,'blue','filled')
scatter(sum(out1(1,:,2))/size,2,'red','filled')
scatter(sum(out1(1,:,3))/size,3,'magenta','filled')
scatter(sum(out1(1,:,4))/size,4,'green','filled')
hold off
ylim([0 m+1])

for i = 1:m
    out2(1,:,i) = transpose(vecs(:,2))*x(:,:,i);
end
figure(3)
hold on
scatter(out2(1,:,1),zeros(1,size)+1,'blue')
scatter(out2(1,:,2),zeros(1,size)+2,'red')
scatter(out2(1,:,3),zeros(1,size)+3,'magenta')
scatter(out2(1,:,4),zeros(1,size)+4,'green')
scatter(sum(out2(1,:,1))/size,1,'blue','filled')
scatter(sum(out2(1,:,2))/size,2,'red','filled')
scatter(sum(out2(1,:,3))/size,3,'magenta','filled')
scatter(sum(out2(1,:,4))/size,4,'green','filled')
hold off
ylim([0 m+1])

figure(4)

% plot in 3d
figure(1)
scatter3(x(1,:,1),x(2,:,1),x(3,:,1),'blue')
hold on
scatter3(x(1,:,2),x(2,:,2),x(3,:,2),'red')
scatter3(x(1,:,3),x(2,:,3),x(3,:,3),'magenta')
scatter3(x(1,:,4),x(2,:,4),x(3,:,4),'green')

scatter3(x_mean(1,1),x_mean(2,1),x_mean(3,1),'blue','filled');
scatter3(x_mean(1,2),x_mean(2,2),x_mean(3,2),'red','filled');
scatter3(x_mean(1,3),x_mean(2,3),x_mean(3,3),'magenta','filled');
scatter3(x_mean(1,4),x_mean(2,4),x_mean(3,4),'green','filled');
hold off;


%% n-Dim, m classes

clc
clear

n = 10;
m = 4;

% n by size matrices with random gaussian variables
size = 100;
x = zeros([n size m]);
for i = 1:m
x(:,:,i) = rand(n,size)+2*rand(n,1);
end

for j = 1:m
for i = 1:n
   x(i,:,m) = x(i,:,j)*2*rand(1);
end
end

% means
x_mean = zeros([n m]);
for j = 1:m
for i = 1:n
    x_mean(i,j) = sum(x(i,:,j))/size; 
end
end

mean = zeros([n 1]);
for i = 1:n
    mean(i) = sum(x_mean(i,:));
end
mean = mean/size;

% scatter matrices
scat_w = zeros(n,n);
for i = 1:size
for j = 1:m
    scat_w = scat_w + (x_mean(:,j)-x(:,i,j))*transpose(x_mean(:,j)-x(:,i,j));
end
end

scat_b = zeros(n,n);
for i = 1:m
    scat_b = scat_b + size * (x_mean(:,i) - mean) * transpose(x_mean(:,i) - mean); 
end

maximize = scat_b/scat_w;

[vecs, vals] = eig(maximize);
vecs = vecs*vals;

for j = 1:min(3,(n-1))
for i = 1:m
    out(1,:,i) = transpose(vecs(:,j))*x(:,:,i);
end
figure(j+2)
hold on
for i = 1:m
    scatter(out(1,:,i),zeros(1,size)+i)
end
hold off
ylim([0 m+1])
end

%% scatters of last 2 and last 3 projections
figure(1)
hold on
for i = 1:m
    out1(1,:,i) = transpose(vecs(:,1))*x(:,:,i);
    out2(1,:,i) = transpose(vecs(:,2))*x(:,:,i);
    out3(1,:,i) = transpose(vecs(:,3))*x(:,:,i);
end
for i = 1:m
    scatter(out1(1,:,i),out2(1,:,i))
end

figure(2)
clf(2)
for i = 1:m
    scatter3(out1(1,:,i),out2(1,:,i),out3(1,:,i))
    hold on
end