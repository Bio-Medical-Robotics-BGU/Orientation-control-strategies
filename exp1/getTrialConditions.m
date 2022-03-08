function conditions = getTrialConditions(GroupNum,trNum)
%% Get trial conditions
intAxisG1 = textread('kaG1.txt');
intAxisG2 = textread('kaG2.txt');

extAxisG1 = textread('kbG1.txt');
extAxisG2 = textread('kbG2.txt');

quatInitG1 = textread('RiG1.txt');
quatInitG2 = textread('RiG2.txt');

quatFinalG1 = textread('RfG1.txt');
quatFinalG2 = textread('RfG2.txt');

theta = textread('theta.txt');

switch (GroupNum)
    case 1
        conditions.rotationangle = theta(trNum+1);
        conditions.intAxis = getAxis(intAxisG1(trNum+1));
        conditions.extAxis = getAxis(extAxisG1(trNum+1)); 
        conditions.quatInit = getInitialQuat(quatInitG1,quatFinalG1,trNum,conditions.intAxis,conditions.extAxis,deg2rad(theta(trNum+1)));  
        conditions.quatFinal = getFinalQuat(quatInitG1,quatFinalG1,trNum,conditions.intAxis,conditions.extAxis,deg2rad(theta(trNum+1)));
        conditions.code = [intAxisG1(trNum+1),extAxisG1(trNum+1),quatInitG1(trNum+1),quatFinalG1(trNum+1)];
        
        if sum(isnan(conditions.intAxis)) == 0 % if int axis is defined, let's calculate the extrinsic
            dq = quatmultiply(conditions.quatFinal,quatinv(conditions.quatInit));
            axang = quat2axang(dq);
            conditions.extAxis = axang(1:3);
        end
        if sum(isnan(conditions.extAxis)) == 0 % if ext axis is defined, let's calculate the intrinsic
            dq = quatmultiply(quatinv(conditions.quatInit),conditions.quatFinal);
            axang = quat2axang(dq);
            conditions.intAxis = axang(1:3);
        end
        
    case 2
        conditions.rotationangle = theta(trNum+1);
        conditions.intAxis = getAxis(intAxisG2(trNum+1));
        conditions.extAxis = getAxis(extAxisG2(trNum+1)); 
        conditions.quatInit = getInitialQuat(quatInitG2,quatFinalG2,trNum,conditions.intAxis,conditions.extAxis,deg2rad(theta(trNum+1)));  
        conditions.quatFinal = getFinalQuat(quatInitG2,quatFinalG2,trNum,conditions.intAxis,conditions.extAxis,deg2rad(theta(trNum+1)));
        conditions.code = [intAxisG2(trNum+1),extAxisG2(trNum+1),quatInitG2(trNum+1),quatFinalG2(trNum+1)];
        
        if sum(isnan(conditions.intAxis)) == 0 % if int axis is defined, let's calculate the extrinsic
            dq = quatmultiply(conditions.quatFinal,quatinv(conditions.quatInit));
            axang = quat2axang(dq);
            conditions.extAxis = axang(1:3);
        end
        if sum(isnan(conditions.extAxis)) == 0 % if ext axis is defined, let's calculate the intrinsic
            dq = quatmultiply(quatinv(conditions.quatInit),conditions.quatFinal);
            axang = quat2axang(dq);
            conditions.intAxis = axang(1:3);
        end
end
end