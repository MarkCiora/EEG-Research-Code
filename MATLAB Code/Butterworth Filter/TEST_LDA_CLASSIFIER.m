%% asdf
clc
clear

%make 3 random distributions of data
s1 = 100;
s2 = 100;
s3 = 100;
s_tot = s1+s2+s3;

spread = 3;

x1(:,:) = randn(2,s1) + [spread; spread];
x2(:,:) = randn(2,s2) + [0; -spread];
x3(:,:) = randn(2,s3) + [-spread; 0];

figure(1)
hold on
scatter(x1(1,:),x1(2,:))
scatter(x2(1,:),x2(2,:))
scatter(x3(1,:),x3(2,:))


%calculate the means
x1_mean = [sum(x1(1,:)); sum(x1(2,:))] / s1;
x2_mean = [sum(x2(1,:)); sum(x2(2,:))] / s2;
x3_mean = [sum(x3(1,:)); sum(x3(2,:))] / s3;


%approximate covariance
scat = zeros(2);
for i = 1:s1
    scat = scat + (x1_mean - x1(:,i))*transpose(x1_mean - x1(:,i));
end
for i = 1:s2
    scat = scat + (x2_mean - x2(:,i))*transpose(x2_mean - x2(:,i));
end
for i = 1:s3
    scat = scat + (x3_mean - x3(:,i))*transpose(x3_mean - x3(:,i));
end


%3 equations in form y = x^Ta + b
a1= scat\x1_mean;
a2= scat\x2_mean;
a3= scat\x3_mean;

b1 = transpose(x1_mean)/scat*x1_mean + log(s1/s_tot);
b2 = transpose(x2_mean)/scat*x2_mean + log(s2/s_tot);
b3 = transpose(x3_mean)/scat*x3_mean + log(s3/s_tot);


%Graph these as planes in 3d
grid_in = -6:.05:6;
grid1 = zeros(241);
grid2 = grid1;
grid3 = grid1;
for i = 1:241
    for j = 1:241
        grid1(i,j) = [grid_in(i) grid_in(j)]*a1+b1;
        grid2(i,j) = [grid_in(i) grid_in(j)]*a2+b2;
        grid3(i,j) = [grid_in(i) grid_in(j)]*a3+b3;
    end
end

figure(2)
mesh(grid1)
hold on
mesh(grid2)
mesh(grid3)


%plot the discriminant lines in 2d
%x2=x1(a11-a12)/(a22-a21)+(b1-b2)/(a22-a21)
figure(1)
slope1 = (a1(1)-a2(1))/(a2(2)-a1(2))
yint1 = (b1-b2)/(a2(2)-a1(2))

line_input = [-6 6];
line1 = line_input*slope1 + yint1;

plot([-6 6],line1)


slope2 = (a2(1)-a3(1))/(a3(2)-a2(2))
yint2 = (b2-b3)/(a3(2)-a2(2))

line_input = [-6 6];
line2 = line_input*slope2 + yint2;

plot([-6 6],line2)


slope3 = (a3(1)-a1(1))/(a1(2)-a3(2))
yint3 = (b3-b1)/(a1(2)-a3(2))

line_input = [-6 6];
line3 = line_input*slope3 + yint3;

plot([-6 6],line3)

ylim([-6 6])