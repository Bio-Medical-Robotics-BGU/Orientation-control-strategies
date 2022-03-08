function [KnoBLmean,KnoBL] = groupAxes(D,initials,group,keeptrials)
%%
numSubs = length(initials);
K = nan(420,3,numSubs);
KnoBL = nan(420,3,numSubs);

for subNum = 1:numSubs
    subData = D.(initials{subNum});
    trials = keeptrials{subNum};
    
    VF = importdata('VF.txt');
    subtractTrials1 = 81:120;
    subtractTrials1(VF(81:120)==0) = [];
    subtractTrials2 = 141:180;
    subtractTrials2(VF(141:180)==0) = [];


    for trNum = 0:419
        % get desired axis
        switch group
            case 1
                desBL1 = [0 -1 1]/sqrt(2);
                desBL2 = [0 1 1]/sqrt(2);
            case 2
                desBL1 = [0 1 1]/sqrt(2);
                desBL2 = [0 1 1]/sqrt(2);
            case 3
                desBL1 = [0 1 1]/sqrt(2);
                desBL2 = [0 -1 1]/sqrt(2);
        end
        desTRN = axang2rotm([1 0 0 -pi/3])*desBL1';
        % get axis
        if ismember(trNum,trials)
            if trNum<=29 || (trNum>=60 && trNum<=119)
                desiredAxis = desBL1;
            elseif trNum>=180 && trNum<=359
                desiredAxis = desTRN;
            else
                desiredAxis = desBL2;
            end
            K(trNum+1,:,subNum) = subData.(['trial',num2str(trNum)]).kAdaptation;
        end
    end
   
    % reduce baseline
    kBL1 = meanDirection3D(K(subtractTrials1,:,subNum))';
    kBL2 = meanDirection3D(K(subtractTrials2,:,subNum))';
    rotmBL1 = axang2rotm([cross(kBL1,desBL1)./norm(cross(kBL1,desBL1)),acos(dot(kBL1,desBL1))]);
    rotmBL2 = axang2rotm([cross(kBL2,desBL2)./norm(cross(kBL2,desBL2)),acos(dot(kBL2,desBL2))]);
    for trNum=0:419
        if ismember(trNum,[0:29,60:119,180:359])
            KnoBL(trNum+1,:,subNum) = (rotmBL1*K(trNum+1,:,subNum)')';
        else
            KnoBL(trNum+1,:,subNum) = (rotmBL2*K(trNum+1,:,subNum)')';
        end
    end
end

K = K(61:420,:,:);
KnoBL = KnoBL(61:420,:,:);

for trNum = 1:360
    KnoBLmean(trNum,:) = meanDirection3D(squeeze(KnoBL(trNum,:,:))')';
end
end
