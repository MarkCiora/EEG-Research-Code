%% SVM on 4 dimensions
for j = 1:20
    wid = min(width(A(j).s_o2),width(A(j).d_o2));
    d2(j).xy = zeros(1,1000,5);
    
    d2(j).xy(1,1:wid,5) = 1;
    d2(j).xy(1,wid+1:wid*2,5) = -1;
    
    d2(j).xy(1,1:wid,1) = A(j).s_o2(1,1:wid,1);
    d2(j).xy(1,wid+1:wid*2,1) = A(j).d_o2(1,1:wid,1);
    
    d2(j).xy(1,1:wid,2) = A(j).s_o2(1,1:wid,2);
    d2(j).xy(1,wid+1:wid*2,2) = A(j).d_o2(1,1:wid,2);
    
    d2(j).xy(1,1:wid,3) = A(j).s_o2(1,1:wid,3);
    d2(j).xy(1,wid+1:wid*2,3) = A(j).d_o2(1,1:wid,3);
    
    d2(j).xy(1,1:wid,4) = A(j).s_o2(1,1:wid,4);
    d2(j).xy(1,wid+1:wid*2,4) = A(j).d_o2(1,1:wid,4);
    
    d2(j).w = wid;
end

%% Permutate, split
for j = 1:20
    rand_num = randperm(d2(j).w*2);
    d2(j).xy_rand = d2(j).xy;
    d2(j).x = [];
    for i = 1:d2(j).w*2
        d2(j).xy_rand(1,i,:) = d2(j).xy(1,rand_num(i),:);
    end
    d2(j).x = [d2(j).xy_rand(1,:,1); d2(j).xy_rand(1,:,2); d2(j).xy_rand(1,:,3); d2(j).xy_rand(1,:,4)];
    d2(j).y = d2(j).xy_rand(1,:,5);
    d2(j).x_split = split_80_20_SVM(d2(j).x,d2(j).y,d2(j).w*2);
end

%% SVM and QDA
person = 1;
clc
accuracy = zeros(4,5);
best = [0;0;1;0];
QDA_ = [];
QDA_acc = zeros(1,5);

% Loop through 5 cross-validation splits
for person = 1:1
    for i = 1:5
        b = .0001;
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

        %SUBGRADIENT DESCENT GOES HERE (and QDA)
        val = 1;
        type = 'poly_a';
        [out(i).w out(i).b] = subgradient_descent_step_change(train.x, train.y, 10000, type, val, b);
        out(i).b = b;
        out(i).train = train.x;
        QDA_(i).out = QDA(train.x, train.y);

        %TEST IT
        accuracy(1:4,i,person) = test_SVM_accuracy(out(i).w, out(i).b, test.x, test.y, type, val)
        accuracy(5,i,person) = test_QDA_accuracy(QDA_(i).out,test.x,test.y)

        output = i
        current_state = i;
    end
end
clear i
clear j

%% a
figure(1)
hold on
for i = 1:800
    if train.y(i) == 1
       scatter(train.x(2,i),train.x(3,i),'blue')
    end
    if train.y(i) == -1
        scatter(train.x(2,i),train.x(3,i),'red')
    end
end

%% test arena
output = zeros(20,5);
for split = 4
    for subject = 1:20
        more_acc(:,subject) = test_SVM_accuracy(out(split).w, out(split).b, d2(subject).x, d2(subject).y, type, val);
        more_QDA_acc(subject,split) = test_QDA_accuracy(QDA_(split).out,d2(subject).x,d2(subject).y);
    end
    output(:,split) = transpose(more_acc(1,:)./(more_acc(4,:)));
    comparator(:,split) = transpose(more_acc(2,:)./(more_acc(2,:)+more_acc(3,:)));
end
output = output
comparison = comparator - more_QDA_acc;