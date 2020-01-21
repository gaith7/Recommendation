function [ isElement ] = isElementOfList( list, element )

isElement=false;

for i=1:length(list)
    if(list(i)==element)
        isElement=true;
    end
end

end

