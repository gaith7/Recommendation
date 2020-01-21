function [ tElapsed, num_iterations] = ReplaceService( coalition, maliciousService, maliciousServicesArray )

num_iterations=0;

tStart = tic;
for j=1:size(coalition,1)
    for k=1:size(coalition,2)
        [ malicious ] = isMalicious( coalition(j,k), maliciousServicesArray );
        if(coalition(j,k)==maliciousService || malicious==false)
            num_iterations=num_iterations+coalition(j,k);
        end
    end
end

tElapsed = toc(tStart);

end

