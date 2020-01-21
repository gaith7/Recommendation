function [ belief ] = DS( graph, reputation, service_judged )

[ Neighbors ] = GetDirectNeighbors( graph, service_judged );
CountNeighbors=size(Neighbors,1);
Trustworthiness=zeros(size(graph,1));
basic_trust=zeros(size(graph,1),size(graph,1));
basic_untrust=zeros(size(graph,1),size(graph,1));
basic_uncertain=zeros(size(graph,1),size(graph,1));
 
  for i=1:length(reputation)
     for j=1:CountNeighbors
%          disp('i');
%          disp(i);
%          disp('j');
%          disp(j);
         %disp('reputation(i)');
         %disp(reputation(i));
        if(reputation(i)==Neighbors(j))
            Trustworthiness(Neighbors(j))=reputation(i+1);
            %disp('Neighbors(j)');
            %disp(Neighbors(j));
            disp('Trust Neighbors');
            disp(Trustworthiness(Neighbors(j)));
        end
     end
  end
  
 for i=1:CountNeighbors
   [ value ] = GetEdgeValue( graph, service_judged, Neighbors(i) );
            disp('Neighbors(j)');
            disp(Neighbors(i));
            disp('service_judged');
            disp(service_judged);
            disp('Value');
            disp(value);
   if(value==1)
      basic_trust(service_judged,Neighbors(i))=Trustworthiness(Neighbors(i));
      basic_untrust(service_judged,Neighbors(i))=0;
      basic_uncertain(service_judged,Neighbors(i))=1-basic_trust(service_judged);
   else
    if(value==-1)
      basic_trust(service_judged,Neighbors(i))=0;
      basic_untrust(service_judged,Neighbors(i))=Trustworthiness(Neighbors(i));
      basic_uncertain(service_judged,Neighbors(i))=1-basic_untrust(service_judged);
    end
   end
 end
 
 k=0; %basic probability mass: sum of the product of the opinion of each watchdog in a certain node
 t=0;
 %belief=0;
 
    for i=1:CountNeighbors %# of watchdogs
        for j=1:CountNeighbors %# of watchdogs
            %[ value1 ] = GetEdgeValue( graph, service_judged, Neighbors(i) );
            %[ value2 ] = GetEdgeValue( graph, service_judged, Neighbors(j) );
            %tf = strcmp(value1,value2);
          if(i~=j)
            %k=basic_trust(service_judged,Neighbors(i))*basic_trust(service_judged,Neighbors(j))+basic_trust(service_judged,Neighbors(i))*basic_uncertain(service_judged,Neighbors(j))+basic_uncertain(service_judged,Neighbors(i))*basic_trust(service_judged,Neighbors(j))+basic_untrust(service_judged,Neighbors(i))*basic_untrust(service_judged,Neighbors(j))+basic_untrust(service_judged,Neighbors(i))*basic_uncertain(service_judged,Neighbors(j))+basic_uncertain(service_judged,Neighbors(i))*basic_untrust(service_judged,Neighbors(j))+basic_uncertain(service_judged,Neighbors(i))*basic_uncertain(service_judged,Neighbors(j));
            %disp('basic_uncertain(service_judged)');
            %disp(basic_uncertain(service_judged));
            %t=basic_trust(service_judged,Neighbors(i))*basic_trust(service_judged,Neighbors(j))+basic_trust(service_judged,Neighbors(i))*basic_uncertain(service_judged,Neighbors(j))+basic_uncertain(service_judged,Neighbors(i))*basic_trust(service_judged,Neighbors(j));
         disp('basic_trust(service_judged,Neighbors(i))*basic_trust(service_judged,Neighbors(j))');
         disp(basic_trust(service_judged,Neighbors(i))*basic_trust(service_judged,Neighbors(j)));
         disp('basic_untrust(service_judged,Neighbors(i))*basic_untrust(service_judged,Neighbors(j))');  
         disp(basic_untrust(service_judged,Neighbors(i))*basic_untrust(service_judged,Neighbors(j)));  
         disp('basic_uncertain(service_judged,Neighbors(i))*basic_uncertain(service_judged,Neighbors(j))');
         disp(basic_uncertain(service_judged,Neighbors(i))*basic_uncertain(service_judged,Neighbors(j)));
         t=basic_trust(service_judged,Neighbors(i))*basic_trust(service_judged,Neighbors(j))+basic_untrust(service_judged,Neighbors(i))*basic_untrust(service_judged,Neighbors(j))+basic_uncertain(service_judged,Neighbors(i))*basic_uncertain(service_judged,Neighbors(j));
         k=(basic_trust(service_judged,Neighbors(i))*basic_uncertain(service_judged,Neighbors(j))+basic_uncertain(service_judged,Neighbors(i))*basic_trust(service_judged,Neighbors(j))+basic_untrust(service_judged,Neighbors(i))*basic_uncertain(service_judged,Neighbors(j))+basic_uncertain(service_judged,Neighbors(i))*basic_untrust(service_judged,Neighbors(j)));
          if(k>1)
              k=1;
          else
              k=(basic_trust(service_judged,Neighbors(i))*basic_uncertain(service_judged,Neighbors(j))+basic_uncertain(service_judged,Neighbors(i))*basic_trust(service_judged,Neighbors(j))+basic_untrust(service_judged,Neighbors(i))*basic_uncertain(service_judged,Neighbors(j))+basic_uncertain(service_judged,Neighbors(i))*basic_untrust(service_judged,Neighbors(j)));
          end
            %end     
        end
    end
    disp('t');
   disp(t);
   disp('k');
   disp(k);
    belief=t/k;
    if(belief>1)
       belief=belief-1;
    else
       belief=t/k;
    end
 %end
  
end

