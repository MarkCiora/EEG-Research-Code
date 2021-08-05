%% Train classifier on one, test against 19
% note that the moving average training set is used here

for j = 1:20
    train_set = [];
    train_y = [];
    test_set = [Data(j).shallow_ma Data(j).deep_ma];
    test_y = [  (-1)*ones(1,width(Data(j).shallow_ma))...
                ones(1,width(Data(j).deep_ma))];
    for i = 1:20
        if i == j
            continue
        end
        train_set = [train_set Data(i).shallow_ma Data(i).deep_ma];
        train_y = [ train_y...
                    (-1)*ones(1,width(Data(i).shallow_ma))...
                    ones(1,width(Data(i).deep_ma))];
    end
    
    train_set_condensed = zeros(height(train_set),width(train_set)/10);
    train_y_condensed = zeros(1,width(train_set)/10);
    for i = 1:width(train_set)/10
        train_set_condensed(:,i) = train_set(:,i*10);
        train_y_condensed(:,i) = train_y(:,i*10);
    end
    clear train_set
    clear train_y
    
    svm = fitcsvm(transpose(train_set_condensed), transpose(train_y_condensed),...
                'KernelFunction', 'linear',...
                'ClassNames', [-1,1]);
    
    [label, score] = predict(svm, transpose(test_set));
    
    adder = 0;
    for k = 1:width(test_y)
        if label(k) == test_y(k)
            adder = adder + 1;
        end
    end
    accuracy(j) = adder/width(test_y)
    
end
%clear train_set
%clear train_y
%clear test_set
%clear test_y
%average = sum(accuracy)/20




%% Train and test on one person
% note that the moving average training set is used here

kern_type = 'linear';
kern_type2 = 'KernelScale';
gamma = .1;
kern_val = 1/sqrt(2*gamma);

kern_val = 'auto';

for j = 1:10
    clear out
    a = 2*j-1;
    b = 2*j;
    train_set = [Data(a).shallow_ma Data(a).deep_ma];
    train_y = [ (-1)*ones(1,width(Data(a).shallow_ma))...
                ones(1,width(Data(a).deep_ma))];
    test_set = [Data(b).shallow_ma Data(b).deep_ma];
    test_y = [  (-1)*ones(1,width(Data(b).shallow_ma))...
                ones(1,width(Data(b).deep_ma))];
    
            
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
        out(i).svm = fitcsvm(transpose(x), transpose(y),...
                'KernelFunction', kern_type,...
                kern_type2, kern_val,...
                'ClassNames', [-1,1]);
        
        [label, score] = predict(out(i).svm, transpose(split(i).x));
        adder = 0;
        for k = 1:width(split(i).y)
            if label(k) == split(i).y(k)
                adder = adder + 1;
            end
        end
        test_acc(i) = adder/width(split(i).y);
        
    end

    %select the best one
    max = 0;
    target = 1;
    for i = 1:5
        if max < test_acc(i)
            target = i;
            max = test_acc(i);
        end
    end
    svm = out(target).svm;
            
            
    
    
    [label, score] = predict(svm, transpose(test_set));
    
    adder = 0;
    for k = 1:width(test_y)
        if label(k) == test_y(k)
            adder = adder + 1;
        end
    end
    accuracy(j*2-1) = adder/width(test_y);
    
end
for j = 1:10
    b = 2*j-1;
    a = 2*j;
    train_set = [Data(a).shallow_ma Data(a).deep_ma];
    train_y = [ (-1)*ones(1,width(Data(a).shallow_ma))...
                ones(1,width(Data(a).deep_ma))];
    test_set = [Data(b).shallow_ma Data(b).deep_ma];
    test_y = [  (-1)*ones(1,width(Data(b).shallow_ma))...
                ones(1,width(Data(b).deep_ma))];
    
            
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
        out(i).svm = fitcsvm(transpose(x), transpose(y),...
                'KernelFunction', kern_type,...
                kern_type2, kern_val,...
                'ClassNames', [-1,1]);
        
        [label, score] = predict(out(i).svm, transpose(split(i).x));
        adder = 0;
        for k = 1:width(split(i).y)
            if label(k) == split(i).y(k)
                adder = adder + 1;
            end
        end
        test_acc(i) = adder/width(split(i).y);
        
    end

    %select the best one
    max = 0;
    target = 1;
    for i = 1:5
        if max < test_acc(i)
            target = i;
            max = test_acc(i);
        end
    end
    svm = out(target).svm;
            
            
    
    
    [label, score] = predict(svm, transpose(test_set));
    
    adder = 0;
    for k = 1:width(test_y)
        if label(k) == test_y(k)
            adder = adder + 1;
        end
    end
    accuracy(j*2) = adder/width(test_y);
    
end

average = sum(accuracy)/20






















