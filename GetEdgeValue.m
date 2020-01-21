function [ value ] = GetEdgeValue( graph, service1, service2 )

A=full(graph);
value=0;

if(A(service1,service2)~=0)
  value=A(service1,service2);
else
  value=A(service2,service1);
end


end

