function [ reputation ] = UpdateReputation( graph, reputation, service, belief )

[ Neighbors ] = GetDirectNeighbors( graph, service );
CountNeighbors=size(Neighbors,1);

for i=1:length(reputation)
     for j=1:CountNeighbors
        if(reputation(i)==Neighbors(j))
           [ value ] = GetEdgeValue( graph, Neighbors(j), service );
           if((value==1 && belief>0.5) || (value==-1 && belief<0.5))
            reputation(i+1)= reputation(i+1)+abs(belief-reputation(i+1));
           else if((value==1 && belief<0.5) || (value==-1 && belief>0.5))
            reputation(i+1)= reputation(i+1)-abs(belief-reputation(i+1));
               end
           end
            if(reputation(i+1)>1)
                reputation(i+1)=1;
            end
        end
     end
end

end

