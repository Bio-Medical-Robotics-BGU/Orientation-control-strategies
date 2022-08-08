function plotSphereComparison_within(q1,q2,c1,c2,pos,rot1,rot2,ax1,ax2,gr,sig)

axes('Position',pos); hold on
plotSphere;

if nargin>5
    for i=1:length(q1)
        q1(i,:) = (rot1*(q1(i,:)'))';
    end
end

if nargin>6
    for i=1:length(q2)
        q2(i,:) = (rot2*(q2(i,:)'))';
    end
end
mm = meanDirection3D([q1;q2]);
viewrot = axang2rotm([cross(mm,[1 0 0])./norm(cross(mm,[1 0 0])),acos(dot(mm,[1 0 0]))]);

for i=1:length(q1)
    q1(i,:) = (viewrot*q1(i,:)')';
    q2(i,:) = (viewrot*q2(i,:)')';
end

drawArc(q1,q2,'k')
scatter3(q1(:,1),q1(:,2),q1(:,3),12,'filled','MarkerFaceColor',c1,'MarkerEdgeColor',c1,'LineWidth',0.5);
scatter3(q2(:,1),q2(:,2),q2(:,3),12,'filled','MarkerFaceColor',c2,'MarkerEdgeColor',c2,'LineWidth',0.5);
view(90,30);

if nargin>7
    switch gr
        case 1
            desBL1 = (viewrot*[0 -1 1]'/sqrt(2))';
            desBL2 = (viewrot*[0 1 1]'/sqrt(2))';
        case 2
            desBL1 = (viewrot*[0 1 1]'/sqrt(2))';
            desBL2 = (viewrot*[0 1 1]'/sqrt(2))';
        case 3
            desBL1 = (viewrot*[0 1 1]'/sqrt(2))';
            desBL2 = (viewrot*[0 -1 1]'/sqrt(2))';
    end
    desTRN = axang2rotm([1 0 0 -pi/3])*desBL1';
    
    
    switch ax1
        case 'idealBL1'
            quiver3(0,0,0,desBL1(1),desBL1(2),desBL1(3),'Color',c1,'AutoScaleFactor',1.2,'LineWidth',2);
        case 'idealBL2'
            quiver3(0,0,0,desBL2(1),desBL2(2),desBL2(3),'Color',c1,'AutoScaleFactor',1.2,'LineWidth',2);
        case 'mean'
            m = meanDirection3D(q1);
            quiver3(0,0,0,m(1),m(2),m(3),'Color',c1,'AutoScaleFactor',1.2,'LineWidth',2);
        case 'idealBL1rot'
            desBL1rot = (rot1*(desBL1)')';
            quiver3(0,0,0,desBL1rot(1),desBL1rot(2),desBL1rot(3),'Color',c1,'AutoScaleFactor',1.2,'LineWidth',2);
    end

    switch ax2
        case 'idealBL1'
            quiver3(0,0,0,desBL1(1),desBL1(2),desBL1(3),'Color',c2,'AutoScaleFactor',1.2,'LineWidth',2);
        case 'idealBL2'
            quiver3(0,0,0,desBL2(1),desBL2(2),desBL2(3),'Color',c2,'AutoScaleFactor',1.2,'LineWidth',2);
        case 'mean'
            m = meanDirection3D(q2);
            quiver3(0,0,0,m(1),m(2),m(3),'Color',c2,'AutoScaleFactor',1.2,'LineWidth',2);
    end
end

if sig==1
    text(1,1,1.5,'*')
elseif sig==2
    text(1,1,1.5,'**')
else
end

m1 = meanDirection3D(q1);
m2 = meanDirection3D(q2);
meandiff = acosd(dot(m1,m2));
text(1,1,1,[' mean diff. = ',num2str(round(meandiff)),char(176)],'FontSize',7)

hold
end