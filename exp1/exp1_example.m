function exp1_example()

set(0,'defaultAxesFontSize',17);
set(0,'defaultTextFontSize',17);
set(0,'defaultTextFontName','Times');
set(0,'defaultAxesFontName','Times');
set(0,'defaultLineLineWidth',1);
set(0, 'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex');
set(0, 'defaultTextInterpreter','latex');

subStrs = {'NC_2021_02_25','RS_2021_02_24','MG_2021_02_25','IN_2021_02_25','MG_2021_02_22','EY_2021_02_22','BO_2021_02_22',...
    'OG_2021_02_18','MK_2021_02_18','MN_2021_02_18','RG_2021_02_15','GO_2021_02_15','OT_2021_02_15','YB_2021_02_28'};
groups = [2,2,2,2,2,2,2,1,1,1,1,1,1,1];
inits = {'NC','RS','MGA','IN','MG','EY','BO','OG','MK','MN','RG','GO','OT','YB'};

subjects = [11 9];
trNums = 257+23;
K = [1,-1,0]./sqrt(2);

for subNum = subjects
    initials = inits{subNum};
    subStr = subStrs{subNum}; 
    GroupNum = groups(subNum);
    trNum = trNums;
    trData =  trFunction_exp1(subStr,trNum,GroupNum);
    angularSpeed = trData.angularSpeed;
    [ind15,~] = lessthan(trData,0,15,40);
    ind = ind15;
    if isnan(ind)
        ind = length(angularSpeed);
    end
    take = trData.subSegments(1,1):ind;
    quat{subNum} = trData.quaternion(take,:);
    QGS(subNum) = real(geodicityFactor(quat{subNum}));
    MDG(subNum) = meanDeviation(quat{subNum});
    quat_take{subNum} = trData.quaternion([max(take(1)-10,1):min(length(angularSpeed),take(end)+40)],:);
    time{subNum} = trData.time([max(take(1)-10,1):min(length(angularSpeed),take(end)+40)],:);
    time{subNum} = time{subNum}-min(time{subNum});
    angularVel{subNum} = trData.angularVelocity([max(take(1)-10,1):min(length(angularSpeed),take(end)+40)],:);
    angularVel_take{subNum} = trData.angularVelocity(take,:);
    dk{subNum} = angularVel_take{subNum}./repmat(vecnorm(angularVel_take{subNum}')',1,3);
    S{subNum} = rescale(angularSpeed(take,:),1,50)';  
    R{subNum} = quat2rotm(quat{subNum});
end
qinit = trData.trialConditions.quatInit;
qfinal = trData.trialConditions.quatFinal;
Rinit = quat2rotm(qinit);
Rfinal = quat2rotm(qfinal);

% plots

h = figure('Renderer', 'Painters');
set(h,'Units','normalized')
set(h, 'Position',  [0    0    1    1])
set(h,'WindowState','maximized');
set(h,'Color',[1 1 1]);

ax = subplot(2,3,1);
ax.InnerPosition = [0.05,0.45,0.35,0.6];

plotSphere;
view(85,65)
xlim([-1 1.5])
ylim([-1 1.5])
zlim([-1 1.5])
hold on
circleOnSphere(Rfinal(:,1)',Rfinal(:,1)',sind(15),'r')
circleOnSphere(Rfinal(:,2)',Rfinal(:,2)',sind(15),'g')
circleOnSphere(Rfinal(:,3)',Rfinal(:,3)',sind(15),'b')
circleOnSphere(Rinit(:,1)',Rinit(:,1)',sind(5),'r')
circleOnSphere(Rinit(:,2)',Rinit(:,2)',sind(5),'g')
circleOnSphere(Rinit(:,3)',Rinit(:,3)',sind(5),'b')
x = squeeze(R{subjects(1)}(:,1,:));
y = squeeze(R{subjects(1)}(:,2,:));
z = squeeze(R{subjects(1)}(:,3,:));
scatter3(x(1,:),x(2,:),x(3,:),10,'r','filled')
scatter3(y(1,:),y(2,:),y(3,:),10,'g','filled')
scatter3(z(1,:),z(2,:),z(3,:),10,'b','filled')

text(Rinit(1,1)+0.2,Rinit(2,1),Rinit(3,1),'$\mathrm{\hat{x}}$','Color','r')
text(Rinit(1,2),Rinit(2,2)+0.2,Rinit(3,2),'$\mathrm{\hat{y}}$','Color','g')
text(Rinit(1,3),Rinit(2,3)-0.55,Rinit(3,3),'$\mathrm{\hat{z}}$','Color','b')

qslerp = quatinterp(repmat(qinit,100,1),repmat(qfinal,100,1),linspace(0,1,100),'slerp');
Rslerp = quat2rotm(qslerp);
xslerp = squeeze(Rslerp(:,1,:));
yslerp = squeeze(Rslerp(:,2,:));
zslerp = squeeze(Rslerp(:,3,:));
scatter3(xslerp(1,:),xslerp(2,:),xslerp(3,:),10,'k','filled')
scatter3(yslerp(1,:),yslerp(2,:),yslerp(3,:),10,'k','filled')
scatter3(zslerp(1,:),zslerp(2,:),zslerp(3,:),10,'k','filled')

axes('Position',[0.14 0.98 0.2 0.2]);
text(0,0,'Intrinsic Frame Path')
axis off
axes('Position',[0.75 0.98 0.2 0.2]);
text(0,0,'Instantaneous Rotation Axis')
axis off

ax = subplot(2,3,2); hold on
ax.InnerPosition = [0.4,0.6,0.25,0.35];
plot(time{subjects(1)},angularVel{subjects(1)},'LineWidth',2);
plot(time{subjects(1)},vecnorm(angularVel{subjects(1)}'),'LineWidth',2,'Color','k');

xlim([0 time{subjects(1)}(end)]);
xlabel('Time [s]')
ylabel('Angular Velocity [rad/s]')
MI = min([angularVel{subjects(1)}(:);angularVel{subjects(2)}(:)])-0.1;
MA = max([angularVel{subjects(1)}(:);angularVel{subjects(2)}(:)])+0.1;
ylim([-2.2 3.7])
text(time{subjects(1)}(45),angularVel{subjects(1)}(45,1)+0.3,'$\mathrm{\omega_x}$','interpreter','Latex','Color','#0072BD');
text(time{subjects(1)}(45),angularVel{subjects(1)}(45,2)+0.55,'$\mathrm{\omega_y}$','interpreter','Latex','Color','#D95319');
text(time{subjects(1)}(45),angularVel{subjects(1)}(45,3)+0.5,'$\mathrm{\omega_z}$','interpreter','Latex','Color','#EDB120');
text(time{subjects(1)}(45)-0.025,2.95,'$\mathrm{||\mathbf{\omega}||}$','interpreter','Latex','Color','k');

xticks([0 time{subjects(1)}(end)]);
yticks([round(MI),0,round(MA)])
box on

ax = subplot(2,3,3);
ax.InnerPosition = [0.7,0.5,0.35,0.6];
plotSphere;
scatter3(dk{subjects(1)}(:,1),dk{subjects(1)}(:,2),dk{subjects(1)}(:,3),S{subjects(1)},'k','filled')
quiver3(0,0,0,K(1),K(2),K(3),'MaxHeadSize',0.8,'AutoScaleFactor',1.5,'color','r','LineWidth',3)
view(23,14)
xlim([-1 1.5])
ylim([-1 1.5])
zlim([-1 1.5])
text(1.75*K(1),1.75*K(2),1.75*K(3),'$\hat{\mathbf{n}}$','interpreter','latex','color','r')
text(-0.7,0,-1.3,'$\hat{\mathbf{n}} = \hat{\mathbf{i}}/\sqrt{2}-\hat{\mathbf{j}}/\sqrt{2}$','interpreter','latex','color','r')
%

ax = axes('Position',[0.05,0.00,0.35,0.6]);
plotSphere;
view(85,65)
xlim([-1 1.5])
ylim([-1 1.5])
zlim([-1 1.5])
hold on
circleOnSphere(Rfinal(:,1)',Rfinal(:,1)',sind(15),'r')
circleOnSphere(Rfinal(:,2)',Rfinal(:,2)',sind(15),'g')
circleOnSphere(Rfinal(:,3)',Rfinal(:,3)',sind(15),'b')
circleOnSphere(Rinit(:,1)',Rinit(:,1)',sind(5),'r')
circleOnSphere(Rinit(:,2)',Rinit(:,2)',sind(5),'g')
circleOnSphere(Rinit(:,3)',Rinit(:,3)',sind(5),'b')
x = squeeze(R{subjects(2)}(:,1,:));
y = squeeze(R{subjects(2)}(:,2,:));
z = squeeze(R{subjects(2)}(:,3,:));
scatter3(x(1,:),x(2,:),x(3,:),10,'r','filled')
scatter3(y(1,:),y(2,:),y(3,:),10,'g','filled')
scatter3(z(1,:),z(2,:),z(3,:),10,'b','filled')

qslerp = quatinterp(repmat(qinit,100,1),repmat(qfinal,100,1),linspace(0,1,100),'slerp');
Rslerp = quat2rotm(qslerp);
xslerp = squeeze(Rslerp(:,1,:));
yslerp = squeeze(Rslerp(:,2,:));
zslerp = squeeze(Rslerp(:,3,:));
scatter3(xslerp(1,:),xslerp(2,:),xslerp(3,:),10,'k','filled')
scatter3(yslerp(1,:),yslerp(2,:),yslerp(3,:),10,'k','filled')
scatter3(zslerp(1,:),zslerp(2,:),zslerp(3,:),10,'k','filled')

ax = axes('Position',[0.4,0.15,0.25,0.35]); hold on
plot(time{subjects(2)},angularVel{subjects(2)},'LineWidth',2);
plot(time{subjects(2)},vecnorm(angularVel{subjects(2)}'),'LineWidth',2,'Color','k');
xlim([0 time{subjects(2)}(end)]);
ylim([-2.2 3.7])
xlabel('Time [s]')
ylabel('Angular Velocity [rad/s]')
xticks([0 time{subjects(2)}(end)]);
yticks([round(MI),0,round(MA)])
box on

ax = axes('Position',[0.7,0.05,0.35,0.6]);
plotSphere;
scatter3(dk{subjects(2)}(:,1),dk{subjects(2)}(:,2),dk{subjects(2)}(:,3),S{subjects(2)},'k','filled')
quiver3(0,0,0,K(1),K(2),K(3),'MaxHeadSize',0.8,'AutoScaleFactor',1.5,'color','r','LineWidth',3)
view(23,14)
xlim([-1 1.5])
ylim([-1 1.5])
zlim([-1 1.5])
text(1.75*K(1),1.75*K(2),1.75*K(3),'$\mathbf{\hat{n}}$','interpreter','latex','color','r')

a = axes('Position',[0.05, 0.8, 0.03, 0.1]);
a.YAxis.Visible = 'off';
a.XAxis.Visible = 'off'; 
text(-1,0.85,{'(a)','',['QGS = ',num2str(round(QGS(subjects(1)),2))]})

a = axes('Position',[0.05, 0.35, 0.03, 0.1]);
a.YAxis.Visible = 'off';
a.XAxis.Visible = 'off'; 
text(-1,0.85,{'(b)','',['QGS = ',num2str(round(QGS(subjects(2)),2))]})

% exportgraphics(gcf,'exp1_example.pdf','Resolution',300,'ContentType','vector','BackgroundColor','none')
end