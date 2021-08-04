%% Train classifier on one, test against 19 WITH CROSS-VALIDATION
% note that the moving average training set is used here
accuracy = [];
for j = 1:20
    train_set = [];
    train_y = [];
    test_set = [Data(j).shallow_ma Data(j).deep_ma];
    test_y = [  ones(1,width(Data(j).shallow_ma))...
                (-1)*ones(1,width(Data(j).deep_ma))];
    for i = 1:20
        if i == j
            continue
        end
        train_set = [train_set Data(i).shallow_ma Data(i).deep_ma];
        train_y = [ train_y...
                    ones(1,width(Data(i).shallow_ma))...
                    (-1)*ones(1,width(Data(i).deep_ma))];
    end

    %permutate
    [train_set, train_y] = my_rand_perm(train_set, train_y);

    %split
    split = split_80_20_SVM(train_set, train_y, width(train_y));
    
    test_acc = [];
    for i = 1:5
        x = [];
        y = [];
        for k = 1:5
            if k == i
                continue
            end
            x = [x split(k).x];
            y = [y split(k).y];
        end
        [out(i).w out(i).b] = subgradient_descent(x, y, 1e9, .1);
        test_acc(:,i) = test_SVM_accuracy(out(i).w, out(i).b, split(i).x, split(i).y);
    end

    max = 0;
    target = 1;
    for i = 1:5
        if max < test_acc(2,i)
            target = i;
            max = test_acc(2,i);
        end
    end
    out = out(target);

    accuracy(:,j) = test_SVM_accuracy(out.w, out.b, test_set, test_y);
end
average = sum(accuracy(2,:))/20