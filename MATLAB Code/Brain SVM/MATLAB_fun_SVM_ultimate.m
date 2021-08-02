%% SVM on 4 dimensions
%and eliminate outer 5% of points
clear input
for j = 1:20
    x1 = zeros(3,width(C(j).s_o2));
    x2 = zeros(3,width(C(j).d_o2));
    
    x1(1,:) = C(j).s_o2(2,:);
    x2(1,:) = C(j).d_o2(2,:);
    
    x1(2,:) = C(j).s_o2(2,:);
    x2(2,:) = C(j).d_o2(2,:);
    
    x1(3,:) = C(j).s_o2(3,:);
    x2(3,:) = C(j).d_o2(3,:);
   
    
   
    input(j).x = transpose([x1 x2]);
    input(j).y = ones(width(x1) + width(x2),1);
    input(j).y(1:width(x1)) = -1;
end

%clear x1
%clear x2
clear j


%% SVM
adder = [];
for j = 1:10
    
    X = input(2*j-1).x;
    Y = input(2*j-1).y;
    
    
    Xt = input(2*j-1).x;
    Yt = input(2*j-1).y;
    
    svm(2*j-1).mod = fitcsvm(X,Y, 'KernelFunction', 'rbf', 'ClassNames', [-1,1]);
    
    [label, score] = predict(svm(2*j-1).mod, Xt);
    
    adder(j) = 0;
    for k = 1:height(Yt)
        if label(k) == Yt(k)
            adder(j) = adder(j) + 1;
        end
    end
    adder(j) = adder(j)/height(Yt)
    
end
accuracy_matlab_svm(1,:) = adder


%% SVM 2
adder = zeros(20,1);
thing = 5;
for j = 1:20
    
    randnum = randperm(height(input(j).x));
    start_pos = randnum(1:round(.8*width(randnum)));
    end_pos = randnum(round(.8*width(randnum)):end);
    
    X = input(j).x(start_pos,:);
    Y = input(j).y(start_pos,:);
    
    
    Xt = input(j).x(end_pos,:);
    Yt = input(j).y(end_pos,:);
    
    svm(2*j-1).mod = fitcsvm(X,Y, 'KernelFunction', 'rbf', 'ClassNames', [-1,1]);
    
    [label, score] = predict(svm(2*j-1).mod, Xt);
    
    adder(j) = 0;
    for k = 1:height(Yt)
        if label(k) == Yt(k)
            adder(j) = adder(j) + 1;
        end
    end
    adder(j) = adder(j)/height(Yt)
    
end
accuracy_matlab_svm(:,thing) = adder
