function [ partition ] = FormCoalitions( partition, beliefsVector, CoalitionsValues )

utility=[]; %utility believed by node i towards coalition c.
UpdatedPartition=[];
history=zeros(size(partition,1)*10);

for m=1:size(partition,1)
  for i=1:2:length(beliefsVector)
     if(beliefsVector(i+1)<0.5)
        %utility=[utility partition(m)]; %service having belief
        utility=[utility beliefsVector(i)];% service being believed
        utility=[utility -999999999]; %utility value
     else
     if(history(partition(m))==beliefsVector(i))
        %utility=[utility partition(m)];
        utility=[utility beliefsVector(i)];
        utility=[utility 0];
     else
        %utility=[utility partition(m)];
        utility=[utility beliefsVector(i)];
        utility=[utility beliefsVector(i+1)];
     end
     end
  end
end

coalitions={};
for i=1:length(partition)-1
    for j=2:length(partition)
%newCoalition=cell(1, length(partition));
newCoalition=[partition(i) partition(j)];
coalitions(i,j)= {newCoalition};
        %coalitions{={coalitions [partition(i) partition(j)]};
    end
end

%disp('coal');
%celldisp(coalitions);
%cellplot(coalitions);

[ coali ] = Merge( coalitions );

disp('coali');
celldisp(coali);

[ coali22 ] = Merge( coali );

ind = true(1,numel(coali22)); %// true indicates non-duplicate. Initiallization
for ii = 1:numel(coali22)-1
    for jj = ii+1:numel(coali22)
        if isequal(coali22{ii}, coali22{jj})
            ind(jj) = false; %// mark as duplicate
        end
    end
end
TILER2 = coali22(ind);

disp('coali22');
disp(unique(TILER2{1,2}));
%celldisp(TILER2);

c = combnk(partition,2);
%disp('C');
%disp(c);

%disp('CoalitionsValues 1');
%disp(CoalitionsValues);
   
for i=1:length(CoalitionsValues)
    if(CoalitionsValues(i)<0.5)
        CoalitionsValues(i)=-9;
    end
end

%disp('CoalitionsValues 2');
%disp(CoalitionsValues);

utility2=[];
coalitions2=[];
for i=1:size(c,1)
    utility2=[utility2 CoalitionsValues(c(i,1))+CoalitionsValues(c(i,2))];
    coalitions2=[coalitions2 c(i,1)];
    coalitions2=[coalitions2 c(i,2)];
    coalitions2=[coalitions2 CoalitionsValues(c(i,1))+CoalitionsValues(c(i,2))];
end

%%%%%% coalitions2 after removing the coalitions having negative utility %
coalitions3=[];
for i=1:3:length(coalitions2)-2
   if(coalitions2(i+2)>=0)
    coalitions3=[coalitions3 coalitions2(i)];
    coalitions3=[coalitions3 coalitions2(i+1)];
    coalitions3=[coalitions3 coalitions2(i+2)]; 
   end
end

coalitions3_1=[];
for i=1:3:length(coalitions3)-1
    coalitions3_1=[coalitions3_1 coalitions3(i)];
    coalitions3_1=[coalitions3_1 coalitions3(i+1)];
end

coalitions4_1=unique(coalitions3_1);

cc = combnk(coalitions4_1,3);
%disp('CC');
%disp(cc);

coalitions4=[];
for i=1:size(cc,1)
    coalitions4=[coalitions4 cc(i,1)];
    coalitions4=[coalitions4 cc(i,2)];
    coalitions4=[coalitions4 cc(i,3)];
    coalitions4=[coalitions4 CoalitionsValues(cc(i,1))+CoalitionsValues(cc(i,2))+CoalitionsValues(cc(i,3))];
end

ccc = combnk(coalitions4_1,4);
%disp('CCC');
%disp(ccc);

coalitions5=[];
for i=1:size(ccc,1)
    coalitions5=[coalitions5 ccc(i,1)];
    coalitions5=[coalitions5 ccc(i,2)];
    coalitions5=[coalitions5 ccc(i,3)];
    coalitions5=[coalitions5 ccc(i,4)];
    coalitions5=[coalitions5 CoalitionsValues(ccc(i,1))+CoalitionsValues(ccc(i,2))+CoalitionsValues(ccc(i,3))+CoalitionsValues(ccc(i,4))];
end

%disp('utility2');
%disp(utility2);

%disp('coalitions2');
%disp(coalitions2);

%disp('length(coalitions2)');
%disp(length(coalitions2));

%disp('length(coalitions3)');
%disp(length(coalitions3));

%disp('coalitions2');
%disp(coalitions2);

%disp('coalitions3');
%disp(coalitions3);

%disp('coalitions3_1');
%disp(coalitions3_1);

%disp('coalitions4');
%disp(coalitions4);

%disp('coalitions5');
%disp(coalitions5);

UpdatedPartition=[coalitions2 coalitions3 coalitions4 coalitions5];

%disp('UpdatedPartition');
%disp(UpdatedPartition);

%for i=1:length(utility)
%   for j=1:size(c,1)
 %   if(utility(i)==c(j))
        
  %  end
  % end 
%end

%CoalitionsValues=[0.5 -99999 0.3 0.6 0.43 0 0 0.34 0.1 0.92 0.13 0 0.74 -99999 0.87 0.5 0.45 0 0.21 0.23];

%CoalitionsValues=[0.5 -99999 0.3 0.6 0.43 0 0.12 0.34];

c = combnk(partition,3);
%disp('Matrix');
%disp(c);

clm_3={[1 2 5 6] [1 3 4], [1 6 7], [2 3 6 7], [2 4 7], [2 5 7], [4 5 6 7], [1 2 3 4 5 6 7]};
%tic;[v]=vclToMatlab(clm_3,CoalitionsValues);toc
%permutations=[];
%permutations=[];
%for k=1:length(partition)
 %  c = combnk(partition,k);
  % permutations= horzcat(permutations, c);
%end
%F=magic(5);
%G=PermutationGame(F);

%[crq x]=p_coreQ(v);

%[Matrix,Index] = npermutek(partition,3);
%P = perms(partition);
%disp('Game');
%disp(v);
%disp('crq');
%disp(crq);
%disp('x');
%disp(G);
%for i=1:length(utility)     
%end

end

