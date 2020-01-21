function [ utility ] = GetUtilityCoalition(coalition)

utility=0;
%A=full(graph);

%disp(size(A,2));

for i=1:size(coalition,1)
  for j=1:size(coalition,2)
    utility=utility+A(i,j);
  end
end

end

