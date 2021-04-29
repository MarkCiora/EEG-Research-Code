clear;
clc;
%% obtain data
% recordings are in 30 second increments

d = zeros(50,1);
t = zeros(50,1);
a = zeros(50,1);
b = zeros(50,1);

% obtain data
for i = 1:1:50
    [d(i),t(i),a(i),b(i)] = getWaveValues('SC4021E0-PSG.edf', (i+700), 2);
end

X = [d, t, a, b];
%%
% divide into train/test set

% h = edfinfo('SC4021EH-Hypnogram.edf');
% tt = h.Annotations;
%data = timetable2table(tt);

% labels = table2array(tt(:,1));
% stage_num = grp2idx(labels);

% binary classification problem
% using alpha and theta waves

labels(1:26) = 0;
labels(27:50) = 1;

y = transpose(labels);

rand_num = randperm(50);
X_train = X(rand_num(1:40),:);
y_train = y(rand_num(1:40),:);

X_test = X(rand_num(41:end),:);
y_test = y(rand_num(41:end),:);
%% CV partition

% number of iterations for cross validation
folds = 5;

% obtain training set and validation set
[t, v] = partition(y_train,5);

%% best hyperparameters

% for now, we use two inputs
X_train_w_best_features = X_train(:,2:3);

% linear svm



%% test

X_test_w_best_feature = X_test(:,fs);
accuracy = sum(predict(Md1, X_test_w_best_feature) == y_test)/length(y_test)*100

%% hyperplane

figure;
hgscatter = gscatter(X_train_w_best_features(:,1),X_train_w_best_features(:,2),y_train);
hold on;
h_sv=plot(Md1.SupportVectors(:,1),Md1.SupportVectors(:,2),'ko','markersize',8);

gscatter(X_test_w_best_feature(:,1),X_test_w_best_feature(:,2),y_test,'rb','xx')

% decision plane
XLIMs = get(gca,'xlim');
YLIMs = get(gca,'ylim');
[xi,yi] = meshgrid([XLIMs(1):0.01:XLIMs(2)],[YLIMs(1):0.01:YLIMs(2)]);
dd = [xi(:), yi(:)];
pred_mesh = predict(Md1, dd);
redcolor = [1, 0.8, 0.8];
bluecolor = [0.8, 0.8, 1];
pos = find(pred_mesh == 1);
h1 = plot(dd(pos,1), dd(pos,2),'s','color',redcolor,'Markersize',5,'MarkerEdgeColor',redcolor,'MarkerFaceColor',redcolor);
pos = find(pred_mesh == 2);
h2 = plot(dd(pos,1), dd(pos,2),'s','color',bluecolor,'Markersize',5,'MarkerEdgeColor',bluecolor,'MarkerFaceColor',bluecolor);
uistack(h1,'bottom');
uistack(h2,'bottom');
legend([hgscatter;h_sv],{'Sleep Stage W','Sleep Stage 1','support vectors'})