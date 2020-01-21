function [ des ] = DempsterShaferAggregation( Neighbors )
%% Combination of judgments on MPRs
v=0;n=0;
des=zeros(size(Neighbors,1),6);
p=0.6;
Trustworthiness = randsrc(1,1,[0 1; (1-p) p]); %generate a random sample of 0's and 1's of size N, such that the probability of of 1 being chosen is p

for i=1:size(Neighbors,1)
    sum=0;
    %% Matrix v: Colon 1 =>Charged MPR ; Colon 2 =>  MPR Real Behavior ;
    % Line 1 => Node's watchdogs;
    % Line 2 => Watchdog's reputation ; Line 3 => Watchdog's Real Behavior;
    % Line 4 => Watchdog's trustworthiness probability.
        n=n+1;
        v=Neighbors;
        %v(2,:)=v;
        v(2,2)= Trustworthiness;
        v(3,:)=v(2,:);
        %for j=3:(size(Neighbors,1))
            %if v(1,j)~=0
               %v(2,j)=mat(v(1,j),3);
               %v(3,j)=mat(v(1,j),2);
               %sum=sum+mat(v(1,j),3);
            %end
        %end
        v(4,:)=v(2,:);
        
        for j=3:(size(Neighbors,1)-1)
            v(4,j)=v(2,j)/sum;
        end
        
        %% Matrix a Dempster combination Matrix
        % Colon 1 => Watchdog 1 judgment
        % Line 2 => Watchdog 2 judgment
        a=zeros(4,4);
        if v(2,2)==1
            a(2+v(3,2),1)=v(4,2);
            a(4,1)=1-v(4,2);
        else
            if v(3,2)==1
                a(2,1)= v(4,2);
                a(4,1)=1-v(4,2);
            else
                a(3,1)= v(4,2);
                a(4,1)=1-v(4,2);
            end
        end
        if v(1,2)>1
            for j=4:(v(1,2)+2)
                a(1,:)=0;
                if v(2,2)==1
                    a(1,2+v(3,j))=v(4,j);
                    a(1,4)=1-v(4,j);
                else
                    if v(3,j)==1
                        a(1,2)=v(4,j);
                        a(1,4)=1-v(4,j);
                    else
                        a(1,3)=v(4,j);
                        a(1,4)=1-v(4,j);
                    end
                end
                for k=2:4
                    for q=2:4
                        a(k,q)=a(1,k)*a(q,1);
                    end
                end
                K=a(3,2)+a(4,2)+a(2,3)+a(4,3)+a(2,4)+a(3,4);
                a(2,1)= (a(2,2)+a(4,2)+a(2,4))/K;
                a(3,1)= (a(3,3)+a(4,3)+a(3,4))/K;
                a(4,1)= a(4,4)/K;
            end
        end
        
        %% Matrix 'des' Decision Matrix
        % Colon 1 => MPRs
        % Colon 2 => MPR's Real Behavior
        % Colon 6 => Dempter Decision
        des(n,1)=i;
        des(n,2)=Trustworthiness;
        des(n,3)=a(2,1);
        des(n,4)=a(3,1);
        des(n,5)=a(4,1);
        if a(3,1)>=0.5
            des(n,6)=1;
        else des(n,6)=0;
        end
end

