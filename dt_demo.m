%% Load the auto data
%M = dlmread('CloudCompute.txt', '\t');
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


% We want to predict the first column...
Y = M(:,6);
disp('Y');
disp(Y);

% ...based on the others
X = M(:,3:4);
disp('X');
disp(X);

cols = {'Availability', 'Outages'};

%% Build the decision tree
t = build_tree(X,Y,cols);

%% Display the tree
treeplot(t.p');
title('Decision tree ("**" is an inconsistent node)');
[xs,ys,h,s] = treelayout(t.p');

%# test
yPredicted = eval(t, X);
cm = confusionmat(Y,yPredicted);           %# confusion matrix
N = sum(cm(:));
err = ( N-sum(diag(cm)) ) / N;             %# testing error

disp('test error');
disp(err);

for i = 2:numel(t.p)
	% Get my coordinate
	my_x = xs(i);
	my_y = ys(i);

	% Get parent coordinate
	parent_x = xs(t.p(i));
	parent_y = ys(t.p(i));

	% Calculate weight coordinate (midpoint)
	mid_x = (my_x + parent_x)/2;
	mid_y = (my_y + parent_y)/2;

    % Edge label
	text(mid_x,mid_y,t.labels{i-1});
    
    % Leaf label
    if ~isempty(t.inds{i})
        val = Y(t.inds{i});
        if numel(unique(val))==1
            text(my_x, my_y, sprintf('y=%2.2f\nn=%d', val(1), numel(val)));
        else
            %inconsistent data
            text(my_x, my_y, sprintf('**y=%2.2f\nn=%d', mode(val), numel(val)));
        end
    end
end
    
