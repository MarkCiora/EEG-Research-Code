%% quick plot
j = 3;
figure(j)
scatter3(A(j).s_o2(1,:,1),A(j).s_o2(1,:,2),A(j).s_o2(1,:,4))
hold on
scatter3(A(j).d_o2(1,:,1),A(j).d_o2(1,:,2),A(j).d_o2(1,:,4))

j = j+1;
figure(j)
scatter3(A(j).s_o2(1,:,1),A(j).s_o2(1,:,2),A(j).s_o2(1,:,4))
hold on
scatter3(A(j).d_o2(1,:,1),A(j).d_o2(1,:,2),A(j).d_o2(1,:,4))

%% SVM on 4 dimensions
clear input
for j = 1:20
    x1 = zeros(4,width(A(j).s_o2));
    x2 = zeros(4,width(A(j).d_o2));
    
    x1(1,:) = A(j).s_o2(1,:,1);
    x2(1,:) = A(j).d_o2(1,:,1);
    
    x1(2,:) = A(j).s_o2(1,:,2);
    x2(2,:) = A(j).d_o2(1,:,2);
    
    x1(3,:) = A(j).s_o2(1,:,3);
    x2(3,:) = A(j).d_o2(1,:,3);
    
    x1(4,:) = A(j).s_o2(1,:,4);
    x2(4,:) = A(j).d_o2(1,:,4);
   
    input(j).x = transpose([x1 x2]);
    input(j).y = ones(width(x1) + width(x2),1);
    input(j).y(1:width(x1)) = -1;
end

clear x1
clear x2
clear j

%% SVM on 3 dimensions
clear input
for j = 1:20
    x1 = zeros(3,width(A(j).s_o2));
    x2 = zeros(3,width(A(j).d_o2));
    
    x1(1,:) = A(j).s_o2(1,:,1);
    x2(1,:) = A(j).d_o2(1,:,1);
    
    x1(2,:) = A(j).s_o2(1,:,2);
    x2(2,:) = A(j).d_o2(1,:,2);
    
     x1(3,:) = A(j).s_o2(1,:,3);
     x2(3,:) = A(j).d_o2(1,:,3);
     
%     x1(4,:) = A(j).s_o2(1,:,4);
%     x2(4,:) = A(j).d_o2(1,:,4);
   
    input(j).x = transpose([x1 x2]);
    input(j).y = ones(width(x1) + width(x2),1);
    input(j).y(1:width(x1)) = -1;
    input(j).w1 = width(x1);
    input(j).w2 = width(x2);
end

clear x1
clear x2
clear j

%% SVM vs QDA
adder = [];
adder2 = [];
for j = 1:10
    X = input(2*j-1).x;
    Y = input(2*j-1).y;
    Xt = input(2*j).x;
    Yt = input(2*j).y;
    svm(2*j-1).mod = fitcsvm(X,Y, 'KernelFunction', 'rbf', 'ClassNames', [-1,1]);
    qda(2*j-1).mod = QDA(transpose(X),transpose(Y));
    
    [label, score] = predict(svm(2*j-1).mod, Xt);
    
    adder(j) = 0;
    for k = 1:height(Yt)
        if label(k) == Yt(k)
            adder(j) = adder(j) + 1;
        end
    end
    adder(j) = adder(j)/height(Yt);
    
    adder2(j) = test_QDA_accuracy(qda(2*j-1).mod, transpose(Xt), transpose(Yt));
end
accuracy_matlab_svm(1,:) = adder
accuracy_my_QDA(1,:) = adder2

%% SVM vs QDA TWO
adder = [];
adder2 = [];
for j = 1:10
    X = input(2*j).x;
    Y = input(2*j).y;
    Xt = input(2*j-1).x;
    Yt = input(2*j-1).y;
    svm(2*j).mod = fitcsvm(X,Y, 'KernelFunction', 'rbf', 'ClassNames', [-1,1]);
    qda(2*j).mod = QDA(transpose(X),transpose(Y));
    
    [label, score] = predict(svm(2*j).mod, Xt);
    
    adder(j) = 0;
    for k = 1:height(Yt)
        if label(k) == Yt(k)
            adder(j) = adder(j) + 1;
        end
    end
    adder(j) = adder(j)/height(Yt);
    
    adder2(j) = test_QDA_accuracy(qda(2*j-1).mod, transpose(Xt), transpose(Yt));
end
accuracy_matlab_svm(2,:) = adder
accuracy_my_QDA(2,:) = adder2


%% quick test
X = input(1).x;
Y = input(1).y;
Xt = input(2).x;
Yt = input(2).y;
model = fitcsvm(X,Y, 'KernelFunction', 'rbf', 'ClassNames', [-1,1]);
[label, score] = predict(model, Xt);
%% a
adder = 0;
for k = 1:height(Yt)
    if label(k) == Yt(k)
        adder = adder + 1;
    end
end
accuracy_matlab_svm = adder/height(Yt)


%% SVM Classification Matrix
for j = 1:20
    X = input(j).x;
    Y = input(j).y;
    svm(j).mod = fitcsvm(X,Y, 'KernelFunction', 'rbf', 'ClassNames', [-1,1]);
    
    for i = 1:20
        Xt = input(i).x;
        Yt = input(i).y;
        [label, score] = predict(svm(j).mod, Xt);
        adder(j,i) = 0;
        for k = 1:height(Yt)
            if label(k) == Yt(k)
                adder(j,i) = adder(j,i) + 1;
            end
        end
        adder(j,i) = adder(j,i)/height(Yt);
    end
    
end
accuracy_matlab_svm = adder