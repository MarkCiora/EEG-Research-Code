%% Subgradient Descent

%% Make 2-D-input function (paraboloid)
clc
clear

%Create a 2-D space from -2 to 2 in both input directions
x_in(1,:) = -2:.2:2;
x_in(2,:) = x_in(1,:);

f_out = zeros(length(x_in(1,:)),length(x_in(1,:)));
for i = 1:length(x_in(1,:))
    for j = 1:length(x_in(1,:))
        f_out(i,j) = x_in(1,i)^2 + x_in(2,j)^2;
    end
end

%% Plot the 2-D-input function
mesh(-2:.2:2,-2:.2:2,f_out)

%% Gradient method
step_size = .1;
min = rand(2,1);
cur = min;
vals(:,i)=cur;
for i = 1:1000
    %Calculate the gradient
    grad = [2*cur(1);2*cur(2)]
    cur = cur - step_size*grad;
    if cur(1)^2 + cur(2)^2 >= min(1)^2 + min(2)^2
        break
    end
    vals(:,i+1) = cur;
    min = cur;
end


%% plot
mesh(-2:.05:2,-2:.05:2,f_out)
hold on
plot3(vals(1,:),vals(2,:), vals(1,:).^2 + vals(2,:).^2, 'red')




%% SVM attempt
% min |w|^2/2 + c/n * sum(max(0,1-yi(xiT*w + b))

w(:,1) = transpose(-2:.01:2);
w(:,2) = transpose(-2:.01:2);
c=2;
for i = 1:length(w(:,1))
    for j = 1:length(w(:,2))
        f_w(i,j) = abs(w(i,1).^2+w(j,2).^2)/2 + 2*c/3*max(0, 1-abs(w(i,1)+w(j,2)));
        f_w(i,j) = f_w(i,j) + c/3*max(0,1-abs(2*w(i,1)+2*w(j,2)));
    end
end
mesh(-2:.01:2,0:.01:2,f_w(201:401,:))



%% SVM 1-d w input
clc
clear
w = -3:.1:3;
b = -6:.1:6;
c=10;
for i = 1:length(w(:))
    for j = 1:length(b(:))
        f_w(i,j) = w(i)^2/2 + (c/2)*max(0,1-(2*w(i)+b(j))) + (c/2)*max(0,1+(1*w(i)+b(j)));
        %f_w(i,j) = max(0,1-(1*w(i) + b(j)));
    end
end

figure(9)
mesh(b,w,f_w);
xlabel('b')
ylabel('w')
zlabel('f')
axis([-6 6 -3 3 0 20])

%% SVM 2-d input w,b (w scalar)
clc
clear
c=1;
size = 2;
x = rand(size,2);
y = x(:,1);
av = sum(x) / size;
for i = 1:size
    if y(i,1) > av(1)
        y(i,1) = 1;
    else
        y(i,1) = -1;
    end
end

%% plot
figure(1)
hold on
for i = 1:size
    if y(i) == 1
        scatter(x(i,1),x(i,2),'blue')
    else
        scatter(x(i,1),x(i,2),'red')
    end
end
hold off

out = zeros(81);
figure(2)
for inc1 = 1:81
    for inc2 = 1:81
        out(inc1,inc2) = (((inc1-1)/20-2)^2 +((inc2-1)/20-2)^2)/2;
        for inc3 = 1:size
            out(inc1,inc2) = out(inc1,inc2) + 10*(c/size)*max(0,1-(y(inc3)*(x(inc3,:)*[(inc1-1)/20-2;(inc2-1)/20-2]-2))); 
        end
    end
end
bout = zeros(81,1)
for inc1 = 1:81
    for inc2 = 1:size
        bout(inc1) = bout(inc1) + c/size*max(0,1-y(inc2)*(x(inc2,:)*[1; 1]+(inc1-1)/20-2));
    end
end
mesh(-2:.05:2,-2:.05:2,out)
figure(3)
plot(-2:.05:2,bout)

%% sub-gradient descent
step_ratio = .03 %this * gradient = step size
w = [0;0]; %initialize w
b = 0;
dim = 2;

grad = [1;1;1]
while sqrt(transpose(grad)*grad) > .0001
    grad = [w(1);w(2);0];
    for j = 1:dim
        for i = 1:size 
            grad(j) = grad(j) - (c/size)*(y(i)*x(i,j)*SVM_indicator(w,transpose(x(i,:)),b,y(i)));
        end
    end
    for i = 1:size
        grad(3) = grad(3) + (c/size)*(y(i)*SVM_indicator(w,transpose(x(i,:)),b,y(i)));
    end
    w = w - step_ratio*[grad(1);grad(2)];
    b = b + step_ratio*grad(3);
end

%% plot the line
















%% SVM 1-d input w,b (w scalar)
clc
clear
size = 15;
asdf=100;
c=100/asdf;
x = rand(size,1);
x = x*asdf;
y = x(:,1);
av = sum(x) / size;
for i = 1:size
    if y(i,1) > av
        y(i,1) = 1;
    else
        y(i,1) = -1;
    end
end

%% plot
figure(1)
hold on
for i = 1:size
    if y(i) == 1
        scatter(0,x(i,1),'blue')
    else
        scatter(0,x(i,1),'red')
    end
end
hold off

%% fd
out = zeros(81);
figure(2)
w_co=2;
b_co=4*asdf;
for inc1 = 1:81
    for inc2 = 1:81
        %out(inc1,inc2) = 0;
        out(inc1,inc2) = (((inc1-1)/20-2)^2)/2;
        for inc3 = 1:size
            w = w_co*((inc1-1)/20-2)
            b = b_co*((inc2-1)/20-2)
            out(inc1,inc2) = out(inc1,inc2) + (c/size)*max(0,1-y(inc3)*(x(inc3)*w+b)); 
        end
    end
end
mesh(b_co*-2:b_co*.05:b_co*2,w_co*-2:w_co*.05:w_co*2,out)
xlabel('b')
ylabel('w')
%figure(3)
%plot(-6:.15:6,out(41,:))

%% asdf
b = 0;
w = 0;
grad_w = 1
grad_b = 0;
step_ratio = .0001/c;

j = 1;
while 1 == 1
    grad_w = w;
    grad_b = 0;
    for i = 1:size
        grad_w = grad_w - (c/size)*(y(i)*x(i)*SVM_indicator(w,x(i),b,y(i)));
        grad_b = grad_b - (c/size)*(y(i)*SVM_indicator(w,x(i),b,y(i)));
    end
    w = w - grad_w*step_ratio;
    b = b - grad_b*step_ratio;
    j = j + 1;
    if j > 1000000
        break
    end
end


%% more plotting
figure(1)
hold on;
scatter(.1,-b/w,'green')
scatter(.1,(1-b)/w,'cyan')
scatter(.1,(-1-b)/w,'cyan')
xlim([-1 1])
hold off