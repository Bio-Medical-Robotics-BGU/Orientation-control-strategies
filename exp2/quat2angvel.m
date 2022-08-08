function vel = quat2angvel(q,t,coordinates)
N = size(q,1);
if strcmp(coordinates,'extrinsic')
    quat_delta = quatmultiply(q(2:N,:),quatinv(q(1:N-1,:)));
elseif strcmp(coordinates,'intrinsic')
    quat_delta = quatmultiply(quatinv(q(1:N-1,:)),q(2:N,:));
end
axang_delta = quat2axang(quat_delta);
vel = axang_delta(:,1:3).*repmat(axang_delta(:,4).*(1./diff(t)),1,3);
end