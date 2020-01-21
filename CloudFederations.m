function [ FinalCoalitionSet, ProvidedAvailability ] = CloudFederations( partition, availability )

OptimalPrice=100;
Beta=1;
price=zeros(length(partition),1);
cost=zeros(length(partition),1);
MinCost=10;
MaxCost=100;

for i=1:length(partition)
    cost(partition(i))= (MaxCost-MinCost).*rand(1,1) + MinCost;
end

for i=1:length(partition)
    price(partition(i))= OptimalPrice*((availability(partition(i))/100)^Beta);
end

community=[1];

joiningWS=2;

CostCommunity=0;
for i=1:length(community)
    CostCommunity = CostCommunity + (cost(community(i))+(1-availability(community(i)))*cost(joiningWS));
end

community=[1,2];

AvailabilityCommunity =1;
for i=1:length(community)
    AvailabilityCommunity = AvailabilityCommunity*(1-availability(community(i)));
end

AvailabilityCommunity = 1- AvailabilityCommunity;

PriceCommunity=0;
for i=1:length(partition)
    PriceCommunity = OptimalPrice*((AvailabilityCommunity)^Beta);
end

PayoffWS=zeros(length(partition),1);
Worth=zeros(length(partition),1);

WorthCommunity=(AvailabilityCommunity*PriceCommunity)-CostCommunity;

for i=1:length(community)
    Worth(community(i))=(availability(i)*price(i))-cost(i);
end

WS=2;
[ Worth ] = WorthWSAvailability( availability(WS), price(WS), cost(WS) );

[ payoff ] = ComputePayoffAvailability( community, WorthCommunity, Worth );

for i=1:length(partition)
    Worth(partition(i))= (availability(partition(i))*price(partition(i)))-cost(partition(i));
end

[ FinalCoalitionSet, ProvidedAvailability ] = FormCoalitionsAvailability( partition, Worth, availability );

%disp('PreferredCoalition');
%disp(PreferredCoalition);
%disp('MaxWorth');
%disp(MaxWorth);

end

