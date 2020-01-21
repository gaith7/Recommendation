function [ coalitions ] = Merge( partition )

disp('coal');
celldisp(partition);

coalitions={};
for i=1:size(partition,1)-1
    for j=2:size(partition,2)-1
      for k=2:size(partition,1)
          for m=3:size(partition,2)
              disp('partition(i,j)');
              disp(partition{i,j});
              disp('partition(k,m)');
              disp(partition{k,m});
            newCoalition=[partition{i,j} partition{k,m}];
            coalitions(i,j)= {newCoalition};
          end
      end
    end
end

end

