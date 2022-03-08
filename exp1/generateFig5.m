function h = generateFig5()
%% Generate Fig5
set(0,'defaultAxesFontSize',15);
set(0,'defaultTextFontSize',15);
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
    quat_take{subNum} = trData.quaternion([max(take(1)-10,1):min(length(angularSpeed),take(end)+40)],:);
    time{subNum} = trData.time([max(take(1)-10,1):min(length(angularSpeed),take(end)+40)],:);
    time{subNum} = time{subNum}-min(time{subNum});
    angularVel{subNum} = trData.angularVelocity([max(take(1)-10,1):min(length(angularSpeed),take(end)+40)],:);
    angularVel_take{subNum} = trData.angularVelocity(take,:);
    dk{subNum} = angularVel_take{subNum}./repmat(vecnorm(angularVel_take{subNum}')',1,3);
    S{subNum} = rescale(angularSpeed(take,:),1,50)'; 
end

% plots
h = figure('Renderer', 'Painters');
set(h,'Units','normalized')
set(h, 'Position',  [0    0    1    1])
set(h,'WindowState','maximized');
set(h,'Color',[1 1 1]);

ax = subplot(2,2,1);
ax.InnerPosition = [0.2,0.6,0.3,0.35];
plot(time{subjects(1)},angularVel{subjects(1)},'LineWidth',2);

xlim([0 time{subjects(1)}(end)]);
xlabel('Time [s]')
ylabel('Angular Velocity [rad/s]')
MI = min([angularVel{subjects(1)}(:);angularVel{subjects(2)}(:)])-0.1;
MA = max([angularVel{subjects(1)}(:);angularVel{subjects(2)}(:)])+0.1;
ylim([MI MA])
text(time{subjects(1)}(45),angularVel{subjects(1)}(45,1)+0.3,'$\mathrm{\omega_x}$','interpreter','Latex','Color','#0072BD','FontSize',15);
text(time{subjects(1)}(45),angularVel{subjects(1)}(45,2)+0.5,'$\mathrm{\omega_y}$','interpreter','Latex','Color','#D95319','FontSize',15);
text(time{subjects(1)}(45),angularVel{subjects(1)}(45,3)+0.5,'$\mathrm{\omega_z}$','interpreter','Latex','Color','#EDB120','FontSize',15);
xticks([0 time{subjects(1)}(end)]);
yticks([round(MI),0,round(MA)])

ax = subplot(2,2,2);
ax.InnerPosition = [0.35,0.5,0.6,0.6];
plotSphere;
scatter3(dk{subjects(1)}(:,1),dk{subjects(1)}(:,2),dk{subjects(1)}(:,3),S{subjects(1)},'k','filled')
quiver3(0,0,0,K(1),K(2),K(3),'MaxHeadSize',0.8,'AutoScaleFactor',1.5,'color','r','LineWidth',3)
view(23,14)
xlim([-1 1.5])
ylim([-1 1.5])
zlim([-1 1.5])
text(-1,0,1.2,'Instantaneous Rotation Axis','FontSize',15)
text(1.75*K(1),1.75*K(2),1.75*K(3),'$\hat{\mathbf{n}}$','interpreter','latex','color','r','FontSize',15)
text(-0.7,0,-1.3,'$\hat{\mathbf{n}} = \hat{\mathbf{i}}/\sqrt{2}-\hat{\mathbf{j}}/\sqrt{2}$','interpreter','latex','color','r','FontSize',15)

ax = subplot(2,2,3);
ax.InnerPosition = [0.2,0.15,0.3,0.35];
plot(time{subjects(2)},angularVel{subjects(2)},'LineWidth',2);
xlim([0 time{subjects(2)}(end)]);
ylim([MI MA])
xlabel('Time [s]')
ylabel('Angular Velocity [rad/s]')
xticks([0 time{subjects(2)}(end)]);
yticks([round(MI),0,round(MA)])
ax = subplot(2,2,4);
ax.InnerPosition = [0.35,0.05,0.6,0.6];
plotSphere;
scatter3(dk{subjects(2)}(:,1),dk{subjects(2)}(:,2),dk{subjects(2)}(:,3),S{subjects(2)},'k','filled')
quiver3(0,0,0,K(1),K(2),K(3),'MaxHeadSize',0.8,'AutoScaleFactor',1.5,'color','r','LineWidth',3)
view(23,14)
xlim([-1 1.5])
ylim([-1 1.5])
zlim([-1 1.5])
text(1.75*K(1),1.75*K(2),1.75*K(3),'$\mathbf{\hat{n}}$','interpreter','latex','color','r','FontSize',15)

a = axes('Position',[0.1, 0.6, 0.05, 0.35]);
a.YAxis.Visible = 'off';
a.XAxis.Visible = 'off'; 
text(-1,0.85,{'(A)','',['QGS = ',num2str(round(QGS(subjects(1)),2))]},'FontSize',15)
a = axes('Position',[0.1, 0.15, 0.05, 0.35]);
a.YAxis.Visible = 'off';
a.XAxis.Visible = 'off'; 
text(-1,0.85,{'(B)','',['QGS = ',num2str(round(QGS(subjects(2)),2))]},'FontSize',15)
end