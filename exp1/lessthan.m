function [indter,L] = lessthan(trData,flag,threshold,duration)
% less than threshold degrees for duration samples
angularError = trData.angularError;
less = angularError<=deg2rad(threshold);
time = trData.time;

brd = find(diff(less));
if sum(less)
    segs = [brd(1:end),[brd(2:end)+1;length(time)]];    
    for segNum=1:size(segs,1)
        if (segs(segNum,2)-segs(segNum,1)>=duration)
            indter = segs(segNum,1);
            L = segs(segNum,2)-segs(segNum,1);
            break;
        else
            indter = NaN;
            L = NaN;
        end
    end
else
    indter = NaN;
    L = NaN;
end

if ~isnan(indter) && flag
    plot(time, angularError); hold on
    plot(time(less),angularError(less),'o')
    plot(time(1:indter), angularError(1:indter));
end
end