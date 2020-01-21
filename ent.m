function result = ent(Y)
% Calculates the entropy of a vector of values 

% Get frequency table 
tab = tabulate(Y);
prob = tab(:,3) / 100;
% Filter out zero-entries
prob = prob(prob~=0);
% Get entropy
result = -sum(prob .* log2(prob));


