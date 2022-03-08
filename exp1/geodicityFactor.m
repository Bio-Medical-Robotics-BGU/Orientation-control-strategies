function geodicityF = geodicityFactor(axis)
%% Compute geodicity factor on the sphere
% INPUT: vector - rotation axis array of size Nx(3 or 4)
% OUTPUT: geodicityF - geodicity factor on the sphere
N = size(axis,1);
axis = quatnormalize(axis);
geoSphericDist = real(acos(dot(axis(1,:),axis(N,:))));
if size(axis,2) == 3 % for axis
    dk = real(atan2(vecnorm(cross(axis(1:(N-1),:),axis(2:N,:))')',dot(axis(1:(N-1),:),axis(2:N,:),2)));
else
    if size(axis,2) == 4 % for quaternion
        dk = real(acos(dot(axis(1:(N-1),:),axis(2:N,:),2)));
    end
end
sphericDist = nansum(dk);
geodicityF = sphericDist/geoSphericDist;
end