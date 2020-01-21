function [ payoff ] = ComputePayoffAvailability( community, WorthCommunity, worthWS )

payoff=0;
WorthCommunityWithoutWS=WorthCommunity-worthWS;

for i=1:length(community)
    payoff= 1/length(community)*((WorthCommunity-WorthCommunityWithoutWS)+worthWS);
end

end

