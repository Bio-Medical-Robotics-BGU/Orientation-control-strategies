function h = generateFig6()
%% Generate Fig6

set(0,'defaultAxesFontSize',10);
set(0,'defaultTextFontSize',15);
set(0,'defaultTextFontName','Times');
set(0,'defaultAxesFontName','Times');
set(0,'defaultLineLineWidth',1);
set(0, 'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex');
set(0, 'defaultTextInterpreter','latex');

load('exp1_QGS.mat')

Np = size(QGS,1);
Ntr = size(QGS,2);

numBoot = 1E3;
conf = 0.95;
Ylim = [0 10];
Xlim = [0 15];
h = figure;
h.Units = 'normalized';
h.Position = [0.0344    0.0534    0.5066    0.8359];
p1 = 0.8;
p2 = 0.2;
hold on
ylim(Ylim)
xlim(Xlim);

QGSr = reshape(QGS',1,Ntr*Np);
[QGSs,inds] = sort(QGSr);
QGS80 = rescale(QGSs(1:ceil(p1*sum(~isnan(QGSs)))),0,p1*10);
QGS20 = rescale(QGSs((ceil(p1*sum(~isnan(QGSs)))+1):end),p1*10+0.01,10); % including nans
QGSres = [QGS80,QGS20];
m80 = [min(QGSs(1:ceil(p1*sum(~isnan(QGSs))))) max(QGSs(1:ceil(p1*sum(~isnan(QGSs)))))];
m20 = [min(QGSs((ceil(p1*sum(~isnan(QGSs)))+1):end)) max(QGSs((ceil(p1*sum(~isnan(QGSs)))+1):end))];
for pNum=1:Np
    med = nanmedian(QGS(pNum,:));
    if med<=m80(2)
        b = bar(pNum,rescale(med,0,p1*10,"InputMax",m80(2),"InputMin",m80(1)),0.9,'FaceColor',[0.9023 0.9023 0.9023],'EdgeColor',[0.9023 0.9023 0.9023]);
    else
        b = bar(pNum,rescale(med,p1*10+0.001,10,"InputMax",m20(2),"InputMin",m20(1)),0.9,'FaceColor',[0.9023 0.9023 0.9023],'EdgeColor',[0.9023 0.9023 0.9023]);
    end
    % median CI
    [bootstat,~] = bootstrp(numBoot,@nanmedian,QGS(pNum,:));
    ci = quantile(bootstat,[(1-conf)/2,(1+conf)/2]);
    if ci(2)<=m80(2)
        cir = rescale(ci,0,p1*10,"InputMax",m80(2),"InputMin",m80(1));
        medr = rescale(med,0,p1*10,"InputMax",m80(2),"InputMin",m80(1));
        e = errorbar(pNum,medr,medr - cir(1),cir(2) - medr,'Color','k','LineWidth',0.5,'LineStyle','none');   
    else
        cir = rescale(ci,0,p1*10,"InputMax",m80(2),"InputMin",m80(1));
        medr = rescale(med,0,p1*10+0.001,"InputMax",m20(2),"InputMin",m20(1));
        e = errorbar(pNum,medr,medr - cir(1),cir(2) - medr,'Color','k','LineWidth',0.5,'LineStyle','none');   
    end

    thisrange = (1+Ntr*(pNum-1)):Ntr*pNum; 
    thisinds = find(ismember(inds,thisrange));
    thisQGS = QGSres(thisinds);
    thisQGS80 = thisQGS(thisQGS<=max(QGS80));
    thisQGS20 = thisQGS(thisQGS>=min(QGS20));
    N80 = length(thisQGS80);
    N20 = length(thisQGS20);
    s80 = scatter(pNum*ones(N80,1)+unifrnd(-0.25,0.25,N80,1),thisQGS80,2, [0.4588    0.4392    0.7020],'filled');
    s20 = scatter(pNum*ones(N20,1)+unifrnd(-0.25,0.25,N20,1),thisQGS20,2, [ 0.8510    0.3725    0.0078],'filled');
end
yline(p1*10*(1.2-m80(1))/(m80(2)-m80(1)),'--','LineWidth',1)

legend([s80,s20,b,e],'QGS - lowest 80\%','QGS - highest 20\%','median','95\% CI','box','off','location','northeast')
ylabel('QGS');
xlabel('Participants');

Yticks80 = 0:p1*10;
Yticks20 = p1*10:10;
Ytickslabels80 = rescale(Yticks80,m80(1),m80(2));
Ytickslabels20 = rescale(Yticks20,m20(1),m20(2));
for i=1:length(Yticks80)
    Ytickslabels80str{i} = num2str(round(Ytickslabels80(i),2));
end
for i=2:length(Yticks20)
    Ytickslabels20str{i-1} = num2str(round(Ytickslabels20(i),2));
end
yticks(0:10)
Ytickslabels = [Ytickslabels80str, Ytickslabels20str];
yticklabels(Ytickslabels);
xticks(1:Np);
xticklabels({'$\mathrm{p_1}$','$\mathrm{p_2}$','$\mathrm{p_3}$','$\mathrm{p_0}$',...
    '$\mathrm{p_5}$','$\mathrm{p_6}$','$\mathrm{p_7}$','$\mathrm{p_8}$','$\mathrm{p_9}$',...
    '$\mathrm{p_{10}}$','$\mathrm{p_{11}}$','$\mathrm{p_{12}}$','$\mathrm{p_{13}}$','$\mathrm{p_{14}}$'});

a = axes('Position',[0.124,0.754,0.015,0.02]);
line([0 0.7],[0 0.6],'Color','k','LineWidth',0.5)
line([0 0.7],[0.2 0.8],'Color','k','LineWidth',0.5)
xlim([0 1]);
ylim([0 1]);
a.YAxis.Visible = 'off';
a.XAxis.Visible = 'off';
end