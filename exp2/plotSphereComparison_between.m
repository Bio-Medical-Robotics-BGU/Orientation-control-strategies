function plotSphereComparison_between(q1,q2,q3,c1,c2,c3,pos,rot1,rot2,rot3,sig12,sig13,sig23)

axes('Position',pos); hold on
plotSphere;

for i=1:length(q1)
    q1(i,:) = (rot1*(q1(i,:)'))';
    q2(i,:) = (rot2*(q2(i,:)'))';
    q3(i,:) = (rot3*(q3(i,:)'))';
end

mm = meanDirection3D([q1;q2;q3]);
viewrot = axang2rotm([cross(mm,[1 0 0])./norm(cross(mm,[1 0 0])),acos(dot(mm,[1 0 0]))]);

for i=1:length(q1)
    q1(i,:) = (viewrot*q1(i,:)')';
    q2(i,:) = (viewrot*q2(i,:)')';
    q3(i,:) = (viewrot*q3(i,:)')';
end

scatter3(q1(:,1),q1(:,2),q1(:,3),12,'filled','MarkerFaceColor',c1,'MarkerEdgeColor',c1,'LineWidth',0.5);
scatter3(q2(:,1),q2(:,2),q2(:,3),12,'filled','MarkerFaceColor',c2,'MarkerEdgeColor',c2,'LineWidth',0.5);
scatter3(q3(:,1),q3(:,2),q3(:,3),12,'filled','MarkerFaceColor',c3,'MarkerEdgeColor',c3,'LineWidth',0.5);

m = meanDirection3D(q1); quiver3(0,0,0,m(1),m(2),m(3),'Color',c1,'AutoScaleFactor',1.2,'LineWidth',2);
m = meanDirection3D(q2); quiver3(0,0,0,m(1),m(2),m(3),'Color',c2,'AutoScaleFactor',1.2,'LineWidth',2);
m = meanDirection3D(q3); quiver3(0,0,0,m(1),m(2),m(3),'Color',c3,'AutoScaleFactor',1.2,'LineWidth',2);

view(90,30);  
meandiff12 = acosd(dot(meanDirection3D(q1),meanDirection3D(q2)));
meandiff13 = acosd(dot(meanDirection3D(q1),meanDirection3D(q3)));
meandiff23 = acosd(dot(meanDirection3D(q2),meanDirection3D(q3)));
switch sig12
    case 1
         text(1,1,1.5,['\color[rgb]{',num2str(c1),'}\bullet','\color[rgb]{',num2str(c2),'}\bullet','\color{black}*','\color{black} mean diff. = ',num2str(round(meandiff12)),char(176)],'FontSize',7)
    case 2
         text(1,1,1.5,['\color[rgb]{',num2str(c1),'}\bullet','\color[rgb]{',num2str(c2),'}\bullet','\color{black}**','\color{black} mean diff. = ',num2str(round(meandiff12)),char(176)],'FontSize',7)
    otherwise
         text(1,1,1.5,['\color[rgb]{',num2str(c1),'}\bullet','\color[rgb]{',num2str(c2),'}\bullet',' \color{black} mean diff. = ',num2str(round(meandiff12)),char(176)],'FontSize',7)            
end

switch sig13
    case 1
        text(1,1,1.2,['\color[rgb]{',num2str(c1),'}\bullet','\color[rgb]{',num2str(c3),'}\bullet','\color{black}*',' mean diff. = ',num2str(round(meandiff13)),char(176)],'FontSize',7)
    case 2
         text(1,1,1.2,['\color[rgb]{',num2str(c1),'}\bullet','\color[rgb]{',num2str(c3),'}\bullet','\color{black}**',' mean diff. = ',num2str(round(meandiff13)),char(176)],'FontSize',7)
    otherwise
         text(1,1,1.2,['\color[rgb]{',num2str(c1),'}\bullet','\color[rgb]{',num2str(c3),'}\bullet',' \color{black} mean diff. = ',num2str(round(meandiff13)),char(176)],'FontSize',7)
end

switch sig23
    case 1
         text(1,1,0.9,['\color[rgb]{',num2str(c2),'}\bullet','\color[rgb]{',num2str(c3),'}\bullet','\color{black}*',' mean diff. = ',num2str(round(meandiff23)),char(176)],'FontSize',7)
    case 2
         text(1,1,0.9,['\color[rgb]{',num2str(c2),'}\bullet','\color[rgb]{',num2str(c3),'}\bullet','\color{black}**',' mean diff. = ',num2str(round(meandiff23)),char(176)],'FontSize',7)
    otherwise
        text(1,1,0.9,['\color[rgb]{',num2str(c2),'}\bullet','\color[rgb]{',num2str(c3),'}\bullet','\color{black} mean diff. = ',num2str(round(meandiff23)),char(176)],'FontSize',7)
end   

hold
end