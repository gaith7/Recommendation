function [ part, ProvidedAvailability ] = FormCoalitionsEhsan( partition, Worth, availability )

iteration=1;
part=java.util.LinkedList;

for i=1:length(partition)
    part.add(partition(i));
end

AvailabilityCoalitions=java.util.LinkedList;

while(iteration<3)
   
coalition=[];
WorthCoalition=0;
WorthCoalitions=java.util.LinkedList;

%li2=WorthCoalitions.listIterator;
CoalWorth=[];
PreferredCoalition=java.util.LinkedList;
li2=PreferredCoalition.listIterator;
CoalitionsAndWorths=java.util.LinkedList;
li=CoalitionsAndWorths.listIterator;
MaxWorth=zeros(length(part),1);

for i=0:part.size()-1
    for j=1:part.size()-1
       
        %WorthCoalitions.add(part.get(i));
        %WorthCoalitions.add(part.get(i));
        %WorthCoalitions.add(beliefs(part.get(i)));
        
        tf = isequal(part.get(i),part.get(j));
        if(tf==0)
           coalition=[part.get(i) part.get(j)];
           %disp('coalition');
           %disp(coalition);
           availabilityCoalition=0;
           for c=1:length(coalition)
               WorthCoalition=WorthCoalition+Worth(coalition(c));
               availabilityCoalition=availabilityCoalition+availability(coalition(c));
           end  
           
           for c=1:length(coalition)
            [ payoff ] = ComputePayoffAvailability(coalition, WorthCoalition, Worth(coalition(c)));
            WorthCoalitions.add(coalition(c));
            WorthCoalitions.add(coalition);
            WorthCoalitions.add(payoff);
            
            li.add(coalition(c));
            li.add(coalition);
            li.add(payoff); 
            AvailabilityCoalitions.add(coalition);
            AvailabilityCoalitions.add(availabilityCoalition);
            %disp('coalition(c)');
            %disp(coalition(c));
            %disp('coalition');
            %disp(coalition);
            %disp('WorthCoalition');
            %disp(WorthCoalition);
           end
           
        end
    end       
end

    
TempWorth=[];
for i=0:part.size()-1
   for k=0:3:WorthCoalitions.size()-1
       tff = isequal(part.get(i),WorthCoalitions.get(k)); 
       if(tff==1)
           %disp('WorthCoalitions.get(k+2)');
           %disp(WorthCoalitions.get(k+2));
          TempWorth=[TempWorth; WorthCoalitions.get(k+2)];
          TempWorth=unique(TempWorth);
          MaxWorth(i+1)=max(TempWorth);
       end
   end
   TempWorth=[];
end

MaxWorth=unique(MaxWorth);
%disp('MaxWorth');
%disp(unique(MaxWorth));

for k=2:3:WorthCoalitions.size()
    for i=1:length(MaxWorth)
        %disp('CoalitionsAndWorths.get(k)');
        %disp(CoalitionsAndWorths.get(k));
        %disp('MaxWorth(i)');
        %disp(MaxWorth(i));
        if(WorthCoalitions.get(k)==MaxWorth(i))
            %disp('trueee');
            li2.add(WorthCoalitions.get(k-1));
        end
    end
end

%%%%%%%% To remove duplicate elements from "PreferredCoalition"%%%%%%%%%%%
%Preferred=java.util.HashSet;
%Preferred.addAll(PreferredCoalition);
%PreferredCoalition.clear();
%PreferredCoalition.addAll(Preferred);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iteration==1)
   part.clear();
end

for p=0:PreferredCoalition.size()-1
    %disp('PreferredCoalition.get(p)');
    %disp(PreferredCoalition.get(p));
    part.add(PreferredCoalition.get(p));
end


iteration=iteration+1;

end  

%[ part ] = removeDuplicates( part );
%part=unique(part);
parti=java.util.LinkedList;
coalitionAvailability=zeros(length(part),1);

%for i=0:part.size()-1
    %for j=1:part.size()-2
        %tf = isequal(part.get(i),part.get(j));
        %if(tf==1)
           %disp('part part');
           %part=part(part~=part.get(j));
        %end
    %end
%end

TotalAvailability=0;
AvgAvailability=0;

for i=0:part.size()-1
    for j=0:2:AvailabilityCoalitions.size()-1
        tf = isequal(part.get(i),AvailabilityCoalitions.get(j));
        %disp('part.get(i)');
        %disp(part.get(i));
        %disp('AvailabilityCoalitions.get(j)');
        %disp(AvailabilityCoalitions.get(j));
        if(tf==1)
           %disp('availability(part.get(i)');
           %disp(availability(part.get(i)));
           TotalAvailability=TotalAvailability+AvailabilityCoalitions.get(j+1);
        end
    end
end

%for j=0:2:(AvailabilityCoalitions.size()/2)-1
    %disp('AvailabilityCoalitions.get(j)');
    %disp(AvailabilityCoalitions.get(j));
%end

%disp('TotalAvailability');
%disp(TotalAvailability);
%disp('PreferredCoalition.size()');
%disp(numel(PreferredCoalition));
AvgAvailability=TotalAvailability/PreferredCoalition.size();
ProvidedAvailability=AvgAvailability;
%disp('AvgAvailability');
%disp(AvgAvailability);
%for i=0:part.size()-1
    %disp('part.get(i)');
    %disp(part.get(i));
%end

end

