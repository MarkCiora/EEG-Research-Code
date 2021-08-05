%% Train classifier on one, test against 19
% note that the moving average training set is used here

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

    QDA_classifier = QDA(train_set, train_y);
    accuracy_qda(j) = test_QDA_accuracy(QDA_classifier, test_set, test_y);
end
average_qda = sum(accuracy_qda)/20

%% Train classifier on one, test against 19 WITH CROSS-VALIDATION

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
        QDA_classifier(i) = QDA(x, y);
        test_acc(i) = test_QDA_accuracy(QDA_classifier(i), split(i).x, split(i).y);
    end

    max = 0;
    target = 1;
    for i = 1:5
        if max < test_acc(i)
            target = i;
            max = test_acc(i);
        end
    end
    QDA_classifier = QDA_classifier(target);

    accuracy_qda(j) = test_QDA_accuracy(QDA_classifier, test_set, test_y);
end
average_qda = sum(accuracy_qda)/20


%% Train and test on one person
for j = 1:10
    a = 2*j-1;
    b = 2*j;
    train_set = [Data(a).shallow_ma Data(a).deep_ma];
    train_y = [  ones(1,width(Data(a).shallow_ma))...
                (-1)*ones(1,width(Data(a).deep_ma))];
    test_set = [Data(b).shallow_ma Data(b).deep_ma];
    test_y = [  ones(1,width(Data(b).shallow_ma))...
                (-1)*ones(1,width(Data(b).deep_ma))];
            
            
    %permutate
    [train_set, train_y] = my_rand_perm(train_set, train_y);

    %split
    split = split_80_20_SVM(train_set, train_y, width(train_y));

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
        QDA_classifier(i) = QDA(x, y);
        test_acc(i) = test_QDA_accuracy(QDA_classifier(i), split(i).x, split(i).y);
    end

    max = 0;
    target = 1;
    for i = 1:5
        if max < test_acc(i)
            target = i;
            max = test_acc(i);
        end
    end
    QDA_classifier = QDA_classifier(target);
            
    accuracy_qda(2*j-1) = test_QDA_accuracy(QDA_classifier, test_set, test_y);
end
for j = 1:10
    b = 2*j-1;
    a = 2*j;
    train_set = [Data(a).shallow_ma Data(a).deep_ma];
    train_y = [  ones(1,width(Data(a).shallow_ma))...
                (-1)*ones(1,width(Data(a).deep_ma))];
    test_set = [Data(b).shallow_ma Data(b).deep_ma];
    test_y = [  ones(1,width(Data(b).shallow_ma))...
                (-1)*ones(1,width(Data(b).deep_ma))];
            
    %permutate
    [train_set, train_y] = my_rand_perm(train_set, train_y);

    %split
    split = split_80_20_SVM(train_set, train_y, width(train_y));

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
        QDA_classifier(i) = QDA(x, y);
        test_acc(i) = test_QDA_accuracy(QDA_classifier(i), split(i).x, split(i).y);
    end

    max = 0;
    target = 1;
    for i = 1:5
        if max < test_acc(i)
            target = i;
            max = test_acc(i);
        end
    end
    QDA_classifier = QDA_classifier(target);        
    
            
    accuracy_qda(2*j) = test_QDA_accuracy(QDA_classifier, test_set, test_y);
end

clear train_set
clear train_y
clear test_set
clear test_y
clear QDA_classifier
average_qda = sum(accuracy_qda)/20






















