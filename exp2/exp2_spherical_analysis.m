function exp2_spherical_analysis()

set(0,'defaultfigureposition',get(0, 'Screensize')-[-10,-10,100,100]);
set(0,'defaultTextFontSize',10);
set(0,'defaultTextFontName','Times');
set(0,'defaultAxesFontName','Times');
set(0,'defaultAxesFontSize',10);
set(0,'defaultLineLineWidth',1);
set(0,'defaultAxesTickLabelInterpreter','tex');
set(0,'defaultLegendInterpreter','tex');
set(0,'defaultTextInterpreter','tex');


load('exp2plotdata.mat')
load Kgroup1
load Kgroup2
load Kgroup3

h = figure('Renderer', 'Painters');
set(h,'Units','normalized')
set(h, 'Position',  [0.1    0.06    0.5    0.85])
set(h,'Color',[1 1 1]);
axis off
% set(h,'windowState','maximized')
hold on

dark = [0.105882352941176,0.619607843137255,0.466666666666667;0.850980392156863,0.372549019607843,0.00784313725490196;0.458823529411765,0.439215686274510,0.701960784313725;0.905882352941177,0.160784313725490,0.541176470588235;0.4000    0.6510    0.1176;0.9020    0.6706    0.0078];
cBL1 = dark(1,:);
cBL2 = dark(2,:);
cTRN = dark(3,:);
cTFR = dark(4,:);
cLateTFR = dark(5,:);
cEarlyTRN = dark(6,:);

numTrials = 3;
key = [60 120 121 300 301 360];
for k = 1:length(key)
    if  ismember(key(k),[60 120 300 360])
        for i=1:10
            Kgroup1(key(k),:,i) = meanDirection3D(Kgroup1((key(k)-(numTrials-1)):key(k),:,i));
            Kgroup2(key(k),:,i) = meanDirection3D(Kgroup2((key(k)-(numTrials-1)):key(k),:,i));
            Kgroup3(key(k),:,i) = meanDirection3D(Kgroup3((key(k)-(numTrials-1)):key(k),:,i));
        end
    else
        for i=1:10
            Kgroup1(key(k),:,i) = meanDirection3D(Kgroup1(key(k):(key(k)+(numTrials-1)),:,i));
            Kgroup2(key(k),:,i) = meanDirection3D(Kgroup2(key(k):(key(k)+(numTrials-1)),:,i));
            Kgroup3(key(k),:,i) = meanDirection3D(Kgroup3(key(k):(key(k)+(numTrials-1)),:,i));
        end
    end
end

LateBL1 = [squeeze(Kgroup1(60,:,:))';squeeze(Kgroup2(60,:,:))';squeeze(Kgroup3(60,:,:))'];
EarlyTRN = [squeeze(Kgroup1(121,:,:))';squeeze(Kgroup2(121,:,:))';squeeze(Kgroup3(121,:,:))'];
LateTRN = [squeeze(Kgroup1(300,:,:))';squeeze(Kgroup2(300,:,:))';squeeze(Kgroup3(300,:,:))'];
LateBL2 = [squeeze(Kgroup1(120,:,:))';squeeze(Kgroup2(120,:,:))';squeeze(Kgroup3(120,:,:))'];
EarlyTFR = [squeeze(Kgroup1(301,:,:))';squeeze(Kgroup2(301,:,:))';squeeze(Kgroup3(301,:,:))'];
LateTFR = [squeeze(Kgroup1(360,:,:))';squeeze(Kgroup2(360,:,:))';squeeze(Kgroup3(360,:,:))'];
% a
plotSphereComparison_within(LateBL1(1:10,:),EarlyTRN(1:10,:),cBL1,cEarlyTRN,[0.15 0.8 0.18 0.18],rotx(0),rotx(0),'idealBL1','mean',1,2);
plotSphereComparison_within(LateBL1(11:20,:),EarlyTRN(11:20,:),cBL1,cEarlyTRN,[0.37 0.8 0.18 0.18],rotx(0),rotx(0),'idealBL1','mean',2,0);
plotSphereComparison_within(LateBL1(21:30,:),EarlyTRN(21:30,:),cBL1,cEarlyTRN,[0.59 0.8 0.18 0.18],rotx(0),rotx(0),'idealBL1','mean',3,2);
%b
plotSphereComparison_within(EarlyTRN(1:10,:),LateTRN(1:10,:),cEarlyTRN,cTRN,[0.15 0.67 0.18 0.18],rotx(0),rotx(0),'mean','mean',1,1);
plotSphereComparison_within(EarlyTRN(11:20,:),LateTRN(11:20,:),cEarlyTRN,cTRN,[0.37 0.67 0.18 0.18],rotx(0),rotx(0),'mean','mean',2,2);
plotSphereComparison_within(EarlyTRN(21:30,:),LateTRN(21:30,:),cEarlyTRN,cTRN,[0.59 0.67 0.18 0.18],rotx(0),rotx(0),'mean','mean',3,2);
%c
plotSphereComparison_within(LateBL1(1:10,:),LateTRN(1:10,:),cBL1,cTRN,[0.15 0.54 0.18 0.18],rotx(-60),rotx(0),'idealBL1rot','mean',1,2);
plotSphereComparison_within(LateBL1(11:20,:),LateTRN(11:20,:),cBL1,cTRN,[0.37 0.54 0.18 0.18],rotx(-60),rotx(0),'idealBL1rot','mean',2,2);
plotSphereComparison_within(LateBL1(21:30,:),LateTRN(21:30,:),cBL1,cTRN,[0.59 0.54 0.18 0.18],rotx(-60),rotx(0),'idealBL1rot','mean',3,2);
%d
plotSphereComparison_within(LateBL2(1:10,:),EarlyTFR(1:10,:),cBL2,cTFR,[0.15 0.41 0.18 0.18],rotx(0),rotx(0),'idealBL2','mean',1,2);
plotSphereComparison_within(LateBL2(11:20,:),EarlyTFR(11:20,:),cBL2,cTFR,[0.37 0.41 0.18 0.18],rotx(0),rotx(0),'idealBL2','mean',2,1);
plotSphereComparison_within(LateBL2(21:30,:),EarlyTFR(21:30,:),cBL2,cTFR,[0.59 0.41 0.18 0.18],rotx(0),rotx(0),'idealBL2','mean',3,1);
%e
plotSphereComparison_within(EarlyTFR(1:10,:),LateTFR(1:10,:),cTFR,cLateTFR,[0.15 0.28 0.18 0.18],rotx(0),rotx(0),'mean','mean',1,2);
plotSphereComparison_within(EarlyTFR(11:20,:),LateTFR(11:20,:),cTFR,cLateTFR,[0.37 0.28 0.18 0.18],rotx(0),rotx(0),'mean','mean',2,0);
plotSphereComparison_within(EarlyTFR(21:30,:),LateTFR(21:30,:),cTFR,cLateTFR,[0.59 0.28 0.18 0.18],rotx(0),rotx(0),'mean','mean',3,0);
%f
plotSphereComparison_within(LateBL2(1:10,:),LateTFR(1:10,:),cBL2,cLateTFR,[0.15 0.15 0.18 0.18],rotx(0),rotx(0),'idealBL2','mean',1,0);
plotSphereComparison_within(LateBL2(11:20,:),LateTFR(11:20,:),cBL2,cLateTFR,[0.37 0.15 0.18 0.18],rotx(0),rotx(0),'idealBL2','mean',2,1);
plotSphereComparison_within(LateTRN(1:10,:),EarlyTFR(1:10,:),cTRN,cTFR,[0.59 0.15 0.18 0.18],rotx(-90),rotx(0),'mean','mean',1,2);

cg1 = [0.8941    0.1020    0.1098];
cg2 = [0.2157    0.4941    0.7216];
cg3 = [0.3020    0.6863    0.2902];

plotSphereComparison_between(EarlyTRN(1:10,:),EarlyTRN(11:20,:),EarlyTRN(21:30,:),cg1,cg2,cg3,[0.15 -0.025 0.18 0.18],rotx(-90),rotx(0),rotx(0),1,0,0);
plotSphereComparison_between(LateTRN(1:10,:),LateTRN(11:20,:),LateTRN(21:30,:),cg1,cg2,cg3,[0.37 -0.025 0.18 0.18],rotx(-90),rotx(0),rotx(0),0,0,0);
plotSphereComparison_between(EarlyTFR(1:10,:),EarlyTFR(11:20,:),EarlyTFR(21:30,:),cg1,cg2,cg3,[0.59 -0.025 0.18 0.18],rotx(0),rotx(0),rotx(-90),2,2,2);

axes('Position',[0.1 0.155 0.05 0.8])
text(0,0,{'Late BL2','     vs.','Late TFR'});text(-0.8,0.4,{'(f)'})
text(0,1,{'Early TFR','     vs.','Late TFR'});text(-0.8,1.4,{'(e)'})
text(0,2,{'Late BL2','     vs.','Early TFR'});text(-0.8,2.4,{'(d)'})
text(0,3,{'Late BL1','     vs.','Late TRN'});text(-0.8,3.4,{'(c)'})
text(0,4,{'Early TRN','     vs.','Late TRN'});text(-0.8,4.4,{'(b)'})
text(0,5,{'Late BL1','     vs.','Early TRN'});text(-0.8,5.4,{'(a)'})
ylim([-0.7 5.5])
axis off

axes('Position',[0.00 0.155 0.86 0.05])
text(1,0,'Early TRN')
text(2,0,'Late TRN')
text(3,0,'Early TFR')
xlim([0 4])
axis off

axes('Position',[0.08 0.08 0.05 0.1])
text(0,0,{'   Between','    Groups','Comparisons'});text(-0.4,0.6,{'(g)'})
axis off

axes('Position',[0.84 -0.1 0.05 0.8])
text(0,2,{'Extrinsic Group:','     Late TRN','           vs.','     Early TFR'})
ylim([-0.7 5.5])
axis off

axes('Position',[0.61 0.178 0.385 0.13])
rectangle('Position',[0.7 0 0.1 0.1],'Curvature',0,'EdgeColor','k','FaceColor','none')
axis off

axes('Position',[-0.00 0.98 0.8 0.1])
text(0.9,0,'Extrinsic Group','FontSize',10)
text(2.1,0,'Intrinsic Group','FontSize',10)
text(3.2,0,'Control Group','FontSize',10)
axis off
xlim([0 4])

% legend
axes('Position',[0.805 0.52 0.2 0.4]); hold on
sLateBL1 = scatter(0,0,12,'filled','MarkerFaceColor',cBL1,'MarkerEdgeColor',cBL1,'LineWidth',0.5);
sEarlyTRN = scatter(0,1,12,'filled','MarkerFaceColor',cEarlyTRN,'MarkerEdgeColor',cEarlyTRN,'LineWidth',0.5);
sLateTRN = scatter(0,2,12,'filled','MarkerFaceColor',cTRN,'MarkerEdgeColor',cTRN,'LineWidth',0.5);
sLateBL2 = scatter(0,3,12,'filled','MarkerFaceColor',cBL2,'MarkerEdgeColor',cBL2,'LineWidth',0.5);
sEarlyTFR = scatter(0,4,12,'filled','MarkerFaceColor',cTFR,'MarkerEdgeColor',cTFR,'LineWidth',0.5);
sLateTFR = scatter(0,5,12,'filled','MarkerFaceColor',cLateTFR,'MarkerEdgeColor',cLateTFR,'LineWidth',0.5);
qBL1 = quiver3(0,0,0,1,1,1,'Color',cBL1,'AutoScaleFactor',1.2,'LineWidth',2);
qBL2 = quiver3(0,0,0,1,1,1,'Color',cBL2,'AutoScaleFactor',1.2,'LineWidth',2);
qEarlyTRN = quiver3(0,0,0,1,1,1,'Color',cEarlyTRN,'AutoScaleFactor',1.2,'LineWidth',2);
qLateTRN = quiver3(0,0,0,1,1,1,'Color',cTRN,'AutoScaleFactor',1.2,'LineWidth',2);
qEarlyTFR = quiver3(0,0,0,1,1,1,'Color',cTFR,'AutoScaleFactor',1.2,'LineWidth',2);
qLateTFR = quiver3(0,0,0,1,1,1,'Color',cLateTFR,'AutoScaleFactor',1.2,'LineWidth',2);
arcs = plot(1,1,'k');
p1 = scatter(0,0,12,'k','Marker','*');

ylim([-10 -2])
legend([sLateBL1,sLateBL2,sEarlyTRN,sLateTRN,sEarlyTFR,sLateTFR,...
    qBL1,qBL2,qEarlyTRN,qLateTRN,qEarlyTFR,qLateTFR,arcs]...
    ,{'Late BL1','Late BL2','Early TRN','Late TRN','Early TFR','Late TFR',...
    'Ideal BL1','Ideal BL2','Average Early TRN','Average Late TRN','Average Early TFR','Average Late TFR',...
    'change in axis'},'Box','off'...
    );
hold
axis off

axes('Position',[0.80 0.53 0.205 0.38]); hold on
rectangle('Position',[0.09 0.1 0.67 0.4])
axis off

axes('Position',[0.805 0.52 0.2 0.4]); hold on
text(0.245,0.375,'\fontsize{10}*      \fontsize{7}p < 0.05','FontSize',7);
text(0.245,0.325,'\fontsize{10}**    \fontsize{7}p < 0.001');

axis off

axes('Position',[0.805 0.45 0.2 0.2]); hold on
sg1 = scatter(0,6,12,'filled','MarkerFaceColor',cg1,'MarkerEdgeColor',cg1,'LineWidth',0.5);
sg2 = scatter(0,6,12,'filled','MarkerFaceColor',cg2,'MarkerEdgeColor',cg2,'LineWidth',0.5);
sg3 = scatter(0,6,12,'filled','MarkerFaceColor',cg3,'MarkerEdgeColor',cg3,'LineWidth',0.5);
qg1 = quiver3(0,0,0,1,1,1,'Color',cg1,'AutoScaleFactor',1.2,'LineWidth',2);
qg2 = quiver3(0,0,0,1,1,1,'Color',cg2,'AutoScaleFactor',1.2,'LineWidth',2);
qg3 = quiver3(0,0,0,1,1,1,'Color',cg3,'AutoScaleFactor',1.2,'LineWidth',2);
legend([sg1,sg2,sg3,qg1,qg2,qg3],{'Extrinsic','Intrinsic','Control','Average - Extrinsic','Average - Intrinsic','Average - Control'},...
    'box','off')
ylim([-10 -2])
hold
axis off

% exportgraphics(gcf,'exp2_spherical_analysis.pdf','Resolution',300,'ContentType','vector','BackgroundColor','none')