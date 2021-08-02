%% Randomly permutate the data
% Only shallow and deep sleep are used
% This will only use person 1
size = Data(1).num(2) + Data(1).num(3);
xy = [Data(1).scat_s(:,:,1) Data(1).scat_d(:,:,1); zeros(1,Data(1).num(2))+1 zeros(1,Data(1).num(3))-1];
rand_num = randperm(size);
temp = xy;

for i = 1:size
    xy(:,i) = temp(:,rand_num(i));
end
clear temp
clear rand_num
x = xy(1:4,:);
y = xy(5,:);
clear xy
clear i

%% Randomly permutate the data
% Only awake and deep sleep are used
% This will only use person 1
size = Data(1).num(1) + Data(1).num(3);
xy = [Data(1).scat_w(:,:,1) Data(1).scat_d(:,:,1); zeros(1,Data(1).num(1))+1 zeros(1,Data(1).num(3))-1];
rand_num = randperm(size);
temp = xy;

for i = 1:size
    xy(:,i) = temp(:,rand_num(i));
end
clear temp
clear rand_num
x = xy(1:4,:);
y = xy(5,:);
clear xy
clear i

%% Randomly permutate the data
% ALL AWAKE AND DEEP SLEEP DATA USED
size = 0;
shallow_size = 0;
deep_size = 0;
shallow_set = [];
deep_set = [];
for j = 1:20
    size = size + Data(j).num(2) + Data(j).num(3);
    shallow_size = shallow_size + Data(j).num(2);
    deep_size = deep_size + Data(j).num(3);
    shallow_set = [shallow_set Data(j).scat_s(:,:,1)];
    deep_set = [deep_set Data(j).scat_d(:,:,1)];
end
%Data(1).scat_w(:,:,1) Data(1).scat_d(:,:,1)
    
xy = [shallow_set deep_set; zeros(1,shallow_size)+1 zeros(1,deep_size)-1];
rand_num = randperm(size);
temp = xy;

for i = 1:size
    xy(:,i) = temp(:,rand_num(i));
end
clear temp
clear rand_num
x = xy(1:4,:);
y = xy(5,:);
clear xy
clear i

%% Randomly permutate the data, except 20
% ALL AWAKE AND DEEP SLEEP DATA USED
size = 0;
shallow_size = 0;
deep_size = 0;
shallow_set = [];
deep_set = [];
for j = 1:19
    size = size + Data(j).num(2) + Data(j).num(3);
    shallow_size = shallow_size + Data(j).num(2);
    deep_size = deep_size + Data(j).num(3);
    shallow_set = [shallow_set Data(j).scat_s(:,:,1)];
    deep_set = [deep_set Data(j).scat_d(:,:,1)];
end
%Data(1).scat_w(:,:,1) Data(1).scat_d(:,:,1)
    
xy = [shallow_set deep_set; zeros(1,shallow_size)+1 zeros(1,deep_size)-1];
rand_num = randperm(size);
temp = xy;

for i = 1:size
    xy(:,i) = temp(:,rand_num(i));
end
clear temp
clear rand_num
x = xy(1:4,:);
y = xy(5,:);
clear xy
clear i

%% Randomly permutate the data, except 20
% ALL SHALLOW AND DEEP
size = 0;
shallow_size = 0;
deep_size = 0;
shallow_set = [];
deep_set = [];
for j = 1:19
    size = size + Data(j).num(2) + Data(j).num(3);
    shallow_size = shallow_size + Data(j).num(2);
    deep_size = deep_size + Data(j).num(3);
    shallow_set = [shallow_set Data(j).scat_s(:,:,1)];
    deep_set = [deep_set Data(j).scat_d(:,:,1)];
end
%Data(1).scat_w(:,:,1) Data(1).scat_d(:,:,1)
    
xy = [shallow_set(1:4,1:2900) deep_set(1:4,1:2900); zeros(1,2900)+1 zeros(1,2900)-1];
size = 2900*2;
rand_num = randperm(size);
temp = xy;

for i = 1:size
    xy(:,i) = temp(:,rand_num(i));
end
clear temp
clear rand_num
x = xy(1:4,:);
y = xy(5,:);
clear xy
clear i

%% Randomly permutate the data, except 20
% ALL AWAKE AND DEEP SLEEP DATA USED
size = 0;
awake_size = 0;
deep_size = 0;
awake_set = [];
deep_set = [];
for j = 1:19
    size = size + Data(j).num(2) + Data(j).num(3);
    awake_size = awake_size + Data(j).num(2);
    deep_size = deep_size + Data(j).num(3);
    awake_set = [awake_set Data(j).scat_w(:,:,1)];
    deep_set = [deep_set Data(j).scat_d(:,:,1)];
end
%Data(1).scat_w(:,:,1) Data(1).scat_d(:,:,1)
    
xy = [awake_set(1:4,1:2900) deep_set(1:4,1:2900); zeros(1,2900)+1 zeros(1,2900)-1];
size = 2900*2;
rand_num = randperm(size);
temp = xy;

for i = 1:size
    xy(:,i) = temp(:,rand_num(i));
end
clear temp
clear rand_num
x = xy(1:4,:);
y = xy(5,:);
clear xy
clear i

%% Randomly permutate the data, except 20
% ALL AWAKE AND DEEP SLEEP DATA USED
size = 400;
    
xy = [Data(1).scat_s(:,1:200,1) Data(1).scat_d(:,1:200,1); zeros(1,200)+1 zeros(1,200)-1];
rand_num = randperm(size);
temp = xy;

for i = 1:size
    xy(:,i) = temp(:,rand_num(i));
end
clear temp
clear rand_num
x = xy(1:4,:);
y = xy(5,:);
clear xy
clear i

%% Randomly permutate the data, except 20
% ALL AWAKE AND DEEP SLEEP DATA USED
size = 0;
shallow_size = 500;
deep_size = 500;
shallow_set = [];
deep_set = [];
for j = 1:10
    shallow_set = [shallow_set Data(j).scat_w(:,1:50,1)];
    deep_set = [deep_set Data(j).scat_d(:,1:50,1)];
end
    
xy = [shallow_set(:,:) deep_set(:,:); zeros(1,shallow_size)+1 zeros(1,deep_size)-1];
size = shallow_size + deep_size;
rand_num = randperm(size);
temp = xy;

for i = 1:size
    xy(:,i) = temp(:,rand_num(i));
end
clear temp
clear rand_num
x = xy(1:4,:);
y = xy(5,:);
clear xy
clear i

%% Split data to 5 quadrants for 80-20 train-test split
x_split = split_80_20_SVM(x,y,size);

%% Subgradient descent to discover w and b in selected nonlinear space
clc
clear train
clear test
clear i
clear j
accuracy = zeros(4,5);
for i = 1:5
    train.x = [];
    train.y = [];
    for j = 1:5
        if i == j
            continue
        end
        train.x = [train.x x_split(j).x];
        train.y = [train.y x_split(j).y];
    end
    test.x = x_split(i).x;
    test.y = x_split(i).y;
    
    %SUBGRADIENT DESCENT GOES HERE
    val = 1;
    type = 'rbf';
    [out(i).w out(i).b] = subgradient_descent_step_change(train.x, train.y, 1000000, type, val);
    
    %TEST IT
    accuracy(:,i) = test_SVM_accuracy(out(i).w, out(i).b, test.x, test.y, type, val);
    output = i
end
clear i
clear j


%% Test classifier against all
accuracy_sum = [0;0;0;0];
for j = 11:20
    x_20th = [Data(j).scat_s(:,1:53,1) Data(j).scat_d(:,1:53,1)];
    y_20th = [zeros(1, 53)+1 zeros(1, 53)-1];
    accuracy_20th = test_SVM_accuracy(out(2).w, out(2).b, x_20th, y_20th, type, val);
    accuracy_tot(:,j-10) = accuracy_20th;
    accuracy_sum = accuracy_sum + accuracy_20th;
end
accuracy_av = accuracy_sum/10
accuracy_tot = accuracy_tot
