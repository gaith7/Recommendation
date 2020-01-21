function [ NashStable ] = isNashStable( partition , CoalitionsValues)

%partition={[1 2], 1, [1 2 3]};
part=zeros(length(partition));

tmp=[];
for i=1:length(partition)
    %disp('part(1)');
    %disp(partition{i});
    tmp=[tmp num2cell(partition{i})];
end

%players=unique(partition); %stores the players that are in the current partition
%[players,order]=unique(tmp,'first');

for i=1:length(tmp)
    s = strcat('tmp ',i);
    %disp(s);
    %disp(tmp(i));
end

%tmp=num2cell(partition);
%[a b c d e f]=deal(tmp{:});

NashStable=false;

for i=1:size(partition,1)
    for j=1:size(partition,2)
        
    end
end

end


