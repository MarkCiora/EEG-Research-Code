%% SVM on 3 improved dimensions
for j = 1:20
    wid = min(width(C(j).s_o2),width(C(j).d_o2));
    d2(j).xy = zeros(1,wid*2,4);
    
    d2(j).xy(1,1:wid,4) = 1;
    d2(j).xy(1,wid+1:wid*2,4) = -1;
    
    d2(j).xy(1,1:wid,1) = C(j).s_o2(1,1:wid);
    d2(j).xy(1,wid+1:wid*2,1) = C(j).d_o2(1,1:wid);
    
    d2(j).xy(1,1:wid,2) = C(j).s_o2(2,1:wid);
    d2(j).xy(1,wid+1:wid*2,2) = C(j).d_o2(2,1:wid);
    
    d2(j).xy(1,1:wid,3) = C(j).s_o2(3,1:wid);
    d2(j).xy(1,wid+1:wid*2,3) = C(j).d_o2(3,1:wid);
    
    
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
    d2(j).x = [d2(j).xy_rand(1,:,1); d2(j).xy_rand(1,:,2); d2(j).xy_rand(1,:,3)];
    d2(j).y = d2(j).xy_rand(1,:,4);
    d2(j).x_split = split_80_20_SVM(d2(j).x,d2(j).y,d2(j).w*2);
end

%% SVM and QDA
person = 2;
clc
accuracy = zeros(4,5);
QDA_ = [];
QDA_acc = zeros(1,5);

% Loop through 5 cross-validation splits
for person = 1:20
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

%%
for j = 1:20
    bigacc(j,:) = accuracy(2,:,j);
end
bigacc