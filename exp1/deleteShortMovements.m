function [newInds,numSubMovements,subSegments] = deleteShortMovements(inds,nSamps)
%% Do not account for too short movements
first = find(diff([0;inds]) == 1);
last = find(diff([inds;0]) == -1);

subSegments = [first,last];
ignore = (last-first)<nSamps;
subSegments(ignore,:) = [];

newInds = zeros(length(inds),1);
for i=1:size(subSegments,1)
    newInds(subSegments(i,1):subSegments(i,2)) = 1;
end

numSubMovements = size(subSegments,1);
end
