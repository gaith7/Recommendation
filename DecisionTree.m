%# load data
load carsmall

%# construct predicting attributes and target class
vars = {'MPG' 'Cylinders' 'Horsepower' 'Model_Year'};
x = [MPG Cylinders Horsepower Model_Year];  %# mixed continous/discrete data
y = cellstr(Origin);                        %# class labels
disp('data');
disp(y);
%# train classification decision tree
t = classregtree(x, y, 'method','classification', 'names',vars, ...
                'categorical',[2 4], 'prune','off');
view(t)

%# test
yPredicted = eval(t, x);
cm = confusionmat(y,yPredicted);           %# confusion matrix
N = sum(cm(:));
err = ( N-sum(diag(cm)) ) / N;             %# testing error

disp('test error');
disp(err);

%# prune tree to avoid overfitting
tt = prune(t, 'level',3);
view(tt)

%# predict a new unseen instance
t = fitctree(x, y, 'PredictorNames',vars, ...
    'CategoricalPredictors',{'Cylinders', 'Model_Year'}, 'Prune','off');
view(t, 'mode','graph')

y_hat = predict(t, x);
cm = confusionmat(y,y_hat);

tt = prune(t, 'Level',3);
view(tt)

predict(tt, [33 4 78 NaN])
