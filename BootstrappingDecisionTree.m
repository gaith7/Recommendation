%% Load the auto data
M = dlmread('CloudCompute.txt', '\t');
% We want to predict the first column...
Y = M(:,5);
% ...based on the others
X = M(:,1:4);

cols = {'ServiceName', 'Region', 'Availability', 'Outages', 'DownTime'};

%% Build the decision tree
t = build_tree(X,Y,cols);

%% Display the tree
treeplot(t.p');
title('Decision tree ("**" is an inconsistent node)');
[xs,ys,h,s] = treelayout(t.p');

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
    
