function newData = interpAndDownsample(data)
%% interpolate trial data to 1000 [Hz] and downsample to 100 [Hz] 

t = data.time-data.time(1);
Fs = 1000;
tDes = 0:(1/Fs):t(end);
ind(:,1) = [1;2];
for i=2:length(tDes)
    difi=tDes(i)-t;
    diff_before=100000*ones(length(tDes),1);
    diff_before(difi>0)=difi(difi>0);
    diff_after=100000*ones(length(tDes),1);
    diff_after(difi<0)=abs(difi(difi<0));
    [~,ind(1,i)]=min(diff_before);
    [~,ind(2,i)]=min(diff_after);
end

mat = t(ind); 

S = (tDes-mat(1,:))./(mat(2,:)-mat(1,:)); 


quatInterp = zeros(length(tDes),4);
quatInterp(1,:) = data.quaternion(1,:);
for i=2:length(tDes)
    ind_before = ind(1,i);
    ind_after = ind(2,i);
    if S(i)>1
        S(i) = 1;
    elseif S(i)<0
        S(i) = 0;
    end
    quatInterp(i,:) = quatnormalize(quatinterp(data.quaternion(ind_before,:),data.quaternion(ind_after,:),S(i),'slerp'));
end

position(:,1) = interp1(t,data.position(:,1),tDes,'pchip');
position(:,2) = interp1(t,data.position(:,2),tDes,'pchip');
position(:,3) = interp1(t,data.position(:,3),tDes,'pchip');
angularVelocity(:,1) = interp1(t,data.angularVelocity(:,1),tDes,'pchip');
angularVelocity(:,2) = interp1(t,data.angularVelocity(:,2),tDes,'pchip');
angularVelocity(:,3) = interp1(t,data.angularVelocity(:,3),tDes,'pchip');

Dfactor = Fs/100;
newData.time = downsample(tDes,Dfactor)';
newData.position = downsample(position,Dfactor);
newData.angularVelocity = downsample(angularVelocity,Dfactor);
newData.quaternion = downsample(quatInterp,Dfactor);
newData.numSamps = length(newData.time);
end