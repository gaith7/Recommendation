N=input('Please give the number of nodes:');
mal=input('Please give the percentage of malicious nodes:');
nmpr=input('Please give the number of MPRs:');
% Number of malicious nodes
nmal=mal*N/100;
nmal=round(nmal);

%% Nodes Matrix
% Colon 1: Node id.
mat=1:N;
mat=mat';

% Colon 2: Node Behavior "0" if malicious, "1" if Cooperative.
mat=[mat,ones(N,1)];
r= randi(N,1,nmal);
for i=1:nmal
    mat(r(i),2)=0;
end

% Colon 3: Nodes Reputations.
% The reputation is between 0 & 250.
r = 0 + (250-0).*rand(N,1);
% The malicious nodes' reputations are between 0 & 100.
for i=1:N
    if mat(i,2)==0
        r(i,1)= 0 + (100-0).*rand(1,1);
    end
end
mat=[mat,r];

% Colon 4: Vehicule 'X' Position "between 0 and 1000"
r= randi(1000,1,N);
r=r';
mat=[mat,r];

% Colon 5: Vehicule 'Y' Position "between 0 and 1000"
r= randi(1000,1,N);
r=r';
mat=[mat,r];

% Colon 6: "0" Regular Node, "1" if MPR.
mat=[mat,zeros(N,1)];
r= randi(N,1,nmpr);
for i=1:nmpr
    mat(r(i),6)=1;
end
% Number of MPRs
nmpr=0;
for i=1:N
    if mat(i,6)==1
        nmpr=nmpr+1;
    end
end
    
%% Nodes Neighborhoods
% Colon 1 Node id.
neighbor=1:N;
neighbor=neighbor';

% Colon 2 Number of neighbors.
maxn=0;
n=0;
d=300;
for i=1:N
    for j=1:N
        d=sqrt((mat(j,4)-mat(i,4))^2 + (mat(j,5)-mat(i,5))^2);
        if d<200&&i~=j
            n=n+1;
        end
    end
    neighbor(i,2)=n;
    if maxn<n
        % maxn is the maximum number of neighbors.
        maxn=n;
    end
    n=0;
end

% Colon 3 ... Colon maxn: node neighbors' ids.
n=0;
d=300;
nei=zeros(N,maxn);
for i=1:N
    for j=1:N
        d=sqrt((mat(j,4)-mat(i,4))^2 + (mat(j,5)-mat(i,5))^2);
        if d<200&&i~=j
            n=n+1;
            nei(i,n)=j;
        end
    end
    n=0;
end
neighbor=[neighbor,nei];

%% Combination of judgments on MPRs
v=0;n=0;
des=zeros(nmpr,6);
for i=1:N
    sum=0;
    %% Matrix v: Colon 1 =>Charged MPR ; Colon 2 =>  MPR Real Behavior ;
    % Line 1 => Node's watchdogs;
    % Line 2 => Watchdog's reputation ; Line 3 => Watchdog's Real Behavior;
    % Line 4 => Watchdog's trustworthiness probability.
    if mat(i,6)==1
        n=n+1;
        v=neighbor(i,:);
        disp('neighbor(i,:)');
        disp(neighbor(i,:));
        v(2,:)=v;
        v(2,2)= mat(i,2);
        v(3,:)=v(2,:);
        for j=3:(maxn+2)
            if v(1,j)~=0
               v(2,j)=mat(v(1,j),3);
               v(3,j)=mat(v(1,j),2);
               sum=sum+mat(v(1,j),3);
            end
        end
        v(4,:)=v(2,:);
        
        for j=3:(maxn+2)
            v(4,j)=v(2,j)/sum;
        end
        
        %% Matrix a Dempster combination Matrix
        % Colon 1 => Watchdog 1 judgment
        % Line 2 => Watchdog 2 judgment
        a=zeros(4,4);
        if v(2,2)==1
            a(2+v(3,3),1)=v(4,3);
            a(4,1)=1-v(4,3);
        else
            if v(3,3)==1
                a(2,1)= v(4,3);
                a(4,1)=1-v(4,3);
            else
                a(3,1)= v(4,3);
                a(4,1)=1-v(4,3);
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
        des(n,2)=mat(i,2);
        des(n,3)=a(2,1);
        des(n,4)=a(3,1);
        des(n,5)=a(4,1);
        if a(3,1)>=0.5
            des(n,6)=1;
        else des(n,6)=0;
        end
    end
end
mat
des

                   