function [ FinalCoalitionSet, ProvidedAvailability ] = EhsanCommunity( partition, QoS, Throughput, availability )

Worth=zeros(length(partition),1);

for i=1:length(partition)
    Worth(partition(i))= QoS(i)*Throughput(i);
end

[ FinalCoalitionSet, ProvidedAvailability ] = FormCoalitionsEhsan( partition, Worth, availability );

%disp('PreferredCoalition');
%disp(PreferredCoalition);
%disp('MaxWorth');
%disp(MaxWorth);

end

