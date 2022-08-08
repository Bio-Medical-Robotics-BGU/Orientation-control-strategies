function exp2_results()
set(0,'defaultfigureposition',get(0, 'Screensize')-[-10,-10,100,100]);
set(0,'defaultTextFontSize',15);
set(0,'defaultTextFontName','Times');
set(0,'defaultAxesFontName','Times');
set(0,'defaultAxesFontSize',15);
set(0,'defaultLineLineWidth',1);
set(0,'defaultAxesTickLabelInterpreter','tex');
set(0,'defaultLegendInterpreter','tex');
set(0,'defaultTextInterpreter','tex');

load('exp2plotdata.mat')
data = exp2plotdata;
mean_hand_angle = data.mean_hand_angle;
rotation_axes = data.rotation_axes;
sigma = data.sigma;
hand_angle = data.hand_angle;

load('exp2plotdata_FML.mat')
data_FML = exp2plotdata_FML;
mean_hand_angle_FML = data_FML.mean_hand_angle;
rotation_axes_FML = data_FML.rotation_axes;
sigma_FML = data_FML.sigma;
hand_angle_FML = data_FML.hand_angle;

% Spheres   
dark = [0.105882352941176,0.619607843137255,0.466666666666667;0.850980392156863,0.372549019607843,0.00784313725490196;0.458823529411765,0.439215686274510,0.701960784313725;0.905882352941177,0.160784313725490,0.541176470588235];
cBL1 = dark(1,:);
cBL2 = dark(2,:);
cTRN = dark(3,:);
cTFR = dark(4,:);
h = figure('Renderer', 'Painters');
set(h,'Units','normalized')
set(h, 'Position',  [0.1823    0.1198    0.4817    0.5521])
set(h,'Color',[1 1 1]);
set(h,'windowState','maximized')
hold on

for group=1:3
    switch group
        case 1
            desBL1 = [0 -1 1]/sqrt(2);
            desBL2 = [0 1 1]/sqrt(2);
        case 2
            desBL1 = [0 1 1]/sqrt(2);
            desBL2 = [0 1 1]/sqrt(2);
        case 3
            desBL1 = [0 1 1]/sqrt(2);
            desBL2 = [0 -1 1]/sqrt(2);
    end
    desTRN = axang2rotm([1 0 0 -pi/3])*desBL1';

    ax = subplot(3,3,1+3*(group-1));

    if group==1
        ax.InnerPosition = [-0.02, 0.65, 1/3, 0.3];
    elseif group==2
         ax.InnerPosition = [-0.02, 0.35, 1/3, 0.3];
    else
        ax.InnerPosition = [-0.02, 0.05, 1/3, 0.3];
    end

    plotSphFrameSegment;
    R = axang2rotm([[0 1 0] deg2rad(90)]);
    K = nan(360,3);
    for trNum=1:size(K,1)
        K(trNum,:) = (R*rotation_axes(trNum,:,group)')';
    end

    K_FML = nan(60,3);
    for trNum=1:size(K_FML,1)
        K_FML(trNum,:) = (R*rotation_axes_FML(trNum,:,group)')';
    end


    desBL1 = R*desBL1';desBL2 = R*desBL2';desTRN = R*desTRN;desEarlyTFR = axang2rotm([0 0 1 deg2rad(60)])*desBL2;

    
    sFML1 = scatter3(K_FML(1:30,1),K_FML(1:30,2),K_FML(1:30,3),12,'filled','MarkerFaceColor',cBL1,'MarkerEdgeColor','k','LineWidth',0.5);
    sFML2 = scatter3(K_FML(31:60,1),K_FML(31:60,2),K_FML(31:60,3),12,'filled','MarkerFaceColor',cBL2,'MarkerEdgeColor','k','LineWidth',0.5);

    sBL1 = scatter3(K(1:60,1),K(1:60,2),K(1:60,3),12,'filled','MarkerFaceColor',cBL1,'MarkerEdgeColor',cBL1,'LineWidth',0.5);
    sBL2 = scatter3(K(61:120,1),K(61:120,2),K(61:120,3),12,'filled','MarkerFaceColor',cBL2,'MarkerEdgeColor',cBL2,'LineWidth',0.5);
    sTRN = scatter3(K(121:300,1),K(121:300,2),K(121:300,3),12,'filled','MarkerFaceColor',cTRN,'MarkerEdgeColor',cTRN,'LineWidth',0.5);
    sTFR = scatter3(K(301:360,1),K(301:360,2),K(301:360,3),12,'filled','MarkerFaceColor',cTFR,'MarkerEdgeColor',cTFR,'LineWidth',0.5);
    qBL1 = quiver3(0,0,0,desBL1(1),desBL1(2),desBL1(3),'Color',cBL1,'AutoScaleFactor',1.1,'LineWidth',2);
    qTRN = quiver3(0,0,0,desTRN(1),desTRN(2),desTRN(3),'Color',cTRN,'AutoScaleFactor',1.1,'LineWidth',2);
    qBL2 = quiver3(0,0,0,desBL2(1),desBL2(2),desBL2(3),'Color',cBL2,'AutoScaleFactor',1.1,'LineWidth',2);
    qEarlyTFR = quiver3(0,0,0,desEarlyTFR(1),desEarlyTFR(2),desEarlyTFR(3),'Color',cTFR,'AutoScaleFactor',1.1,'LineWidth',2);

    sFML1.MarkerFaceAlpha = 0.5;sFML1.MarkerEdgeAlpha = 0.5;
    sFML2.MarkerFaceAlpha = 0.5;sFML2.MarkerEdgeAlpha = 0.5;
    sBL1.MarkerFaceAlpha = 0.5;sBL1.MarkerEdgeAlpha = 0.5;
    sBL2.MarkerFaceAlpha = 0.5;sBL2.MarkerEdgeAlpha = 0.5;
    sTRN.MarkerFaceAlpha = 0.5;sTRN.MarkerEdgeAlpha = 0.5;
    sTFR.MarkerFaceAlpha = 0.5;sTFR.MarkerEdgeAlpha = 0.5;
    hold

    xlim([-1 1]);
    ylim([-1 1]);
    zlim([-0.3 0.3]);
    axis equal


    if group==1
        a = axes('Position',[0, 0.65, 0.05, 0.3]);
        a.YAxis.Visible = 'off';
        a.XAxis.Visible = 'off';
        text(0.1,0.55,{'Extrinsic','  Group'},'Rotation',00,'FontSize',15)
    elseif group==2
        a = axes('Position',[0, 0.35, 0.05, 0.3]);
        a.YAxis.Visible = 'off';
        a.XAxis.Visible = 'off';
        text(0.1,0.55,{'Intrinsic','  Group'},'Rotation',00,'FontSize',15)
    else
        a = axes('Position',[0, 0.05, 0.05, 0.3]);
        a.YAxis.Visible = 'off';
        a.XAxis.Visible = 'off';
        text(0.1,0.55,{'Control',' Group'},'Rotation',00,'FontSize',15)
    end

end
%  
% Curves
ax = subplot(3,3,[2,5,8]);
ax.FontSize = 13;
ax.InnerPosition = [0.3, 0.11, 0.25, 0.815];
colors(1:60,:) = repmat(dark(1,:),60,1);
colors(61:120,:) = repmat(dark(2,:),60,1);
colors(121:300,:) = repmat(dark(3,:),180,1);
colors(301:360,:) = repmat(dark(4,:),60,1);
hold on

xline(-31,'--','LineWidth',1);xline(0,'--','LineWidth',1);
xline(61,'--','LineWidth',1);xline(122,'--','LineWidth',1);xline(303,'--','LineWidth',1);
xlim([-61 364])
ylim([-60 408])
xlabel('Trial Number','FontSize',15)
ylabel('Aiming Angle [deg]','FontSize',15)
xticks([-61 -32 1 60 121 181 241 302 364])
xticklabels({'1','30','60','120','180','240','300','360','420'})
yticks([-60,-30,0,30,60,88,102,130,160,190,220,248,262,290,320,350,380,408])  
yticklabels({'-60','-30','0','30','60','90','-60','-30','0','30','60','90','-60','-30','0','30','60','90'});

MM(2,:) = mean_hand_angle(2,:) + 160;
MM(1,:) = mean_hand_angle(1,:) + 320;
MM(3,:) = mean_hand_angle(3,:);

MM_FML(2,:) = mean_hand_angle_FML(2,:) + 160;
MM_FML(1,:) = mean_hand_angle_FML(1,:) + 320;
MM_FML(3,:) = mean_hand_angle_FML(3,:);

for i=1:3
    m = MM(i,:);
    s = sigma(i,:);

    m_FML = MM_FML(i,:);
    s_FML = sigma_FML(i,:);
    
    
    for j=1:10
    p = plot(-61:-32,hand_angle_FML(j,1:30,i)'+0*(i==3)+160*(i==2)+320*(i==1));    
    p.Color = [colors(1,:) 0.075];
    p = plot(-30:-1,hand_angle_FML(j,31:60,i)'+0*(i==3)+160*(i==2)+320*(i==1));    
    p.Color = [colors(61,:) 0.075];

    p = plot(1:60,hand_angle(j,1:60,i)'+0*(i==3)+160*(i==2)+320*(i==1));    
    p.Color = [colors(1,:) 0.075];
    p = plot(62:121,hand_angle(j,61:120,i)'+0*(i==3)+160*(i==2)+320*(i==1));    
    p.Color = [colors(61,:) 0.075];
    p = plot(123:302,hand_angle(j,121:300,i)'+0*(i==3)+160*(i==2)+320*(i==1));    
    p.Color = [colors(121,:) 0.075];
    p = plot(304:363,hand_angle(j,301:360,i)'+0*(i==3)+160*(i==2)+320*(i==1));    
    p.Color = [colors(301,:) 0.075];
    end


    p = patch([-61:-32,fliplr(-61:-32)],[m_FML(1:30)-s_FML(1:30),fliplr(m_FML(1:30)+s_FML(1:30))],'r');
    p.FaceColor = colors(1,:); p.FaceAlpha = 0.3; p.EdgeColor = 'none';
    p = patch([-30:-1,fliplr(-30:-1)],[m_FML(31:60)-s_FML(31:60),fliplr(m_FML(1:30)+s_FML(1:30))],'r');
    p.FaceColor = colors(61,:); p.FaceAlpha = 0.3; p.EdgeColor = 'none';
    
    p = patch([1:60,fliplr(1:60)],[m(1:60)-s(1:60),fliplr(m(1:60)+s(1:60))],'r');
    p.FaceColor = colors(1,:); p.FaceAlpha = 0.3; p.EdgeColor = 'none';
    p = patch([62:121,fliplr(62:121)],[m(61:120)-s(61:120),fliplr(m(61:120)+s(61:120))],'r');
    p.FaceColor = colors(61,:); p.FaceAlpha = 0.3; p.EdgeColor = 'none';
    p = patch([123:302,fliplr(123:302)],[m(121:300)-s(121:300),fliplr(m(121:300)+s(121:300))],'r');
    p.FaceColor = colors(121,:); p.FaceAlpha = 0.3; p.EdgeColor = 'none';
    p = patch([304:363,fliplr(304:363)],[m(301:360)-s(301:360),fliplr(m(301:360)+s(301:360))],'r');
    p.FaceColor = colors(301,:); p.FaceAlpha = 0.3; p.EdgeColor = 'none';
            
    p = scatter(-61:-32,m_FML(1:30),12,'filled');
    p.MarkerEdgeColor = 'k';
    p.MarkerEdgeAlpha = 0.5;
    p.MarkerFaceColor = colors(1,:);

    p = scatter(-30:-1,m_FML(31:60),12,'filled');
    p.MarkerEdgeColor = 'k';
    p.MarkerEdgeAlpha = 0.5;
    p.MarkerFaceColor = colors(61,:);
    
    p = scatter(1:60,m(1:60),12,'filled');
    p.MarkerEdgeColor = colors(1,:);
    p.MarkerFaceColor = colors(1,:);
    p = scatter(62:121,m(61:120),12,'filled');
    p.MarkerEdgeColor = colors(61,:);
    p.MarkerFaceColor = colors(61,:);
    p = scatter(123:302,m(121:300),12,'filled');
    p.MarkerEdgeColor = colors(121,:);
    p.MarkerFaceColor = colors(121,:);
    p = scatter(304:363,m(301:360),12,'filled');
    p.MarkerEdgeColor = colors(301,:);
    p.MarkerFaceColor = colors(301,:);

    if i==1
        text(-45,59+320,'FML1','FontSize',12,'rotation',90)
        text(-15,59+320,'FML2','FontSize',12,'rotation',90)
        text(17,85+320,'BL1','FontSize',12)
        text(77,85+320,'BL2','FontSize',12)
        text(190,85+320,'TRN','FontSize',12)
        text(320,85+320,'TFR','FontSize',12)
    end
end

p = line([-61,122],[0,0],'Color','k','LineWidth',1);
p = line([122,303],[60,60],'Color','k','LineWidth',1);
p = line([303,363],[0,0],'Color','k','LineWidth',1);
p = line([-61,122],[160,160],'Color','k','LineWidth',1);
p = line([122,303],[220,220],'Color','k','LineWidth',1);
p = line([303,363],[160,160],'Color','k','LineWidth',1);
p = line([-61,122],[320,320],'Color','k','LineWidth',1);
p = line([122,303],[380,380],'Color','k','LineWidth',1);
p = line([303,363],[320,320],'Color','k','LineWidth',1);

a = axes('Position',[0.3, (1895+20)/5200, 0.02, (136-12)/5200]);
a.YAxis.Visible = 'off';
a.XAxis.Visible = 'off'; 
b = axes('Position',[0.3, (3356+5)/5200, 0.02, (136-12)/5200]);
b.YAxis.Visible = 'off';
b.XAxis.Visible = 'off';

% Bars
set(0,'defaultTextFontSize',7);
map =     [0.7020    0.8863    0.8039
    0.9922    0.8039    0.6745
    0.7961    0.8353    0.9098
    0.9569    0.7922    0.8941];
map2 = [0.105882352941176,0.619607843137255,0.466666666666667;0.850980392156863,0.372549019607843,0.00784313725490196;0.458823529411765,0.439215686274510,0.701960784313725;0.905882352941177,0.160784313725490,0.541176470588235];

for group=1:3
    ax = subplot(3,3,3+3*(group-1));
    if group==1
        ax.InnerPosition = [0.58, 0.67, 0.25, 0.245];
    elseif group==2
         ax.InnerPosition = [0.58, 0.386, 0.25, 0.245];
    else
        ax.InnerPosition = [0.58, 0.11, 0.25, 0.245];
    end
    hold on
    err = hand_angle(:,:,group);
    for key = [60 120 121 300 301 360]
        for ss=1:10
            if ismember(key,[121,301])
                err(ss,key) = nanmean(err(ss,key:(key+2)));
            else
                err(ss,key) = nanmean(err(ss,(key-2):key));
            end
        end
    end
    numSubs = size(err,1);
    m = nanmean(err,1);
    s = nanstd(err,1)/10;

    err_FML = hand_angle_FML(:,:,group);
    for key = [30 60]
        for ss=1:10
            err_FML(ss,key) = nanmean(err_FML(ss,(key-2):key));
        end
    end
    numSubs = size(err_FML,1);

    bar(-1,m(60),0.5,'FaceColor',map(1,:),'EdgeColor',map(1,:));
    errorbar(-1,m(60),s(60),'Color','k','LineWidth',2)
    scatter(-1*ones(numSubs,1),err(:,60),12,'filled','MarkerFaceColor',map2(1,:),'MarkerEdgeColor',map2(1,:))
    bar(0,m(120),0.5,'FaceColor',map(2,:),'EdgeColor',map(2,:));
    errorbar(0,m(120),s(120),'Color','k','LineWidth',2)
    scatter(0*ones(numSubs,1),err(:,120),12,'filled','MarkerFaceColor',map2(2,:),'MarkerEdgeColor',map2(2,:)) 
    bar(1,m(121),0.5,'FaceColor',map(3,:),'EdgeColor',map(3,:));
    errorbar(1,m(121),s(121),'Color','k','LineWidth',2)
    scatter(ones(numSubs,1),err(:,121),12,'filled','MarkerFaceColor',map2(3,:),'MarkerEdgeColor',map2(3,:))
    bar(2,m(300),0.5,'FaceColor',map(3,:),'EdgeColor',map(3,:));
    errorbar(2,m(300),s(300),'Color','k','LineWidth',2)
    scatter(2*ones(numSubs,1),err(:,300),12,'filled','MarkerFaceColor',map2(3,:),'MarkerEdgeColor',map2(3,:))
    bar(3,m(301),0.5,'FaceColor',map(4,:),'EdgeColor',map(4,:));
    errorbar(3,m(301),s(301),'Color','k','LineWidth',2)
    scatter(3*ones(numSubs,1),err(:,301),12,'filled','MarkerFaceColor',map2(4,:),'MarkerEdgeColor',map2(4,:))
    bar(4,m(360),0.5,'FaceColor',map(4,:),'EdgeColor',map(4,:));
    errorbar(4,m(360),s(360),'Color','k','LineWidth',2)    
    scatter(4*ones(numSubs,1),err(:,360),12,'filled','MarkerFaceColor',map2(4,:),'MarkerEdgeColor',map2(4,:))

    for subNum=1:numSubs   
        plot([1 2],[err(subNum,121),err(subNum,300)],'-','color',map2(3,:),'LineWidth',0.5);
        plot([3 4],[err(subNum,301),err(subNum,360)],'-','color',map2(4,:),'LineWidth',0.5);
    end   

    ylim([-60 90]);    
    yticks([-60 -30 0 30 60])
    xticks([-1 0 1 2 3 4]);
    xticklabels({'Late BL1','Late BL2','Early TRN','Late TRN','Early TFR','Late TFR'})
    xlim([-1.5 4.5]);
    hold
    
    
    if group==1
        text(1,89+3,'','FontSize',10)
        text(0,82+3+10,'* d = 2.78','FontSize',10)
        text(-1,75+3,'** d = 2.33','FontSize',10)
        text(3,59+3,'** d = 1.47','FontSize',10)
        text(0.9,-40,'  d = 1.15','FontSize',10)
        text(-1,55+8,' d = 1.14','FontSize',10)
    elseif group==2
        text(0.9,-40,' * d = 1.02','FontSize',10)
        text(-1,75+3,'** d = 4.34','FontSize',10)
        text(0,82+3+10,'d = 0.25','FontSize',10)
        text(-1,55+8,' d = 0.52','FontSize',10)
        text(3,59+3,'d = 0.18','FontSize',10)
    else
        text(0.9,-40,' * d = 1.48','FontSize',10)
        text(-1,75+3,'** d = 2.56','FontSize',10)
        text(0,82+3+10,'d = 0.61','FontSize',10)
        text(-1,55+8,' d = 1.29','FontSize',10)
        text(3,59+3,'d = 0.36','FontSize',10)
    end
    
    line([-1 2],[70 70],'Color','k','LineWidth',1);
    line([-1 -1],[65 70],'Color','k','LineWidth',1);
    line([2 2],[65 70],'Color','k','LineWidth',1);

    line([-1 1],[55 55],'Color','k','LineWidth',1);
    line([-1 -1],[50 55],'Color','k','LineWidth',1);
    line([1 1],[50 55],'Color','k','LineWidth',1);

    line([3 4],[55 55],'Color','k','LineWidth',1);
    line([3 3],[50 55],'Color','k','LineWidth',1);
    line([4 4],[50 55],'Color','k','LineWidth',1);



    line([0 3],[78+10 78+10],'Color','k','LineWidth',1);
    line([0 0],[73+10 78+10],'Color','k','LineWidth',1);
    line([3 3],[73+10 78+10],'Color','k','LineWidth',1);
    
    line([1 2],[-35 -35],'Color','k','LineWidth',1);
    line([1 1],[-35 -30],'Color','k','LineWidth',1);
    line([2 2],[-35 -30],'Color','k','LineWidth',1);
    
    ax.XAxis.Visible = 'off';
    if group==1
        a = axes('Position',[0.719-0.14, 0.68+0.159+0.027, 0.02, 0.05]);
        a.YAxis.Visible = 'off';
        a.XAxis.Visible = 'off';
    elseif group==2
        a = axes('Position',[0.719-0.14, 0.39+0.165+0.027, 0.02, 0.05]);
        a.YAxis.Visible = 'off';
        a.XAxis.Visible = 'off';
    elseif group==3
        ax.XAxis.Visible = 'on';
        a = axes('Position',[0.719-0.14, 0.11+0.168+0.029, 0.02, 0.05]);
        a.YAxis.Visible = 'off';
        a.XAxis.Visible = 'off'; 
    end      
end
a = axes('Position',[0, 0.95, 1, 0.1]);
a.YAxis.Visible = 'off';
a.XAxis.Visible = 'off';
text(0.02,0,'(a)','FontSize',15)
text(0.26,0,'(b)','FontSize',15)
text(0.56,0,'(c)','FontSize',15)
text(0.83,0,'(d)','FontSize',15)

a = axes('Position',[0.12, 0.95, 0.1, 0.1]);
a.YAxis.Visible = 'off';
a.XAxis.Visible = 'off';
text(0,0,'Aiming Axes','FontSize',15)

for key = [121,300,301]
    if key==121
        ax = axes('Position',[0.865, 0.67, 0.13, 0.245]);
         err = squeeze(nanmean(hand_angle(:,121:123,:),2));
    elseif key==300
        ax = axes('Position', [0.865, 0.386, 0.13, 0.245]);
        err = squeeze(nanmean(hand_angle(:,298:300,:),2));
    else
        ax = axes('Position',[0.865, 0.11, 0.13, 0.245]);
        err = squeeze(nanmean(hand_angle(:,301:303,:),2));
    end
    hold on
    
    numSubs = size(err,1);
    m = nanmean(err,1);
    s = nanstd(err,1)/10;

    cg = [0.78 0.78 0.78];
    cs = [0.2 0.2 0.2];
    
    bar(-1,m(1),0.5,'FaceColor',cg,'EdgeColor',cg);
    errorbar(-1,m(1),s(1),'Color','k','LineWidth',2)
    scatter(-1*ones(numSubs,1),err(:,1),12,'filled','MarkerFaceColor',cs,'MarkerFaceColor',cs)

    bar(0,m(2),0.5,'FaceColor',cg,'EdgeColor',cg);
    errorbar(0,m(2),s(2),'Color','k','LineWidth',2)
    scatter(0*ones(numSubs,1),err(:,2),12,'filled','MarkerFaceColor',cs,'MarkerFaceColor',cs) 

    bar(1,m(3),0.5,'FaceColor',cg,'EdgeColor',cg);
    errorbar(1,m(3),s(3),'Color','k','LineWidth',2)
    scatter(ones(numSubs,1),err(:,3),12,'filled','MarkerFaceColor',cs,'MarkerFaceColor',cs)

   

    ylim([-60 90]);    
    yticks([-60 -30 0 30 60])
    xticks([-1 0 1]);
    xticklabels({'Extrinsic','Intrinsic','Control'})
    xlim([-1.5 1.5]);
    hold
    
    

    if key==121
        line([-1 -0.1],[60 60],'Color','k','LineWidth',1);
        line([-1 -1],[55 60],'Color','k','LineWidth',1);
        line([-0.1 -0.1],[55 60],'Color','k','LineWidth',1);
        text(-0.9,66,'d = 0.64','FontSize',10)
        
        line([0.1 1],[60 60],'Color','k','LineWidth',1);
        line([1 1],[55 60],'Color','k','LineWidth',1);
        line([0.1 0.1],[55 60],'Color','k','LineWidth',1);
        text(0.2,66,'d = 0.24','FontSize',10)

        line([-1 1],[75 75],'Color','k','LineWidth',1);
        line([-1 -1],[70 75],'Color','k','LineWidth',1);
        line([1 1],[70 75],'Color','k','LineWidth',1);
        text(-0.4,81,'d = 0.64','FontSize',10)
        ylabel('Early TRN')

    elseif key==300
        line([-1 -0.1],[70 70],'Color','k','LineWidth',1);
        line([-1 -1],[65 70],'Color','k','LineWidth',1);
        line([-0.1 -0.1],[65 70],'Color','k','LineWidth',1);
        text(-0.9,76,'d = 0.39','FontSize',10)
        
        line([0.1 1],[70 70],'Color','k','LineWidth',1);
        line([1 1],[65 70],'Color','k','LineWidth',1);
        line([0.1 0.1],[65 70],'Color','k','LineWidth',1);
        text(0.2,76,'d = 0.03','FontSize',10)

        line([-1 1],[85 85],'Color','k','LineWidth',1);
        line([-1 -1],[80 85],'Color','k','LineWidth',1);
        line([1 1],[80 85],'Color','k','LineWidth',1);
        text(-0.4,91,'d = 0.38','FontSize',10)

       ylabel('Late TRN')

    elseif key==301

        line([-1 -0.1],[50 50],'Color','k','LineWidth',1);
        line([-1 -1],[45 50],'Color','k','LineWidth',1);
        line([-0.1 -0.1],[45 50],'Color','k','LineWidth',1);
        text(-1,56,'* d = 1.45','FontSize',10)
        
        line([0.1 1],[50 50],'Color','k','LineWidth',1);
        line([1 1],[45 50],'Color','k','LineWidth',1);
        line([0.1 0.1],[45 50],'Color','k','LineWidth',1);
        text(0.2,56,'d = 0.97','FontSize',10)

        line([-1 1],[65 65],'Color','k','LineWidth',1);
        line([-1 -1],[60 65],'Color','k','LineWidth',1);
        line([1 1],[60 65],'Color','k','LineWidth',1);
        text(-0.5,71,'** d = 2.83','FontSize',10)

         ylabel('Early TFR')

    end

   ax.XAxis.Visible = 'off';
    if key==121
        a = axes('Position',[0.847+0.015, 0.68+0.159+0.027, 0.02, 0.05]);
        a.YAxis.Visible = 'off';
        a.XAxis.Visible = 'off';
    elseif key==300
        a = axes('Position',[0.847+0.015, 0.39+0.165+0.027, 0.02, 0.05]);
        a.YAxis.Visible = 'off';
        a.XAxis.Visible = 'off';
    elseif key==301
        ax.XAxis.Visible = 'on';
        a = axes('Position',[0.847+0.015, 0.11+0.168+0.029, 0.02, 0.05]);
        a.YAxis.Visible = 'off';
        a.XAxis.Visible = 'off'; 
    end    
end

% exportgraphics(gcf,'exp2_results.pdf','Resolution',300,'ContentType','vector','BackgroundColor','none')

end