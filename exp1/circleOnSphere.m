function circleOnSphere(c,n,r,color)

t=linspace(0,2*pi,500);
b = null(n);
circle = repmat(c',1,size(t,2))+r*(b(:,1)*cos(t)+b(:,2)*sin(t));
circle = circle./repmat(vecnorm(circle),3,1);
plot3(circle(1,:),circle(2,:),circle(3,:),'Color',color);

end