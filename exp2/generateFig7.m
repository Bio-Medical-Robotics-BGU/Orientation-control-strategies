function h = generateFig7()
%% Generate Fig7
set(0,'defaultfigureposition',get(0, 'Screensize')-[-10,-10,100,100]);
set(0,'defaultTextFontSize',15);
set(0,'defaultTextFontName','Times');
set(0,'defaultAxesFontName','Times');
set(0,'defaultAxesFontSize',15);
set(0,'defaultLineLineWidth',1);
set(0,'defaultAxesTickLabelInterpreter','tex');
set(0,'defaultLegendInterpreter','tex');
set(0,'defaultTextInterpreter','tex');

load exp2data.mat;
subData = exp2data.YB;
trials =  0:419;
trials([30,185,277,308,393]+1) = [];

%% Sphere
VF = importdata('VF.txt');
subtractTrials1 = 81:120;
subtractTrials1(VF(81:120)==0) = [];
subtractTrials2 = 141:180;
subtractTrials2(VF(141:180)==0) = [];

K = nan(420,3);
for trNum = 0:419    
    if ismember(trNum,trials)      
        K(trNum+1,:) = subData.(['trial',num2str(trNum)]).kAdaptation;
    end
end
Kfull = K;

K = K(61:420,:);
desBL1 = [0 -1 1]/sqrt(2);
desBL2 = [0 1 1]/sqrt(2);
desTRN = axang2rotm([1 0 0 -pi/3])*desBL1';

% reduce baseline
kBL1 = meanDirection3D(K(subtractTrials1-60,:))';
kBL2 = meanDirection3D(K(subtractTrials2-60,:))';
KnoBL = nan(360,3);
rotmBL1 = axang2rotm([cross(kBL1,desBL1)./norm(cross(kBL1,desBL1)),acos(dot(kBL1,desBL1))]);
rotmBL2 = axang2rotm([cross(kBL2,desBL2)./norm(cross(kBL2,desBL2)),acos(dot(kBL2,desBL2))]);
for trNum=1:360
    if ismember(trNum,[1:60,121:300])
        KnoBL(trNum,:) = (rotmBL1*K(trNum,:)')';
    else
        KnoBL(trNum,:) = (rotmBL2*K(trNum,:)')';
    end
end

% plot
dark = [0.105882352941176,0.619607843137255,0.466666666666667;0.850980392156863,0.372549019607843,0.00784313725490196;0.458823529411765,0.439215686274510,0.701960784313725;0.905882352941177,0.160784313725490,0.541176470588235];
cBL1 = dark(1,:);
cBL2 = dark(2,:);
cTRN = dark(3,:);
cTFR = dark(4,:);
h = figure('Renderer', 'Painters');
set(h,'Units','normalized')
set(h, 'Position',  [0.0005    0.0565    0.8068    0.8481])
set(h,'Color',[1 1 1]);
set(h,'windowState','normal')
axis off
hold on

axes('Position',[0.02,0.5,0.35,0.35]);
plotSphFrameSegment;
R = axang2rotm([[0 1 0] deg2rad(90)]);
for trNum=1:size(KnoBL,1)
    KnoBL(trNum,:) = (R*KnoBL(trNum,:)')';
end
desBL1 = R*desBL1';desBL2 = R*desBL2';desTRN = R*desTRN;
desEarlyTFR = axang2rotm([0 0 1 deg2rad(60)])*desBL2;
sBL1 = scatter3(KnoBL(1:60,1),KnoBL(1:60,2),KnoBL(1:60,3),12,'filled','MarkerFaceColor',cBL1,'MarkerEdgeColor',cBL1,'LineWidth',0.5);
sBL2 = scatter3(KnoBL(61:120,1),KnoBL(61:120,2),KnoBL(61:120,3),12,'filled','MarkerFaceColor',cBL2,'MarkerEdgeColor',cBL2,'LineWidth',0.5);
sTRN = scatter3(KnoBL(121:299,1),KnoBL(121:299,2),KnoBL(121:299,3),12,'filled','MarkerFaceColor',cTRN,'MarkerEdgeColor',cTRN,'LineWidth',0.5);
sTFR = scatter3(KnoBL(302:360,1),KnoBL(302:360,2),KnoBL(302:360,3),12,'filled','MarkerFaceColor',cTFR,'MarkerEdgeColor',cTFR,'LineWidth',0.5);
qBL1 = quiver3(0,0,0,desBL1(1),desBL1(2),desBL1(3),'Color',cBL1,'AutoScaleFactor',1.1,'LineWidth',2);
qTRN = quiver3(0,0,0,desTRN(1),desTRN(2),desTRN(3),'Color',cTRN,'AutoScaleFactor',1.1,'LineWidth',2);
qBL2 = quiver3(0,0,0,desBL2(1),desBL2(2),desBL2(3),'Color',cBL2,'AutoScaleFactor',1.1,'LineWidth',2);
qEarlyTFR = quiver3(0,0,0,desEarlyTFR(1),desEarlyTFR(2),desEarlyTFR(3),'Color',cTFR,'AutoScaleFactor',1.1,'LineWidth',2);

scatter3(1.025*KnoBL(300,1),1.025*KnoBL(300,2),1.025*KnoBL(300,3),50,'filled','s','MarkerFaceColor','k','MarkerEdgeColor','k','LineWidth',0.5);
scatter3(1.01*KnoBL(301,1),1.01*KnoBL(301,2),1.01*KnoBL(301,3),50,'filled','<','MarkerFaceColor','k','MarkerEdgeColor','k','LineWidth',0.5);

sBL1.MarkerFaceAlpha = 0.5;sBL1.MarkerEdgeAlpha = 0.5;
sBL2.MarkerFaceAlpha = 0.5;sBL2.MarkerEdgeAlpha = 0.5;
sTRN.MarkerFaceAlpha = 0.5;sTRN.MarkerEdgeAlpha = 0.5;
sTFR.MarkerFaceAlpha = 0.5;sTFR.MarkerEdgeAlpha = 0.5;
hold

xlim([-1 1]);
ylim([-1 1]);
zlim([-0.3 0.3]);
axis equal
axis off

%% Curve
ax = axes('Position',[0.1,0.1,0.35,0.3]);
for trNum = 0:419    
    desBL1 = [0 -1 1]/sqrt(2);
    desBL2 = [0 1 1]/sqrt(2);
    desTRN = desBL1';
    % get axis
    if ismember(trNum,trials)
        if trNum<=29 || (trNum>=60 && trNum<=119)
            desiredAxis = desBL1;
        elseif trNum>=180 && trNum<=359
            desiredAxis = desTRN;
        else
            desiredAxis = desBL2;
        end
    end
    
    ax = dot(Kfull(trNum+1,:),[1 0 0]);
    ay = dot(Kfull(trNum+1,:),desiredAxis);
    az = dot(Kfull(trNum+1,:),cross([1 0 0],desiredAxis));
    elevation = atan2d(az,sqrt(ax.^2 + ay.^2));
    err(trNum+1) = elevation;
end
BL1 = nanmean(err(subtractTrials1));
BL2 = nanmean(err(subtractTrials2));
err([1:30,61:120,181:360]) = err([1:30,61:120,181:360]) - BL1;
err([31:60,121:180,361:420]) = err([31:60,121:180,361:420])- BL2;
err = -err(61:420);

dark = [0.105882352941176,0.619607843137255,0.466666666666667;0.850980392156863,0.372549019607843,0.00784313725490196;0.458823529411765,0.439215686274510,0.701960784313725;0.905882352941177,0.160784313725490,0.541176470588235];
colors(1:60,:) = repmat(dark(1,:),60,1);
colors(61:120,:) = repmat(dark(2,:),60,1);
colors(121:300,:) = repmat(dark(3,:),180,1);
colors(301:360,:) = repmat(dark(4,:),60,1);
hold on
yline(0,'-','LineWidth',1);
xline(60,'--','LineWidth',1);xline(120,'--','LineWidth',1);xline(180,'--','LineWidth',1);xline(240,'--','LineWidth',1);xline(300,'--','LineWidth',1);
xlim([1 360])
ylim([-30 90])
xlabel('Trial Number','FontSize',15)
ylabel('Aiming Angle [deg]','FontSize',15)
set(0,'defaultAxesFontSize',15);
text(20,100,'BL1','FontSize',15);text(80,100,'BL2','FontSize',15);text(200,100,'TRN','FontSize',15);text(320,100,'TFR','FontSize',15);

xticks([1 60 120 180 240 300 360])
yticks([-90 -60 -30 0 30 60 90])

p = scatter(1:60,err(1:60),12,'filled');
p.MarkerEdgeColor = colors(1,:);
p.MarkerFaceColor = colors(1,:);
p = scatter(61:120,err(61:120),12,'filled');
p.MarkerEdgeColor = colors(61,:);
p.MarkerFaceColor = colors(61,:);
p = scatter(121:299,err(121:299),12,'filled');
p.MarkerEdgeColor = colors(121,:);
p.MarkerFaceColor = colors(121,:);
p = scatter(302:360,err(302:360),12,'filled');
p.MarkerEdgeColor = colors(301,:);
p.MarkerFaceColor = colors(301,:);

p = scatter(300,err(300),50,'filled','s');
p.MarkerEdgeColor = 'k';
p.MarkerFaceColor = 'k';
p = scatter(301,err(301),50,'filled','<');
p.MarkerEdgeColor = 'k';
p.MarkerFaceColor = 'k';


p = line([1,120],[0,0],'Color','k','LineWidth',1);
p = line([120,301],[60,60],'Color','k','LineWidth',1);
p = line([301,361],[0,0],'Color','k','LineWidth',1);
p = line([1,120],[160,160],'Color','k','LineWidth',1);
p = line([120,301],[220,220],'Color','k','LineWidth',1);
p = line([301,361],[160,160],'Color','k','LineWidth',1);
p = line([1,120],[320,320],'Color','k','LineWidth',1);
p = line([120,301],[380,380],'Color','k','LineWidth',1);
p = line([301,361],[320,320],'Color','k','LineWidth',1);

hold

%% Late TRN and Early TFR spheres
innerPos(1,:) = [0.45,0.5,0.55,0.35];
innerPos(2,:) = [0.45,0.05,0.55,0.35];
c = [cTRN;cTFR];
desTRN = R*axang2rotm([1 0 0 -pi/3])*desBL1';
desBL1 = R*desBL1';
desBL2 = R*desBL2';  
for trNum=[359 360]
    trData = subData.(['trial',num2str(trNum)]);
    firstSub = [trData.subSegments(1,1),length(trData.quaternion)];
    quat = trData.quaternion(firstSub(1):firstSub(2),:);
    quat = quatmultiply(repmat(quatinv(quat(1,:)),size(quat,1),1),quat);
    axang = quat2axang(quat);
    K = axang(:,1:3);
    
    speed = trData.angularSpeed(firstSub(1):firstSub(2));
    S = rescale(speed,2,50);
    
    R = axang2rotm([[0 1 0] deg2rad(90)]);
    for i=1:length(K)
        if  trNum==359
            K(i,:) = (R*rotmBL1*K(i,:)')';                
            kAdaptation = R*rotmBL1*trData.kAdaptation';
        else
            K(i,:) = (R*rotmBL2*K(i,:)')';
            kAdaptation = R*rotmBL2*trData.kAdaptation';
        end
    end
    
    axes('Position',innerPos(trNum-358,:));
    hold on
    plotSphFrameSegment;
    s = scatter3(K(:,1),K(:,2),K(:,3),S,'filled','MarkerFaceColor',c(trNum-358,:),'MarkerEdgeColor',c(trNum-358,:));

    s.MarkerFaceAlpha = 0.5;
    s.MarkerEdgeAlpha = 0.5;
    if trNum==359
        scatter3(1.01*kAdaptation(1),1.01*kAdaptation(2),1.01*kAdaptation(3),50,'filled','s','MarkerFaceColor','k','MarkerEdgeColor','k','LineWidth',0.5);
    else
        scatter3(1.045*kAdaptation(1),1.045*kAdaptation(2),1.045*kAdaptation(3),50,'filled','<','MarkerFaceColor','k','MarkerEdgeColor','k','LineWidth',0.5);
    end
    
    desEarlyTRN = axang2rotm([0 0 1 deg2rad(10)])*desBL1;
    desEarlyTFR = axang2rotm([0 0 1 deg2rad(60)])*desBL2;
    desLateTFR = axang2rotm([0 0 1 deg2rad(5)])*desBL2;

    qBL1 = quiver3(0,0,0,desBL1(1),desBL1(2),desBL1(3),'Color',cBL1,'AutoScaleFactor',1.1,'LineWidth',2);
    qTRN = quiver3(0,0,0,desTRN(1),desTRN(2),desTRN(3),'Color',cTRN,'AutoScaleFactor',1.1,'LineWidth',2);
    qBL2 = quiver3(0,0,0,desBL2(1),desBL2(2),desBL2(3),'Color',cBL2,'AutoScaleFactor',1.1,'LineWidth',2);
    qEarlyTRN = quiver3(0,0,0,desEarlyTRN(1),desEarlyTRN(2),desEarlyTRN(3),'Color',cTRN,'AutoScaleFactor',1.1,'LineWidth',2);
    qEarlyTFR = quiver3(0,0,0,desEarlyTFR(1),desEarlyTFR(2),desEarlyTFR(3),'Color',cTFR,'AutoScaleFactor',1.1,'LineWidth',2);
    qLateTFR = quiver3(0,0,0,desLateTFR(1),desLateTFR(2),desLateTFR(3),'Color',cTFR,'AutoScaleFactor',1.1,'LineWidth',2);
    
    if trNum==359
        p1 = [0,desBL1'];
    else
        p1 = [0,desBL2'];
    end
    p2 = [0,kAdaptation'];
    
    arc = quatinterp(repmat(p1,5,1),repmat(p2,5,1),linspace(0,1,5),'slerp');
    arc = arc(:,2:4);    
    plot3(arc(:,1),arc(:,2),arc(:,3),'k--','LineWidth',2);
    xlim([-1 1]);
    ylim([-1 1]);
    zlim([-0.3 0.3]);
    axis equal
    axis off
    hold
    
    if trNum == 360
        text(1,-1.2,-0,'ideal BL1','Color',cBL1,'Rotation',0)
        text(1,-0.9,-0.1,'first TRN','Color',cTRN,'Rotation',0)
        text(1,-0.1,-0.15,'last TRN','Color',cTRN,'Rotation',0)
        text(1,0.5,-0.1,'ideal BL2','Color',cBL2,'Rotation',0)
        text(1,1.1,-0.0,'last TFR','Color',cTFR,'Rotation',0)
        text(1,1.65,0.25,'first TFR','Color',cTFR,'Rotation',0)
    elseif trNum == 359
        text(0.8,-1.2,-0.0,'ideal BL1','Color',cBL1,'Rotation',0)
        text(1,-0.9,-0.1,'first TRN','Color',cTRN,'Rotation',0)
        text(1,-0.1,-0.25,'last TRN','Color',cTRN,'Rotation',0)
        text(1,0.5,-0.1,'ideal BL2','Color',cBL2,'Rotation',0)
        text(1,1.1,-0.0,'last TFR','Color',cTFR,'Rotation',0)
        text(1,1.65,0.25,'first TFR','Color',cTFR,'Rotation',0)
    end

end

ax = axes('Position',[0.05,0.85,0.02,0.03]);
text(0,0,'(A)','FontName','Times','FontSize',15);
ax.YAxis.Visible = 'off';
ax.XAxis.Visible = 'off'; 
ax = axes('Position',[0.05,0.48,0.02,0.03]);
text(0,0,'(B)','FontName','Times','FontSize',15);
ax.YAxis.Visible = 'off';
ax.XAxis.Visible = 'off'; 
ax = axes('Position',[0.48,0.85,0.02,0.03]);
text(0,0,'(C)','FontName','Times','FontSize',15);
ax.YAxis.Visible = 'off';
ax.XAxis.Visible = 'off'; 
ax = axes('Position',[0.48,0.48,0.02,0.03]);
text(0,0,'(D)','FontName','Times','FontSize',15);
ax.YAxis.Visible = 'off';
ax.XAxis.Visible = 'off'; 

ax = axes('Position',[0.15,0.8,0.02,0.03]);
text(0.5,0.5,'Aiming Axes','interpreter','latex','FontName','Times','FontSize',15)
ax.YAxis.Visible = 'off';
ax.XAxis.Visible = 'off';

ax = axes('Position',[0.69,0.8,0.02,0.03]);
text(0.5,0.5,'Last TRN','FontName','Times','FontSize',15)
ax.YAxis.Visible = 'off';
ax.XAxis.Visible = 'off';

ax = axes('Position',[0.69,0.37,0.02,0.03]);
text(0.5,0.5,'First TFR','FontName','Times','FontSize',15)
ax.YAxis.Visible = 'off';
ax.XAxis.Visible = 'off';

ax = axes('Position',[0.41,0.7,0.07,0.17]);
hold on
s1 = scatter(nan,nan,'filled','MarkerFaceColor',cBL1,'MarkerEdgeColor',cBL1);
s2 = scatter(nan,nan,'filled','MarkerFaceColor',cBL2,'MarkerEdgeColor',cBL2);
s3 = scatter(nan,nan,'filled','MarkerFaceColor',cTRN,'MarkerEdgeColor',cTRN);
s4 = scatter(nan,nan,'filled','MarkerFaceColor',cTFR,'MarkerEdgeColor',cTFR);
s5 = scatter(nan,nan,'filled','s','MarkerFaceColor','k','MarkerEdgeColor','k');
s6 = scatter(nan,nan,'filled','<','MarkerFaceColor','k','MarkerEdgeColor','k');

legend('BL1','BL2','TRN','TFR','trial 300','trial 301','FontName','Times','FontSize',15,'position',[0 0 1 1],'box','off')
ax.YAxis.Visible = 'off';
ax.XAxis.Visible = 'off';
hold
end