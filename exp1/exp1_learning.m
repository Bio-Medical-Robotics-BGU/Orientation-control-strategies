function exp1_learning()

set(0,'defaultAxesFontSize',10);
set(0,'defaultTextFontSize',15);
set(0,'defaultTextFontName','Times');
set(0,'defaultAxesFontName','Times');
set(0,'defaultLineLineWidth',1);
set(0, 'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex');
set(0, 'defaultTextInterpreter','latex');
clear
clc
close all

load('exp1_QGS.mat')
% QGS = log10(QGS);
Np = size(QGS,1);
Ntr = size(QGS,2);

numBoot = 1E3;
conf = 0.95;
Ylim = [1 max(QGS(:))+0.1];
Xlim = [0 385];
h = figure;
h.Units = 'normalized';
h.Position = [0.0344    0.0534    0.5066    0.5];
p1 = 0.999;
p2 = 0.001;
hold on

QGSr = reshape(QGS',1,Ntr*Np);
[QGSs,inds] = sort(QGSr);
m80 = [min(QGSs(1:ceil(p1*sum(~isnan(QGSs))))) max(QGSs(1:ceil(p1*sum(~isnan(QGSs)))))];
m20 = [min(QGSs((ceil(p1*sum(~isnan(QGSs)))+1):end)) max(QGSs((ceil(p1*sum(~isnan(QGSs)))+1):end))];

cg2 = [0.4588    0.4392    0.7020];
cg1 = [0.8510    0.3725    0.0078];
for pNum = 1:size(QGS,1)
    if pNum<=7
        p = plot(1:48,QGS(pNum,1:48),'Color', cg2); p.Color(4) = 0.1;
        p = plot(50:97,QGS(pNum,49:96),'Color', cg2); p.Color(4) = 0.1;
        p = plot(99:146,QGS(pNum,97:144),'Color', cg2); p.Color(4) = 0.1;
        p = plot(148:195,QGS(pNum,145:192),'Color', cg2); p.Color(4) = 0.1;
        p = plot(197:244,QGS(pNum,193:240),'Color', cg2); p.Color(4) = 0.1;
        p = plot(246:293,QGS(pNum,241:288),'Color', cg2); p.Color(4) = 0.1;
        p = plot(295:342,QGS(pNum,289:336),'Color', cg2); p.Color(4) = 0.1;
        p = plot(344:391,QGS(pNum,337:384),'Color', cg2); p.Color(4) = 0.1;
    else
        p = plot(1:48,QGS(pNum,1:48),'Color', cg1); p.Color(4) = 0.1;
        p = plot(50:97,QGS(pNum,49:96),'Color', cg1); p.Color(4) = 0.1;
        p = plot(99:146,QGS(pNum,97:144),'Color',cg1); p.Color(4) = 0.1;
        p = plot(148:195,QGS(pNum,145:192),'Color',cg1); p.Color(4) = 0.1;
        p = plot(197:244,QGS(pNum,193:240),'Color', cg1); p.Color(4) = 0.1;
        p = plot(246:293,QGS(pNum,241:288),'Color', cg1); p.Color(4) = 0.1;
        p = plot(295:342,QGS(pNum,289:336),'Color', cg1); p.Color(4) = 0.1;
        p = plot(344:391,QGS(pNum,337:384),'Color', cg1); p.Color(4) = 0.1;
    end
end
%
p1 = plot(1:48,nanmedian(QGS(1:7,1:48)),'Color', cg2); p.Color(4) = 0.1;
p1 = plot(50:97,nanmedian(QGS(1:7,49:96)),'Color', cg2); p.Color(4) = 0.1;
p1 = plot(99:146,nanmedian(QGS(1:7,97:144)),'Color', cg2); p.Color(4) = 0.1;
p1 = plot(148:195,nanmedian(QGS(1:7,145:192)),'Color', cg2); p.Color(4) = 0.1;
p1 = plot(197:244,nanmedian(QGS(1:7,193:240)),'Color', cg2); p.Color(4) = 0.1;
p1 = plot(246:293,nanmedian(QGS(1:7,241:288)),'Color', cg2); p.Color(4) = 0.1;
p1 = plot(295:342,nanmedian(QGS(1:7,289:336)),'Color', cg2); p.Color(4) = 0.1;
p1 = plot(344:391,nanmedian(QGS(1:7,337:384)),'Color', cg2); p.Color(4) = 0.1;

p2 = plot(1:48,nanmedian(QGS(8:14,1:48)),'Color', cg1); p.Color(4) = 0.1;
p2 = plot(50:97,nanmedian(QGS(8:14,49:96)),'Color', cg1); p.Color(4) = 0.1;
p2 = plot(99:146,nanmedian(QGS(8:14,97:144)),'Color', cg1); p.Color(4) = 0.1;
p2 = plot(148:195,nanmedian(QGS(8:14,145:192)),'Color', cg1); p.Color(4) = 0.1;
p2 = plot(197:244,nanmedian(QGS(8:14,193:240)),'Color', cg1); p.Color(4) = 0.1;
p2 = plot(246:293,nanmedian(QGS(8:14,241:288)),'Color', cg1); p.Color(4) = 0.1;
p2 = plot(295:342,nanmedian(QGS(8:14,289:336)),'Color', cg1); p.Color(4) = 0.1;
p2 = plot(344:391,nanmedian(QGS(8:14,337:384)),'Color', cg1); p.Color(4) = 0.1;

ylabel('QGS')
xlabel('Trial Number');
yticks([1.2,4,7,10,13])
xticks([1,50,99,148,197,246,295,344,391])

xticklabels({'1','48','96','144','192','240','288','336','384'})
xline(49,'--','LineWidth',1);xline(98,'--','LineWidth',1);xline(147,'--','LineWidth',1);
xline(196,'--','LineWidth',1);xline(245,'--','LineWidth',1);xline(294,'--','LineWidth',1);
xline(343,'--','LineWidth',1);yline(1.2,'--','LineWidth',2)
ylim([1 13])
xlim([0 392]);

legend([p1 p2],{'Mix cond.','Separate cond.'},'box','off','location','northeastoutside')
hold

% exportgraphics(gcf,'exp1_learning.eps','Resolution',300,'ContentType','vector','BackgroundColor','none')