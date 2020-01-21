function [ malicious ] = isMalicious( service, ArrayOfMaliciousServices )

malicious=false;

for i=1:length(ArrayOfMaliciousServices)
    if(ArrayOfMaliciousServices(i)==service)
        %disp('ArrayOfMaliciousServices(i)');
        %disp(ArrayOfMaliciousServices(i));
        malicious=true;
    end
end

end

