function quatFinal = getFinalQuat(codeInit,codeFinal,trNum,intAxis,extAxis,theta)
%% get target quaternion
switch (codeFinal(trNum+1))
    case 0
        initialQuat = getInitialQuat(codeInit,codeFinal,trNum,intAxis,extAxis,theta);
        if sum(isnan(intAxis)) == 0 % int
            quatFinal = quatmultiply(initialQuat,axang2quat([intAxis,theta]));
        elseif sum(isnan(extAxis)) == 0 % ext
            quatFinal = quatmultiply(axang2quat([extAxis,theta]),initialQuat);
        end
    case 1
        q0 = [1 0 0 0];
        dq1 = axang2quat([1 0 0 deg2rad(0)]);
        dq2 = axang2quat([0 1 0 deg2rad(-30)]);
        dq3 = axang2quat([0 0 1 deg2rad(60)]);
        quat_temp1 = quatmultiply(dq1,q0);
        quat_temp2 = quatmultiply(dq2,quat_temp1);
        quatFinal = quatmultiply(dq3,quat_temp2);
    case 2
        q0 = [1 0 0 0];
        dq1 = axang2quat([1 0 0 deg2rad(0)]);
        dq2 = axang2quat([0 1 0 deg2rad(-10)]);
        dq3 = axang2quat([0 0 1 deg2rad(50)]);
        quat_temp1 = quatmultiply(dq1,q0);
        quat_temp2 = quatmultiply(dq2,quat_temp1);
        quatFinal = quatmultiply(dq3,quat_temp2);
    otherwise
        quatFinal = [nan,nan,nan,nan];
end
end