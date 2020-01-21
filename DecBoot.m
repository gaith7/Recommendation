%# load data
[ ServiceName, Region, Availability, Outages, DownTime ]  = ReadCloudDataSet();

SLAavailability(:,:)=100;
for i=1:length(Availability)
    if(100-Availability(i)<0.2753)
       InitialTrust(i) = 1; 
    else
       InitialTrust(i) = 0;
    end
end

M=zeros(size(Availability,1),6);

 for db=1:size(M,1)
     %M(db,1)=ServiceName(db);
     %M(db,2)= Region(db);
     M(db,3)= Availability(db);
     M(db,4)= Outages(db);
     %M(db,5)= DownTime(db);
     M(db,6)= InitialTrust(db);
 end
 
%# construct predicting attributes and target class
vars = {'Availability' 'Outages'};
x = [Availability Outages];  %# mixed continous/discrete data
y = InitialTrust;                        %# class labels
disp('data');
disp(y);
%# train classification decision tree
t = classregtree(x, y, 'method','classification', 'names',vars, ...
                'categorical',[6], 'prune','off');
view(t)

%# test
yPredicted = str2num( cell2mat( eval(t, x)));
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
