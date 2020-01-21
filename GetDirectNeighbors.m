function [ Neighbors ] = GetDirectNeighbors( graph, service )

%A=full(graph);
Neighbors=int16.empty(size(graph,1)*3,0);
%Neighbors=zeros(size(graph,1)*3,size(graph,2)*3);

for i=1:size(graph,1)
    if(graph(i,service)~=0)
     Neighbors=[Neighbors; i];
    end
end

for j=1:size(graph,2)
    if(graph(service,j)~=0)
     Neighbors=[Neighbors; j];
    end
end

end

