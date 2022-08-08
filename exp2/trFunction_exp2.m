function trData100 = trFunction_exp2(subStr,trNum,GroupNum)

% load trial data
D = importdata([subStr,'_Trial',num2str(trNum),'.txt']);
trData = struct;

if (size(D.data,2)<20)
    states = str2double(D.textdata(:,20));
    trData.time = str2double(D.textdata(states==2,1));
    trData.position = str2double(D.textdata(states==2,2:4));
    trData.angularVelocity = str2double(D.textdata(states==2,17:19));
    trData.numSamps = sum(states == 2);
    rotationMatElements =str2double(D.textdata(states==2,5:13));
else
    states = D.data(:,20);
    trData.time = D.data(states==2,1);
    trData.position = D.data(states==2,2:4);
    trData.angularVelocity = D.data(states==2,17:19);
    trData.numSamps = sum(states == 2);
    rotationMatElements =D.data(states==2,5:13);
end
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
[trData100.indsAboveThreshold,trData100.numSubMovements,trData100.subSegments] = deleteShortMovements(indsAbove,ceil(167*10^-3*100));

% group number
trData100.group = GroupNum;

% aiming axis
take = [trData100.subSegments(1,1),length(trData100.quaternion)];
quat = trData100.quaternion(take(1):take(2),:);
quat = quatmultiply(repmat(quatinv(quat(1,:)),size(quat,1),1),quat);
[~,indpeak] = nanmax(trData100.angularSpeed(take(1):take(2)));
axang = quat2axang(quat);
trData100.kAdaptation = axang(indpeak,1:3);
end