format long

[ ResponseTime,Av,Throughput,Successability,Reliability,Compliance,BestPractices,Latency,ServiceName,WSDLAddress ]  = ConvertToTxtToMatrix();
 
QoS = zeros(size(ResponseTime,1),1);

for i=1:size(ResponseTime,1)
    QoS(i)=ResponseTime(i)+Av(i)+Reliability(i)+Latency(i);
end
%InitialTrust = randsrc(length(ResponseTime),1,[0 1;0.4 0.6]); % 1 for trustworthy and 0 for misbehaving

%cm = sparse([1 1 2 2 3 3 4 5],[2 3 4 5 4 5 6 6],...
     %[0.5 0.65 0.9 0.1 0.85 0.2 0.35 0.4],6,6);
 cm = sparse([1 1 2 2 3 3 4 5],[2 3 4 5 4 5 6 6],...
      [1 1 1 -1 1 -1 -1 -1],6,6);
 %reputation=[1 0.6 2 0.65 3 0.9 4 0.43 5 0.98 6 0.23];
 reputation=[1 0.6 2 0.65 3 0.9 4 0.55 5 0.98 6 0.83];
 %reputation=[1 0.6 2 0.65 3 0.9 4 0.25 5 0.98 6 0.33];
 %disp(reputation);
 
 [distance, discoverTime, pred] = bfs(cm,1); %stops the bfs when it hits the vertex v
 [ utility ] = GetUtilityNode( cm, 2);
 [ AreNeighbors ] = ExistEdge( cm, 1, 5 );
 
 list=[];
 Graph=full(cm);
 %[ Neighbors ] = GetDirectNeighbors( Graph, 4 );
 %for i=1:size(Graph,1)
  %[ Neighbors ] = GetDirectNeighbors( Graph, i );
  %list=[list; Neighbors];
 %end
 %[ des ] = DempsterShaferAggregation( Neighbors );
 beliefsVector=[];
 TrustValues=[];
 for i=1:6
 [ belief ] = DS( Graph, reputation, i );
 beliefsVector=[beliefsVector i];
 beliefsVector=[beliefsVector belief];
 %TrustValues=[TrustValues belief];
 end
 
 vall=0;
 for i=1:186
     vall=(1-0.2).*rand(1,1) + 0.2;
     TrustValues=[TrustValues vall];
 end
 
 %services=[]; %stores all the services
 
 %for i=1:2:length(beliefsVector)
      %services=[services beliefsVector(i)];
 %end
 
%disp('services');
%disp(services);

%[ partition ] = FormCoalitions( services, beliefsVector, CoalitionsValues );
%[ NashStable ] = isNashStable();
%[ ServiceName, Region, Availability, Outages, DownTime ]  = ReadCloudDataSet();
[ ServiceName, Region, Availability, Outages, DownTime, Cost, Price ]  = ReadAmazonDataSet();

SLAavailability = zeros(length(Availability),1);
InitialTrust = zeros(length(Availability),1); % 1 for trustworthy and 0 for misbehaving

SLAavailability(:,:)=100;
for i=1:length(Availability)
    if(100-Availability(i)<0.2753)
       InitialTrust(i) = 1; 
    else
       InitialTrust(i) = 0;
    end
end

maliciousServices=[];

for j=1:length(InitialTrust)
    disp(InitialTrust(j));
end

for j=1:length(InitialTrust)
    if(InitialTrust(j)==0)
       maliciousServices=[maliciousServices j];
    end
end

TrustedServices=[];

for j=1:length(InitialTrust)
    if(InitialTrust(j)==1)
       TrustedServices=[TrustedServices j];
    end
end

dropPercentage=zeros(length(maliciousServices),1);
minDrop=1;
maxDrop=100;

for j=1:length(maliciousServices)
    dropPercentage(maliciousServices(j))=(maxDrop-minDrop).*rand(1,1) + minDrop;
end

%disp('Drop %');
%disp(dropPercentage);

MinCredibility=0.3;
MaxCredibility=1;
Credibility = (MaxCredibility-MinCredibility).*rand(length(Availability),1) + MinCredibility;

InitialPartition=[];
%InitialPartition=[1 2 3 4 5 6];

% for j=1:6
%    InitialPartition=[InitialPartition maliciousServices(j)];
% end
% 
% for p=1:4
%     InitialPartition=[InitialPartition TrustedServices(p)];
% end


 for j=1:2
    InitialPartition=[InitialPartition maliciousServices(j)];
 end

for p=1:3
    InitialPartition=[InitialPartition TrustedServices(p)];
end

disp('InitialPartition %');
disp(InitialPartition);

%[ FinalCoalitionSetChinese, providedAvailabilityChinese ] = AvailabilityCommunity( InitialPartition, Availability );
%[ FinalCoalitionSetEhsan, providedAvailabilityEhsan ] = EhsanCommunity( InitialPartition, QoS, Throughput, Availability );
[ FinalCoalitionSetHedonic, providedAvailabilityHedonic ] = FormCoalitionsHedonic( InitialPartition, TrustValues, Availability );
%[ FinalCoalitionSetFederation, providedAvailabilityFederation ] = CloudFederationsHedonic( InitialPartition, Price, Cost );


numRequests=1000;

% for i=0:FinalCoalitionSetChinese.size()-2
%     for j=1:FinalCoalitionSetChinese.size()-1
%         val1=FinalCoalitionSetChinese.get(i);
%         val2=FinalCoalitionSetChinese.get(j);
%         %tf = isequal(FinalCoalitionSetChinese.get(i),FinalCoalitionSetChinese.get(j));
%         if(length(val1)==length(val2))
%             for k=1:size(val1,1)
%                for kk=1:size(val1,2)
%                    for m=1:size(val2,1)
%                        for mm=1:size(val2,2)
%                            if(val1(k,kk)==val2(m,mm))
%                               %FinalCoalitionSetChinese.get(i)=val1(val1~=val1(k,kk));
%                            %else
%                               FinalCoalitionSetChinese.remove(FinalCoalitionSetChinese.get(j));
%                            end
%                        end
%                    end
%                end
%             end
%         end
%     end
% end

RequestsPerCoalition=uint8(numRequests/FinalCoalitionSetFederation.size());
disp('RequestsPerCoalition');
disp(RequestsPerCoalition);
 

TotalAvailabilityHedonic=0;
AvgAvailabilityHedonic=0;
countElementsHedonic=0;
nbDroppedRequestsHedonic=0;
nbPerformedRequestsHedonic=0;
maliciousServicesHedonic=[];
ReplaceTimeHedonic=0;
TotalMaliciousPerCoalitionHedonic=0;
TrustPerCoalitionHedonic=0;
TotalTrustHedonic=0;
 
for i=0:FinalCoalitionSetHedonic.size()-1
    coalitionHedonic=FinalCoalitionSetHedonic.get(i);
    RequestsPerServiceHedonic=RequestsPerCoalition/numel(coalitionHedonic);
    countMaliciousPerCoalitionHedonic=0;
    AvailabilityMaliciousPerCoalition=0;
    for j=1:size(coalitionHedonic,1)
        for k=1:size(coalitionHedonic,2)
            ReplaceTimeHedonic=ResponseTime(coalitionHedonic(j,k));
            TrustPerCoalitionHedonic=TrustPerCoalitionHedonic+TrustValues(coalitionHedonic(j,k));
            AvailabilityMaliciousPerCoalition=AvailabilityMaliciousPerCoalition+Availability(coalitionHedonic(j,k));
            countElementsHedonic=countElementsHedonic+1;
            [ malicious ] = isMalicious( coalitionHedonic(j,k), maliciousServices );
            if(malicious==true)
                maliciousServicesHedonic=[maliciousServicesHedonic coalitionHedonic(j,k)];
                [ tElapsed, num_iterations] = ReplaceService( coalitionHedonic, coalitionHedonic(j,k), maliciousServices );
                ReplaceTimeHedonic=ReplaceTimeHedonic+num_iterations;
                countMaliciousPerCoalitionHedonic=countMaliciousPerCoalitionHedonic+1;
                break;
            end
        end
    end
    TotalTrustHedonic=TotalTrustHedonic+TrustPerCoalitionHedonic;
    AvgTrustHedonic=TrustPerCoalitionHedonic/FinalCoalitionSetHedonic.size();
    TotalAvailabilityHedonic=TotalAvailabilityHedonic+AvailabilityMaliciousPerCoalition;
    TotalMaliciousPerCoalitionHedonic=TotalMaliciousPerCoalitionHedonic+countMaliciousPerCoalitionHedonic;
end

%AvgCountMaliciousHedonic=TotalMaliciousPerCoalitionHedonic*100/FinalCoalitionSetHedonic.size();
AvgCountMaliciousHedonic=TotalMaliciousPerCoalitionHedonic*100/countElementsHedonic;
%AvgTrustHedonic=TrustPerCoalitionHedonic/FinalCoalitionSetHedonic.size();

for i=1:length(maliciousServicesHedonic)
    nbDroppedRequestsHedonic=nbDroppedRequestsHedonic+(RequestsPerServiceHedonic*dropPercentage(maliciousServicesHedonic(i))/100);
end

nbPerformedRequestsHedonic=(RequestsPerServiceHedonic*countElementsHedonic)-nbDroppedRequestsHedonic;
ThroughputHedonic=100/ReplaceTimeHedonic;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('nbPerformedRequestsHedonic');
disp(nbPerformedRequestsHedonic);
disp('nbDroppedRequestsHedonic');
disp(nbDroppedRequestsHedonic);
disp('Response Time Hedonic');
disp(ReplaceTimeHedonic);
disp('Throughput Hedonic');
disp(ThroughputHedonic);
disp('AvgCountMaliciousHedonic');
disp(AvgCountMaliciousHedonic);
disp('FinalCoalitionSetHedonic.size()');
disp(FinalCoalitionSetHedonic.size());
disp('countElementsHedonic');
disp(countElementsHedonic);
AvgSizeCoalitionHedonic=countElementsHedonic/numel(InitialPartition);
disp('AvgSizeCoalitionHedonic');
disp(AvgSizeCoalitionHedonic);
disp('Maximum Size Coalition Hedonic');
MaxSizeCoalitionHedonic=max(FinalCoalitionSetHedonic.size()/numel(InitialPartition),FinalCoalitionSetHedonic.size()/countElementsHedonic*10);
disp(MaxSizeCoalitionHedonic);
disp('AvgTrustHedonic');
disp(AvgTrustHedonic);
