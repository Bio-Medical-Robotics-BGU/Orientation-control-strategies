function quatInit = getInitialQuat(codeInit,codeFinal,trNum,intAxis,extAxis,theta)
%% get initial quaternion
switch (codeInit(trNum+1))
    case 0
        targetQuat = getFinalQuat(codeInit,codeFinal,trNum,intAxis,extAxis,theta);
        if sum(isnan(intAxis)) == 0 % int
            quatInit = quatmultiply(targetQuat,quatinv(axang2quat([intAxis,theta])));
        elseif sum(isnan(extAxis)) == 0 % ext
            quatInit = quatmultiply(quatinv(axang2quat([extAxis,theta])),targetQuat);
        end
    case 1
        q0 = [1 0 0 0];
        dq1 = axang2quat([1 0 0 deg2rad(40)]);
        dq2 = axang2quat([0 1 0 deg2rad(0)]);
        dq3 = axang2quat([0 0 1 deg2rad(20)]);
        quat_temp1 = quatmultiply(dq1,q0);
        quat_temp2 = quatmultiply(dq2,quat_temp1);
        quatInit = quatmultiply(dq3,quat_temp2);
    case 2
        q0 = [1 0 0 0];
        dq1 = axang2quat([1 0 0 deg2rad(20)]);
        dq2 = axang2quat([0 1 0 deg2rad(0)]);
        dq3 = axang2quat([0 0 1 deg2rad(40)]);
        quat_temp1 = quatmultiply(dq1,q0);
        quat_temp2 = quatmultiply(dq2,quat_temp1);
        quatInit = quatmultiply(dq3,quat_temp2);
    otherwise
        quatInit = [nan,nan,nan,nan];
end
end