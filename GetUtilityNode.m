function [ utility ] = GetUtilityNode( graph, node_id)

utility=0;
A=full(graph);
disp('A');
disp(A);

disp(size(A,2));

for i=1:size(A,1)
  for j=1:size(A,2)
    if(i==node_id || j==node_id)
    utility=utility+A(i,j);
    end
  end
end

end

