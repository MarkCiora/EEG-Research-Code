%% Sort o2 power
for j = 1:20
    % aWake Shallow Deep Rem
    A(j).w_o2 = zeros(1,Data(j).num(1),4);
    A(j).s_o2 = zeros(1,Data(j).num(2),4);
    A(j).d_o2 = zeros(1,Data(j).num(3),4);
    A(j).r_o2 = zeros(1,Data(j).num(4),4);
    
    num = [0 0 0 0];
    for i = 1:Data(j).pow_samples
        switch Data(j).pow_state(i)
            case 0 %awake
                num(1) = num(1) + 1;
                A(j).w_o2(1,num(1),:) = Data(j).ratio_o2(1,i,1:4); 
            case 1 %shallow
                num(2) = num(2) + 1;
                A(j).s_o2(1,num(2),:) = Data(j).ratio_o2(1,i,1:4);
            case 2 %deep
                num(3) = num(3) + 1;
                A(j).d_o2(1,num(3),:) = Data(j).ratio_o2(1,i,1:4);
            case 3 %rem
                num(4) = num(4) + 1;
                A(j).r_o2(1,num(4),:) = Data(j).ratio_o2(1,i,1:4);
        end
    end
    A(j).num = num;
end
clear num
clear i
clear j


%% 3d scatter shallow vs deep

scatter3(A(1).s_o2(1,:,1),A(1).s_o2(1,:,2),A(1).s_o2(1,:,4));
hold on
scatter3(A(1).d_o2(1,:,1),A(1).d_o2(1,:,2),A(1).d_o2(1,:,4));

%% 2d scatter shallow vs deep

j = 5;
scatter(A(j).s_o2(1,1:500,1),A(j).s_o2(1,1:500,4));
hold on
scatter(A(j).d_o2(1,1:500,1),A(j).d_o2(1,1:500,4));


%% SVM on 2 dimensions for graph
for j = 1:20
    d2(j).xy = zeros(1,1000,3);
    
    d2(j).xy(1,1:500,3) = 1;
    d2(j).xy(1,501:1000,3) = -1;
    
    d2(j).xy(1,1:500,1) = A(j).s_o2(1,1:500,1);
    d2(j).xy(1,501:1000,1) = A(j).d_o2(1,1:500,1);
    
    d2(j).xy(1,1:500,2) = A(j).s_o2(1,1:500,4);
    d2(j).xy(1,501:1000,2) = A(j).d_o2(1,1:500,4);
    
end

%% Permutate, split
for j = 1:20
    rand_num = randperm(1000);
    d2(j).xy_rand = d2(j).xy;
    for i = 1:1000
        d2(j).xy_rand(1,i,:) = d2(j).xy(1,rand_num(i),:);
    end
    d2(j).x = [d2(j).xy_rand(1,:,1); d2(j).xy_rand(1,:,2)];
    d2(j).y = d2(j).xy_rand(1,:,3);
    d2(j).x_split = split_80_20_SVM(d2(j).x,d2(j).y,1000);
end

%% SVM
person = 1;
clc
accuracy = zeros(4,5);
best = [0;0;1;0]
figure(1)
close(1)
figure(1)
j = 1;
scatter(A(j).s_o2(1,1:500,1),A(j).s_o2(1,1:500,4));
hold on
scatter(A(j).d_o2(1,1:500,1),A(j).d_o2(1,1:500,4));
for i = 1:5
    for thing = 1:10
        b = 10*2^(-thing)
        train.x = [];
        train.y = [];
        for j = 1:5
            if i == j
                continue
            end
            train.x = [train.x d2(person).x_split(j).x];
            train.y = [train.y d2(person).x_split(j).y];
        end
        test.x = d2(person).x_split(i).x;
        test.y = d2(person).x_split(i).y;

        %SUBGRADIENT DESCENT GOES HERE
        val = 1;
        type = 'poly_a';
        
        [out(i).w out(i).b] = subgradient_descent_graph(train.x, train.y, 1000000000, type, val, b, A, 1);
        %[out(i).w out(i).b] = subgradient_descent_step_change(train.x, train.y, 10000000, type, val, b);

        %TEST IT
        accuracy(:,i) = test_SVM_accuracy(out(i).w, out(i).b, test.x, test.y, type, val)
        output = i
        if accuracy(2,i) > best(2);
            best_w = out(i).w;
            best_b = out(i).b;
            best = accuracy(:,i)
        end
    end
end
clear i
clear j


%% plot
% 0 = wx + b
% 0 = w(1)x(1) + w(2)x(2) + b
% y = -xw(1)/w(2) - b/w(2)


j = 1;
k = 1;
scatter(A(j).s_o2(1,1:500,1),A(j).s_o2(1,1:500,4));
hold on
scatter(A(j).d_o2(1,1:500,1),A(j).d_o2(1,1:500,4));
plot([0 0.9], [-best_b/best_w(2) -0.9*best_w(1)/best_w(2)-best_b/best_w(2)])