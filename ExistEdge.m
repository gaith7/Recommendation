function [ AreNeighbors ] = ExistEdge( graph, service1, service2 )

A=full(graph);
AreNeighbors=false;

for i=1:size(A,1)
  for j=1:size(A,2)
    if(A(service1,service2)~=0)
     AreNeighbors=true;
    end
  end
end

end

