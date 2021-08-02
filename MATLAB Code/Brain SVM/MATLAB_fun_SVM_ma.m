%% quick plot
j = 3;
figure(j)
scatter3(A(j).s_o2_refined(1,:,1),A(j).s_o2_refined(1,:,2),A(j).s_o2_refined(1,:,4))
hold on
scatter3(A(j).d_o2_refined(1,:,1),A(j).d_o2_refined(1,:,2),A(j).d_o2_refined(1,:,4))

j = j+1;
figure(j)
scatter3(A(j).s_o2_refined(1,:,1),A(j).s_o2_refined(1,:,2),A(j).s_o2_refined(1,:,4))
hold on
scatter3(A(j).d_o2_refined(1,:,1),A(j).d_o2_refined(1,:,2),A(j).d_o2_refined(1,:,4))
%% quick plot sqrt
j = 7;
figure(j)
scatter3(sqrt(A(j).s_o2_refined(1,:,1)),sqrt(A(j).s_o2_refined(1,:,3)),sqrt(A(j).s_o2_refined(1,:,4)))
hold on
scatter3(sqrt(A(j).d_o2_refined(1,:,1)),sqrt(A(j).d_o2_refined(1,:,3)),sqrt(A(j).d_o2_refined(1,:,4)))

j = j+1;
figure(j)
scatter3(sqrt(A(j).s_o2_refined(1,:,1)),sqrt(A(j).s_o2_refined(1,:,3)),sqrt(A(j).s_o2_refined(1,:,4)))
hold on
scatter3(sqrt(A(j).d_o2_refined(1,:,1)),sqrt(A(j).d_o2_refined(1,:,3)),sqrt(A(j).d_o2_refined(1,:,4)))

%% SVM on 4 dimensions
%and eliminate outer 5% of points
clear input
for j = 1:20
    x1 = zeros(4,width(A(j).s_o2_ma));
    x2 = zeros(4,width(A(j).d_o2_ma));
    
    x1(1,:) = A(j).s_o2_ma(1,:,1);
    x2(1,:) = A(j).d_o2_ma(1,:,1);
    
    x1(2,:) = A(j).s_o2_ma(1,:,2);
    x2(2,:) = A(j).d_o2_ma(1,:,2);
    
    x1(3,:) = A(j).s_o2_ma(1,:,3);
    x2(3,:) = A(j).d_o2_ma(1,:,3);
    
    x1(4,:) = A(j).s_o2_ma(1,:,4);
    x2(4,:) = A(j).d_o2_ma(1,:,4);
    
    %eliminate outliars
    %find means
    mean1 = [0;0;0;0];
    for i = 1:width(x1)
        mean1 = mean1 + x1(:,i);
    end
    mean1 = mean1/width(x1);
    mean2 = [0;0;0;0];
    for i = 1:width(x2)
        mean2 = mean2 + x2(:,i);
    end
    mean2 = mean2/width(x2);
    
    %find distances from mean
    dist1 = zeros(width(x1),1);
    for i = 1:width(x1)
        dist1(i) = sum((x1(:,i) - mean1).^2);
    end
    dist2 = zeros(width(x2),1);
    for i = 1:width(x2)
        dist2(i) = sum((x2(:,i) - mean2).^2);
    end
    
    %rank x in ascending order and chop off the end!
    I1 = [];
    I2 = [];
   [dist1, I1] = sort(dist1);
   [dist2, I2] = sort(dist2);
    temp = x1;
    for i = 1:width(x1)
        x1(:,i) = temp(:,I1(i));
    end
    temp = x2;
    for i = 1:width(x2)
        x2(:,i) = temp(:,I2(i));
    end
    x1 = x1(:,1:round(width(x1)*.95));
    x2 = x2(:,1:round(width(x2)*.95));
    
   
    input(j).x = transpose([x1 x2]);
    input(j).y = ones(width(x1) + width(x2),1);
    input(j).y(1:width(x1)) = -1;
    input(j).w1 = width(x1);
    input(j).w2 = width(x2);
end

%clear x1
%clear x2
clear j

%% QUICK PLOT
j = 9;
x1 = transpose(input(j).x(1:input(j).w1,:));
x2 = transpose(input(j).x(input(j).w1+1:end,:));
figure(j)
scatter3(x1(1,:),x1(2,:),x1(3,:))
hold on
scatter3(x2(1,:),x2(2,:),x2(3,:))

j = j+1;
x1 = transpose(input(j).x(1:input(j).w1,:));
x2 = transpose(input(j).x(input(j).w1+1:end,:));
figure(j)
scatter3(x1(1,:),x1(2,:),x1(3,:))
hold on
scatter3(x2(1,:),x2(2,:),x2(3,:))


%% SVM vs QDA
adder = [];
adder2 = [];
for j = 1:10
    w1 = input(2*j-1).w1;
    w2 = input(2*j-1).w2;
    mid = min(w1,w2);
    
    X = input(2*j-1).x;
    %X = [X(1:mid,:); X((w2+1):(w2+mid),:)];
    Y = input(2*j-1).y;
    %Y = [ones(mid,1)-2; ones(mid,1)];
    
    
    w1 = input(2*j).w1;
    w2 = input(2*j).w2;
    mid = min(w1,w2);
    
    Xt = input(2*j).x;
    %Xt = [Xt(1:mid,:); Xt((w2+1):(w2+mid),:)];
    Yt = input(2*j).y;
    %Yt = [ones(mid,1)-2; ones(mid,1)];
    
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
    
    %qda(2*j-1).mod.P(1) = .5;
    %qda(2*j-1).mod.P(2) = .5;
    
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