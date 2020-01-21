function [ partition_without_repetitions ] = removeDuplicates( partition_with_repetitions )

partition_without_repetitions=java.util.LinkedList;

for i=0:partition_with_repetitions.size()-1
    for j=1:partition_with_repetitions.size()-1
        tf = isequal(partition_with_repetitions.get(i),partition_with_repetitions.get(j));
        if(tf==1)
            disp('fet');
            disp('partition_with_repetitions.get(i)');
        disp(partition_with_repetitions.get(i));
        disp('partition_with_repetitions.get(j)');
        disp(partition_with_repetitions.get(j));
        %partition_without_repetitions.add(partition_with_repetitions.get(i));
        %partition_without_repetitions.add(partition_with_repetitions.get(j));
        %b = a(a~=3);
        partition_without_repetitions=partition_with_repetitions(partition_with_repetitions~=partition_with_repetitions.get(j));
        %setdiff(partition_with_repetitions,j);
        %partition_with_repetitions.remove(partition_with_repetitions.get(j));
        end
    end
end
%partition_without_repetitions=partition_with_repetitions;

end

