function [errnoBL,M,S,err,M_FML,S_FML,err_FML] = groupAngles(D,initials,group,keeptrials)

numSubs = length(initials);
K = nan(420,3,numSubs);
KnoBL = nan(420,3,numSubs);
err = nan(numSubs,420);
errnoBL = nan(numSubs,420);

for subNum = 1:numSubs
    subData = D.(initials{subNum});
    trials = keeptrials{subNum};
    
    VF = importdata('VF.txt');
    subtractTrials1 = 81:120;
    subtractTrials1(VF(81:120)==0) = [];
    subtractTrials2 = 141:180;
    subtractTrials2(VF(141:180)==0) = [];
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
    desTRN =desBL1';

    for trNum = 0:419
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
        
        ax = dot(K(trNum+1,:,subNum),[1 0 0]);
        ay = dot(K(trNum+1,:,subNum),desiredAxis);
        az = dot(K(trNum+1,:,subNum),cross([1 0 0],desiredAxis));
        elevation = atan2d(az,sqrt(ax.^2 + ay.^2));
        err(subNum,trNum+1) = elevation;
    end
    
    % reduce baseline on error
    BL1 = nanmean(err(subNum,subtractTrials1));
    BL2 = nanmean(err(subNum,subtractTrials2));
    err(subNum,[1:30,61:120,181:360]) = err(subNum,[1:30,61:120,181:360]) - BL1;
    err(subNum,[31:60,121:180,361:420]) = err(subNum,[31:60,121:180,361:420])- BL2;

    % reduce baseline
    kBL1 = meanDirection3D(K(subtractTrials1,:,subNum))';
    kBL2 = meanDirection3D(K(subtractTrials2,:,subNum))';
    rotmBL1 = axang2rotm([cross(kBL1,desBL1)./norm(cross(kBL1,desBL1)),acos(dot(kBL1,desBL1))]);
    rotmBL2 = axang2rotm([cross(kBL2,desBL2)./norm(cross(kBL2,desBL2)),acos(dot(kBL2,desBL2))]);
    
    for trNum=0:419
        
        if trNum<=29 || (trNum>=60 && trNum<=119)
            desiredAxis = desBL1;
        elseif trNum>=180 && trNum<=359
            desiredAxis = desTRN;
        else
            desiredAxis = desBL2;
        end
        
        if ismember(trNum,[0:29,60:119,180:359])
            KnoBL(trNum+1,:,subNum) = (rotmBL1*K(trNum+1,:,subNum)')';
        else
            KnoBL(trNum+1,:,subNum) = (rotmBL2*K(trNum+1,:,subNum)')';
        end
        
        ax = dot(KnoBL(trNum+1,:,subNum),[1 0 0]);
        ay = dot(KnoBL(trNum+1,:,subNum),desiredAxis);
        az = dot(KnoBL(trNum+1,:,subNum),cross([1 0 0],desiredAxis));
        elevation = atan2d(az,sqrt(ax.^2 + ay.^2));
        errnoBL(subNum,trNum+1) = elevation;
    end
end

err_FML = err(:,1:60);
M_FML = nanmean(err_FML,1);
S_FML = nanstd(err_FML,1)./sqrt(numSubs);

err = err(:,61:420);
err1 = nanmean(err,1);
errnoBL = -errnoBL(:,61:420);
M = -err1;
S = nanstd(err,1)./sqrt(numSubs);


end
