function trData100 = trFunction_exp1(subStr,trNum,GroupNum)

% load trial data
D = importdata([subStr,'_Trial',num2str(trNum),'.txt']);
trData = struct;
states = D.data(:,20);

trData.time = D.data(states==2,1);
trData.position = D.data(states==2,2:4);
trData.angularVelocity = D.data(states==2,17:19);
trData.numSamps = sum(states == 2);
rotationMatElements = D.data(states==2,5:13);

% Compute rotation matrix and quaternion, interpolate and downsample data
trData.rotationMatrix = zeros(3,3,trData.numSamps);
trData.quaternion = zeros(trData.numSamps,4);

for i=1:trData.numSamps
    R = [rotationMatElements(i,1:3)',rotationMatElements(i,4:6)',rotationMatElements(i,7:9)'];
    % orthogonalization
    [U,~,V] = svd(R);
    trData.rotationMatrix(:,:,i) = normc(U*V');
    trData.quaternion(i,:) = quatnormalize(rotm2quat(trData.rotationMatrix(:,:,i)));
end

trData100 = interpAndDownsample(trData);

% low pass filter angular velocity, compute angular speed
[b,a] = butter(4,2*6/100);
trData100.angularVelocity = filtfilt(b,a,trData100.angularVelocity);
trData100.angularSpeed = vecnorm(trData100.angularVelocity')';

% ignore slow or short movements, get non-overlapping submovements
angSpeedMax = max(abs(trData100.angularSpeed));
angSpeedFactor = 0.1;
indsAbove = trData100.angularSpeed >= angSpeedFactor.*angSpeedMax;
[~,~,trData100.subSegments] = deleteShortMovements(indsAbove,ceil(167*10^-3*100));

% get trial conditions
trData100.trialConditions = getTrialConditions(GroupNum,trNum);

% get error from target
dq2target = quatmultiply(repmat(trData100.trialConditions.quatFinal,trData100.numSamps,1),quatinv(trData100.quaternion));
trData100.angularError = 2*acos(dq2target(:,1));
[ind15,~] = lessthan(trData100,0,15,40);
take = trData100.subSegments(1,1):min(ind15,length(trData100.quaternion));
quat = trData100.quaternion(take,:);
trData100.QGS = geodicityFactor(quat);
trData100.ind15 = ind15;
end